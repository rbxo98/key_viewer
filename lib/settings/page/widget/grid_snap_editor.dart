import 'dart:math' as math;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:key_viewer_v2/core/model/key/key_tile_data_model.dart';
import 'package:key_viewer_v2/core/widget/key_tile_widget.dart';
import 'package:key_viewer_v2/settings/page/widget/key_tile_settings_dialog.dart';
import 'package:flutter/scheduler.dart' show Ticker;
import 'dart:ui' as ui;

/// 격자 사양: 1칸 픽셀(cell) + 구분선(gap) = pitch
class SnapGridSpec {
  final double cell; // 1칸 크기(px)
  final double gap;  // 구분선 두께(px)
  const SnapGridSpec({this.cell = 4, this.gap = 1});
  double get pitch => cell + gap;
}

/// 히스토리 이동 축(기본: 위로)
enum HistoryAxis {
  verticalUp("위"),
  verticalDown("아래"),
  horizontalLeft("왼쪽"),
  horizontalRight("오른쪽"),
  ;

  final String optionName;
  const HistoryAxis(this.optionName);

  static HistoryAxis fromJson(String key) => HistoryAxis.values.firstWhere((e) => e.name == key);
  static String toJson(HistoryAxis axis) => axis.name;
}

/// 완료된 바(고정 높이 + 페이드아웃)
class _CompletedBar {
  final DateTime createdAt;
  final double height; // 픽셀
  _CompletedBar({required this.createdAt, required this.height});
}

class GridSnapEditor extends StatefulWidget {
  /// 고정 크기. 지정하지 않으면 부모 제약을 꽉 채움(Expanded 권장).
  final Size? areaSize;

  /// 배치 대상 타일 집합(모델). 외부에서 바뀌면 동기화됨.
  final Set<KeyTileDataModel> targetKeyList;

  /// 현재 눌려있는 VK 코드들. 타일의 b.key가 포함되면 pressed로 렌더.
  final Set<int> pressedKeySet;

  /// 격자 스펙
  final SnapGridSpec grid;

  /// 드래그 종료 시 최신 스냅샷 전달
  final ValueChanged<Set<KeyTileDataModel>>? onChanged;

  /// 에디터 픽셀 사이즈 변경 시 호출
  final ValueChanged<Size>? onPixelSizeChanged;

  /// 편집 가능 여부(false면 viewer)
  final bool isEditor;

  /// 배경/격자 표시 여부
  final bool showBackground;

  /// 드래그 중 실시간 스냅 이동 여부
  final bool liveSnap;

  /// 스타일
  final Color backgroundColor;
  final Color gridLineColor;
  final double gridLineOpacity;

  final ValueChanged<Size>? onInitialize;

  final double historyBandPx;

  final bool showKeyCount;

  /// 히스토리바 방향 (PresetModel에서 전달)
  final HistoryAxis historyAxis;

  const GridSnapEditor({
    super.key,
    this.areaSize,
    required this.targetKeyList,
    required this.pressedKeySet,
    this.grid = const SnapGridSpec(),
    this.onChanged,
    this.onPixelSizeChanged,
    this.onInitialize,
    this.isEditor = true,
    this.showBackground = true,
    this.liveSnap = true,
    this.backgroundColor = const Color(0xFF2F3337),
    this.gridLineColor = Colors.white,
    this.gridLineOpacity = 0.06,
    this.historyBandPx = 120,
    this.showKeyCount = false,
    this.historyAxis = HistoryAxis.verticalUp,
  });

  @override
  State<GridSnapEditor> createState() => _GridSnapEditorState();
}

class _GridSnapEditorState extends State<GridSnapEditor> with TickerProviderStateMixin {
  late List<KeyTileDataModel> _tiles; // 내부 편집 버퍼
  // 추가: 렌더 상태를 가진 런타임 래퍼
  late List<_KeyTileRuntime> _runtimeTiles;
  String? _dragId;
  Offset _dragStartLocal = Offset.zero;
  late int _startGx, _startGy;
  Size _lastSize = Size.zero;

  // liveSnap=false일 때, 드래그 델타를 임시로 들고 있다가 드롭 시 반영
  int _pendingDgx = 0;
  int _pendingDgy = 0;

  double get _pitch => widget.grid.pitch;

  bool _didFireInitialize = false;
  final GlobalKey _rootKey = GlobalKey();

// 클래스 필드
  bool _dragMoved = false;             // 실제 이동 발생 여부
  bool _suppressTapOnce = false;       // 드래그 끝난 직후 탭 1회만 무시
  Offset? _downPos;
  static const double _dragSlop = 3.0; // kTouchSlop 정도

  // 히스토리 상태
  final Map<int, DateTime> _pressStartAt = {};                     // keyCode -> 누르기 시작 시간
  final Map<int, List<_CompletedBar>> _completedBars = {};         // keyCode -> 완료바들
  late final Ticker _ticker;                                       // 애니메이션 틱
  DateTime _now = DateTime.now();

  // VK(KeyCode) -> 해당 키를 쓰는 런타임들 (동일 키를 여러 타일이 공유해도 대응)
  final Map<int, List<_KeyTileRuntime>> _byKeyCode = {};

  // 설정값(원하면 AppConfig로 빼도 됨)
  static const double _barMin = 6;            // 라이브 바 최소 높이(px)
  static const double _barMax = 240;          // 라이브 바 최대 높이(px)
  static const double _barSpeed = 140;        // px/sec
  static const double _fadeOutSec = 1.2;      // 완료바 유지 시간
  static const double _fadeStartRatio = 0.7;  // 마지막 구간부터 페이드
  static const double _barRadius = 6;         // 라운드
  static const double _shadowBlur = 6;
  static const double _shadowOpacity = .25;
  // 히스토리 파라미터(원하면 AppConfig로 이동)
  static const double _BAR_MIN = 6;
  static const double _BAR_MAX = 240;
  static const double _BAR_SPEED = 140;      // px/sec
  static const double _FADE_SEC = 1.2;
  static const double _FADE_START_RATIO = .7;
  static const double _BAR_RADIUS = 6;
  static const double _SHADOW_BLUR = 6;
  static const double _SHADOW_OPACITY = .25;

  // 키별 축(확장 포인트) — PresetModel의 historyAxis 사용
  HistoryAxis _axisFor(int keyCode) {
    // 모든 키가 동일한 방향 사용 (PresetModel.historyAxis)
    return widget.historyAxis;
  }



  // 타일 -> 픽셀 사각형
  Rect _tileRect(KeyTileDataModel b) {
    final left = _xPx(b.gx);
    final top  = _yPx(b.gy);
    final w    = _wPx(b.gw);
    final h    = _hPx(b.gh);
    return Rect.fromLTWH(left, top, w, h);
  }


  bool _hasVisibleCompletedBars(DateTime now) {
    for (final list in _completedBars.values) {
      for (final b in list) {
        final t = now.difference(b.createdAt).inMilliseconds / 1000.0;
        if (t >= 0 && t < _fadeOutSec) return true;
      }
    }
    return false;
  }


  // 방향별 시작점 계산
  double get _getStartPoint {
    if (_tiles.isEmpty) return widget.historyBandPx;

    switch (widget.historyAxis) {
      case HistoryAxis.verticalUp:
      // 가장 위쪽 타일의 상단
        double minTop = double.infinity;
        for (final t in _tiles) {
          final top = _yPx(t.gy);
          if (top < minTop) minTop = top;
        }
        return minTop.isFinite ? minTop : widget.historyBandPx;

      case HistoryAxis.verticalDown:
      // 가장 아래쪽 타일의 하단
        double maxBottom = 0;
        for (final t in _tiles) {
          final bottom = _yPx(t.gy + t.gh);
          if (bottom > maxBottom) maxBottom = bottom;
        }
        return maxBottom;

      case HistoryAxis.horizontalLeft:
      // 가장 왼쪽 타일의 좌단
        double minLeft = double.infinity;
        for (final t in _tiles) {
          final left = _xPx(t.gx);
          if (left < minLeft) minLeft = left;
        }
        return minLeft.isFinite ? minLeft : 0;

      case HistoryAxis.horizontalRight:
      // 가장 오른쪽 타일의 우단
        double maxRight = 0;
        for (final t in _tiles) {
          final right = _xPx(t.gx + t.gw);
          if (right > maxRight) maxRight = right;
        }
        return maxRight;
    }
  }

  @override
  void initState() {
    super.initState();
    _tiles = widget.targetKeyList.map((e) => e.copyWith()).toList();
    _rebuildRuntimeTiles(preserveHistory: false);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _tryFireInitialize();
    });

    // 틱커: 히스토리만 계속 리페인트
    _ticker = createTicker((_) {
      _now = DateTime.now();
      setState(() {});
    });
    _ticker.start();

  }

  void _rebuildRuntimeTiles({required bool preserveHistory}) {
    // 기존 history를 primaryKey 기준으로 승계
    final Map<String, _KeyHistoryState> prev = {};
    if (preserveHistory && (_runtimeTiles).isNotEmpty) {
      for (final rt in _runtimeTiles) {
        prev[rt.model.primaryKey] = rt.history;
      }
    }

    _runtimeTiles = _tiles.map((m) {
      final rt = _KeyTileRuntime(
        model: m,
        historyColor: Color(m.style.historyBarColor),
        axis: _axisFor(m.key), // 키코드에 따라 방향 설정
      );
      if (preserveHistory) {
        final saved = prev[m.primaryKey];
        if (saved != null) {
          rt.history.pressStartAt = saved.pressStartAt;
          rt.history.completed
            ..clear()
            ..addAll(saved.completed);
        }
      }
      return rt;
    }).toList();

    _byKeyCode
        .clear();
    for (final rt in _runtimeTiles) {
      (_byKeyCode[rt.model.key] ??= []).add(rt);
    }
  }

  bool _hasAnyHistoryToPaint() {
    // 라이브 바가 하나라도 있으면 true
    for (final rt in _runtimeTiles) {
      if (rt.history.pressStartAt != null) return true;
    }
    // 완료 바가 페이드 시간 동안 존재하면 true
    for (final rt in _runtimeTiles) {
      for (final c in rt.history.completed) {
        final t = _now.difference(c.createdAt).inMilliseconds / 1000.0;
        if (t >= 0 && t < _FADE_SEC) return true;
      }
    }
    return false;
  }


  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  Future<void> _tryFireInitialize() async {
    if (_didFireInitialize || !mounted) return;

    // areaSize가 주어졌으면 그걸로 바로 호출
    if (widget.areaSize != null && widget.areaSize != Size.zero) {
      _didFireInitialize = true;
      widget.onInitialize?.call(widget.areaSize!);
      return;
    }

    // root 컨텍스트에서 실측 사이즈를 읽음
    final ctx = _rootKey.currentContext;
    Size? size = ctx?.size;
    while(!(size != null && size != Size.zero)){
      await Future.delayed(Duration(milliseconds: 100));
      size = ctx?.size;
    }
    _didFireInitialize = true;
    widget.onInitialize?.call(size);
  }

  @override
  void didUpdateWidget(covariant GridSnapEditor oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 외부 데이터 변경 시 동기화
    if (!identical(oldWidget.targetKeyList, widget.targetKeyList)) {
      _tiles = widget.targetKeyList.map((e) => e.copyWith()).toList();
      _rebuildRuntimeTiles(preserveHistory: true);
    }
    // 격자 변경 → 클램프
    if (oldWidget.grid.pitch != widget.grid.pitch && _lastSize != Size.zero) {
      for (final b in _tiles) _clampGrid(b, _lastSize);
      setState(() {});
    }

    if (!setEquals(oldWidget.pressedKeySet, widget.pressedKeySet)) {
      final now = DateTime.now();

      // 눌림
      for (final vk in widget.pressedKeySet) {
        final list = _byKeyCode[vk];
        if (list == null) continue;
        for (final rt in list) {
          rt.history.pressStartAt ??= now;
        }
      }

      // 해제
      for (final vk in oldWidget.pressedKeySet.difference(widget.pressedKeySet)) {
        final list = _byKeyCode[vk];
        if (list == null) continue;
        for (final rt in list) {
          final start = rt.history.pressStartAt;
          if (start != null) {
            final elapsed = now.difference(start).inMilliseconds / 1000.0;
            final h = (elapsed * _BAR_SPEED).clamp(_BAR_MIN, _BAR_MAX);
            rt.history.completed.insert(0, _CompletedBar(createdAt: now, height: h));
            rt.history.pressStartAt = null;
            rt.history.completed.removeWhere((c) =>
            now.difference(c.createdAt).inMilliseconds / 1000.0 >= _FADE_SEC + 0.5);
          }
        }
      }

      // ☆ 최초 입력 프레임에 즉시 그리기
      if (mounted) setState(() {});
    }
  }


  // grid -> px
  double _xPx(int gx) => gx * _pitch;
  double _yPx(int gy) => gy * _pitch;
  double _wPx(int gw) => gw * _pitch;
  double _hPx(int gh) => gh * _pitch;

  // px → grid 델타(round)
  int _dxToG(double dx) => (dx / _pitch).round();
  int _dyToG(double dy) => (dy / _pitch).round();

  /// 개별 타일을 현재 뷰포트(area)에 맞게 이동(클램프)한다.
  /// 이동이 발생했으면 true 반환.
// 클램프 시 usableH에서 historyBandPx만큼 빼줌 (타일이 위로 못 침범)
  bool _clampGrid(KeyTileDataModel b, Size area) {
    const double epsilon = 2.0;
    final usableW = area.width  - _wPx(b.gw) - epsilon;
    final usableH = area.height - widget.historyBandPx - _hPx(b.gh) - epsilon; // ☆

    final maxGx = math.max(0, (usableW / _pitch).floor());
    final maxGy = math.max(0, (usableH / _pitch).floor());

    final newGx = b.gx.clamp(0, maxGx);
    final newGy = b.gy.clamp(0, maxGy);

    final moved = (newGx != b.gx) || (newGy != b.gy);
    b.gx = newGx;
    b.gy = newGy;
    return moved;
  }

  /// 모든 타일을 현재 뷰포트에 맞춰 이동하고,
  /// 필요 시 setState + onChange까지 해주는 헬퍼.
  void _applyViewportClamp(Size area, {bool notify = false}) {
    bool movedAny = false;
    for (final b in _tiles) {
      if (_clampGrid(b, area)) movedAny = true;
    }
    if (movedAny) {
      // build 중 setState 금지: 다음 프레임에 반영
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        setState(() {});
        if (notify) {
          final snapshot = _tiles.map((e) => e.copyWith()).toSet();
          widget.onChanged?.call(snapshot);
        }
      });
    }
  }



  void _beginDrag(KeyTileDataModel b, Offset localPos) {
    if (!widget.isEditor) return;
    setState(() {
      _dragId = b.primaryKey;
      _dragStartLocal = localPos;
      _startGx = b.gx;
      _startGy = b.gy;
      _pendingDgx = 0;
      _pendingDgy = 0;
    });
  }

  void _updateDrag(Offset localPos) {
    if (!widget.isEditor) return;
    if (_dragId == null) return;
    final i = _tiles.indexWhere((e) => e.primaryKey == _dragId);
    if (i < 0) return;

    final b = _tiles[i];
    final delta = localPos - _dragStartLocal;
    final dgx = _dxToG(delta.dx);
    final dgy = _dyToG(delta.dy);

    if (widget.liveSnap) {
      b.gx = _startGx + dgx;
      b.gy = _startGy + dgy;
      _clampGrid(b, _lastSize);
      setState(() {});
    } else {
      // 드롭 때 적용하기 위해 보관만
      setState(() {
        _pendingDgx = dgx;
        _pendingDgy = dgy;
      });
    }
  }

  void _endDrag() {
    if (!widget.isEditor) return;
    if (_dragId == null) return;
    final i = _tiles.indexWhere((e) => e.primaryKey == _dragId);
    if (i >= 0) {
      final b = _tiles[i];
      if (!widget.liveSnap) {
        b.gx = _startGx + _pendingDgx;
        b.gy = _startGy + _pendingDgy;
        _clampGrid(b, _lastSize);
      } else {
        _clampGrid(b, _lastSize);
      }
    }
    final snapshot = _tiles.map((e) => e.copyWith()).toSet();
    setState(() => _dragId = null);
    widget.onChanged?.call(snapshot);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final effectiveSize = widget.areaSize ??
          Size(
            constraints.hasBoundedWidth ? constraints.maxWidth : 600,
            constraints.hasBoundedHeight ? constraints.maxHeight : 400,
          );

      if (effectiveSize != _lastSize) {
        _lastSize = effectiveSize;
        _applyViewportClamp(effectiveSize, notify: true);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) widget.onPixelSizeChanged?.call(effectiveSize);
        });
      }

      final children = <Widget>[];

      // 배경/격자
      if (widget.showBackground) {
        children.addAll([
          Positioned.fill(child: Container(color: widget.backgroundColor)),
          Positioned.fill(
            child: CustomPaint(
              painter: _GridPainter(
                pitch: _pitch,
                lineColor: widget.gridLineColor.withOpacity(widget.gridLineOpacity),
              ),
            ),
          ),
        ]);
      }

      // 키 타일
      for (final b in _tiles) {
        final pressed = widget.pressedKeySet.contains(b.key);
        final tile = KeyTile(pressed: pressed, keyTileDataModel: b, showKeyCount: widget.showKeyCount);

        Widget content = tile;
        if (widget.isEditor) {
          content = Listener(
            behavior: HitTestBehavior.deferToChild, // ← opaque 대신
            onPointerDown: (e) {
              _downPos = e.localPosition;
              _dragMoved = false;
              _beginDrag(b, e.localPosition);
            },
            onPointerMove: (e) {
              if (_downPos != null &&
                  (e.localPosition - _downPos!).distance > _dragSlop) {
                _dragMoved = true;
              }
              _updateDrag(e.localPosition);
            },
            onPointerUp: (_) {
              _endDrag();
              // 실제로 움직였을 때만 다음 탭 1회 차단
              _suppressTapOnce = _dragMoved;
              _downPos = null;
              _dragMoved = false;  // ← 즉시 리셋 (다음 제스처에 영향 X)
            },
            onPointerCancel: (_) {
              _endDrag();
              _downPos = null;
              _dragMoved = false;
              _suppressTapOnce = false;
            },
            child: GestureDetector(
              onTap: () async {
                // 드래그 직후 1회만 탭 무시
                if (_suppressTapOnce) {
                  _suppressTapOnce = false; // 한 번만 먹이고 해제
                  return;
                }

                final data = await showDialog<KeyTileDataModel>(
                  context: context,
                  builder: (_) => KeyTileSettingDialog(
                    keyTileData: b,
                    cellPx: _pitch,
                  ),
                );
                if (data != null) {
                  final idx = _tiles.indexWhere((e) => e.primaryKey == b.primaryKey);
                  if (idx >= 0) {
                    final updated = data.copyWith();
                    _clampGrid(updated, _lastSize);
                    if (!updated.isDeleted) {
                      setState(() => _tiles[idx] = updated);
                    } else {
                      setState(() => _tiles.removeAt(idx));
                    }
                    _rebuildRuntimeTiles(preserveHistory: true);
                    final snapshot = _tiles.map((e) => e.copyWith()).toSet();
                    widget.onChanged?.call(snapshot);
                  }
                }
              },
              child: tile,
            ),
          );
        } else {
          content = IgnorePointer(child: tile);
        }

        final r = _tileRect(b);
        children.add(Positioned(
          left: _xPx(b.gx),
          top:  _yPx(b.gy) + widget.historyBandPx, // ☆ 상단 밴드만큼 내림
          width: _wPx(b.gw),
          height:_hPx(b.gh),
          child: content,
        ));
      }

      // ===== 히스토리 오버레이 =====
      children.add(
        Positioned.fill(
          child: IgnorePointer(
            child: CustomPaint(
              painter: _HistoryPainter(
                now: _now,
                runtimeTiles: _runtimeTiles,
                startPoint: _getStartPoint, // 방향별 시작점
                tileRectOf: _tileRect,
                liveColorOf: (rt) => rt.historyColor.withOpacity(0.90),
                doneColorOf: (rt) => rt.historyColor.withOpacity(0.65),
                fadeSpanPx: widget.historyBandPx,
                historyBandPx: widget.historyBandPx, // 히스토리 밴드 높이 전달
                historyAxis: widget.historyAxis, // 히스토리 방향 전달
                params: _HistoryParams(
                  barMin: _BAR_MIN,
                  barMax: _BAR_MAX,
                  fadeSec: _FADE_SEC,
                  fadeStartRatio: _FADE_START_RATIO,
                  barRadius: _BAR_RADIUS,
                  shadowBlur: _SHADOW_BLUR,
                  shadowOpacity: _SHADOW_OPACITY,
                  trailSpeed: _BAR_SPEED, // 완료바가 떠오르는 속도
                ),

              ),

            ),
          ),
        ),
      );



      return SizedBox(
        key: _rootKey,
        width: effectiveSize.width,
        height: effectiveSize.height,
        child: Stack(children: children),
      );
    });
  }

}

class _GridPainter extends CustomPainter {
  final double pitch;
  final Color lineColor;
  _GridPainter({required this.pitch, required this.lineColor});

  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = lineColor
      ..strokeWidth = 1;

    for (double x = 0; x <= size.width; x += pitch) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), p);
    }
    for (double y = 0; y <= size.height; y += pitch) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), p);
    }
  }

  @override
  bool shouldRepaint(covariant _GridPainter old) =>
      old.pitch != pitch || old.lineColor != lineColor;
}

class _HistoryParams {
  final double barMin, barMax, fadeSec, fadeStartRatio, barRadius, shadowBlur, shadowOpacity;
  final double trailSpeed; // ☆ 추가
  final double outlineWidth;
  final Color? outlineColor;
  const _HistoryParams({
    required this.barMin,
    required this.barMax,
    required this.fadeSec,
    required this.fadeStartRatio,
    required this.barRadius,
    required this.shadowBlur,
    required this.shadowOpacity,
    this.trailSpeed = 140, // 기본값: 라이브 바 속도와 동일
    this.outlineWidth = 0.0,
    this.outlineColor,
  });
}


class _HistoryPainter extends CustomPainter {
  final DateTime now;
  final List<_KeyTileRuntime> runtimeTiles;
  final double startPoint; // (더 이상 사용하지 않지만 시그니처는 유지)
  final Rect Function(KeyTileDataModel) tileRectOf;
  final Color Function(_KeyTileRuntime) liveColorOf;
  final Color Function(_KeyTileRuntime) doneColorOf;
  final _HistoryParams params;
  final double historyBandPx;
  final HistoryAxis historyAxis;

  // (사용 안 해도 시그니처 유지)
  final double fadeStartFromBottomPx;
  final double fadeSpanPx;

  const _HistoryPainter({
    required this.now,
    required this.runtimeTiles,
    required this.startPoint,
    required this.tileRectOf,
    required this.liveColorOf,
    required this.doneColorOf,
    required this.params,
    required this.historyBandPx,
    required this.historyAxis,
    this.fadeStartFromBottomPx = 140,
    this.fadeSpanPx = 60,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // z-index 수집/정렬
    final allZIndexes = runtimeTiles
        .map((rt) => rt.model.style.historyBarZIndex)
        .toSet()
        .toList()
      ..sort();

    // z-index별 그룹
    final Map<int, List<_KeyTileRuntime>> groupsByZIndex = {};
    for (final rt in runtimeTiles) {
      (groupsByZIndex[rt.model.style.historyBarZIndex] ??= <_KeyTileRuntime>[]).add(rt);
    }
    for (final z in allZIndexes) {
      final g = groupsByZIndex[z] ?? [];
      g.sort((a, b) {
        final y = a.model.gy.compareTo(b.model.gy);
        if (y != 0) return y;
        final x = a.model.gx.compareTo(b.model.gx);
        if (x != 0) return x;
        return a.model.primaryKey.compareTo(b.model.primaryKey);
      });
    }

    // 1) 화면상의 타일 슬롯(모두 historyBandPx 반영)과 전역 시작선 계산
    final List<Rect> slotsVisual = [
      for (final rt in runtimeTiles) tileRectOf(rt.model).translate(0, historyBandPx),
    ];
    final double minTop    = slotsVisual.isEmpty ? 0 : slotsVisual.map((r) => r.top).reduce(math.min);
    final double maxBottom = slotsVisual.isEmpty ? 0 : slotsVisual.map((r) => r.bottom).reduce(math.max);
    final double minLeft   = slotsVisual.isEmpty ? 0 : slotsVisual.map((r) => r.left).reduce(math.min);
    final double maxRight  = slotsVisual.isEmpty ? 0 : slotsVisual.map((r) => r.right).reduce(math.max);

    // 2) z-index 순서대로 렌더
    for (final z in allZIndexes) {
      final group = groupsByZIndex[z] ?? [];
      for (final rt in group) {
        // 이 타일의 화면상 슬롯
        final slot = tileRectOf(rt.model).translate(0, historyBandPx);

        // ---- 완료 바(릴리즈 후) ----
        for (final c in rt.history.completed) {
          final tSec = now.difference(c.createdAt).inMilliseconds / 1000.0;
          if (tSec < 0) continue;

          final double magnitude = c.height; // 진행축 길이
          double baseX = 0, baseY = 0;
          bool skip = false;

          switch (rt.axis) {
          // 1) 위쪽: x=타일 x, y=모든 타일 중 최상단 윗변에서 위로 이동
            case HistoryAxis.verticalUp:
              baseX = slot.left;
              baseY = minTop - tSec * params.trailSpeed;
              // 화면 밖으로 완전히 벗어나면 스킵
              if (baseY + magnitude <= 0) skip = true;
              break;

          // 2) 아래쪽: x=타일 x, y=모든 타일 중 최하단 아랫변에서 아래로 이동
            case HistoryAxis.verticalDown:
              baseX = slot.left;
              baseY = maxBottom + tSec * params.trailSpeed;
              if (baseY >= size.height) skip = true;
              break;

          // 3) 오른쪽: x=모든 타일 중 최우단 우변에서 오른쪽으로, y=타일 y
            case HistoryAxis.horizontalRight:
              baseX = maxRight + tSec * params.trailSpeed;
              baseY = slot.top;
              if (baseX >= size.width) skip = true;
              break;

          // 4) 왼쪽: x=모든 타일 중 최좌단 좌변에서 왼쪽으로, y=타일 y
            case HistoryAxis.horizontalLeft:
              baseX = minLeft - tSec * params.trailSpeed;
              baseY = slot.top;
              if (baseX + magnitude <= 0) skip = true;
              break;
          }

          if (!skip) {
            _drawHistoryBarMasked(
              canvas, size, slot, rt.axis,
              magnitude: magnitude,
              baseX: baseX,
              baseY: baseY,
              color: doneColorOf(rt),
              withShadow: true,
              // (마스크 함수는 내부에서 축별 페이드존을 계산하므로 아래 값들은 의미상만 전달)
              fadeTopY: 0,
              fadeBottomY: 0,
              outlineWidth: params.outlineWidth,
              outlineColor: params.outlineColor ?? doneColorOf(rt),
            );
          }
        }

        // ---- 라이브 바(누르는 중) ----
        final start = rt.history.pressStartAt;
        if (start != null) {
          final elapsed = now.difference(start).inMilliseconds / 1000.0;
          final h = (elapsed * _GridSnapEditorState._BAR_SPEED)
              .clamp(params.barMin, params.barMax);

          double baseX = 0, baseY = 0;

          switch (rt.axis) {
          // 1) 위쪽: x=타일 x, y=모든 타일 중 최상단 윗변(고정)
            case HistoryAxis.verticalUp:
              baseX = slot.left;
              baseY = minTop;
              break;

          // 2) 아래쪽: x=타일 x, y=모든 타일 중 최하단 아랫변(고정)
            case HistoryAxis.verticalDown:
              baseX = slot.left;
              baseY = maxBottom;
              break;

          // 3) 오른쪽: x=모든 타일 중 최우단 우변(고정), y=타일 y
            case HistoryAxis.horizontalRight:
              baseX = maxRight;
              baseY = slot.top;
              break;

          // 4) 왼쪽: x=모든 타일 중 최좌단 좌변(고정), y=타일 y
            case HistoryAxis.horizontalLeft:
              baseX = minLeft;
              baseY = slot.top;
              break;
          }

          _drawHistoryBarMasked(
            canvas, size, slot, rt.axis,
            magnitude: h,
            baseX: baseX,
            baseY: baseY,
            color: liveColorOf(rt),
            withShadow: false,
            fadeTopY: 0,
            fadeBottomY: 0,
            outlineWidth: params.outlineWidth,
            outlineColor: params.outlineColor ?? liveColorOf(rt),
          );
        }
      }
    }
  }

  // 축별 페이드 마스크 범위(기존 로직 유지)
  (double fadeStart, double fadeEnd) _getFadeZone(Size size, HistoryAxis axis) {
    switch (axis) {
      case HistoryAxis.verticalUp:
        return (historyBandPx, 0.0);
      case HistoryAxis.verticalDown:
        return (size.height - fadeSpanPx, size.height);
      case HistoryAxis.horizontalLeft:
        return (fadeSpanPx, 0.0);
      case HistoryAxis.horizontalRight:
        return (size.width - fadeSpanPx, size.width);
    }
  }

  void _drawHistoryBarMasked(
      Canvas canvas,
      Size size,
      Rect tileRect,
      HistoryAxis axis, {
        required double magnitude,
        required double baseX,
        required double baseY,
        required Color color,
        required bool withShadow,
        required double fadeTopY,   // 의미상 파라미터, 실제 마스크는 _getFadeZone 사용
        required double fadeBottomY,// 의미상 파라미터
        double outlineWidth = 0.0,
        Color? outlineColor,
      }) {
    if (magnitude <= 0) return;

    late RRect rr;
    switch (axis) {
      case HistoryAxis.verticalUp:
        rr = RRect.fromRectAndRadius(
          Rect.fromLTWH(tileRect.left, baseY - magnitude, tileRect.width, magnitude),
          Radius.circular(params.barRadius),
        );
        break;
      case HistoryAxis.verticalDown:
        rr = RRect.fromRectAndRadius(
          Rect.fromLTWH(tileRect.left, baseY, tileRect.width, magnitude),
          Radius.circular(params.barRadius),
        );
        break;
      case HistoryAxis.horizontalLeft:
        rr = RRect.fromRectAndRadius(
          Rect.fromLTWH(baseX - magnitude, tileRect.top, magnitude, tileRect.height),
          Radius.circular(params.barRadius),
        );
        break;
      case HistoryAxis.horizontalRight:
        rr = RRect.fromRectAndRadius(
          Rect.fromLTWH(baseX, tileRect.top, magnitude, tileRect.height),
          Radius.circular(params.barRadius),
        );
        break;
    }

    final strokePad = (outlineWidth > 0) ? (outlineWidth / 2.0 + 1.0) : 1.0;
    final shadowPad = (withShadow ? params.shadowBlur : 0.0) + 2.0;
    final pad = strokePad > shadowPad ? strokePad : shadowPad;
    final layerBounds = rr.outerRect.inflate(pad);

    canvas.saveLayer(layerBounds, Paint());

    if (withShadow) {
      final sp = Paint()
        ..isAntiAlias = true
        ..color = color.withOpacity(params.shadowOpacity)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, params.shadowBlur);
      canvas.drawRRect(rr.shift(const Offset(0, 2)), sp);
    }

    final fp = Paint()..isAntiAlias = true..color = color;
    canvas.drawRRect(rr, fp);

    if (outlineWidth > 0.0) {
      final op = Paint()
        ..isAntiAlias = true
        ..style = PaintingStyle.stroke
        ..strokeWidth = outlineWidth
        ..color = (outlineColor ?? color);
      canvas.drawRRect(rr, op);
    }

    // 방향별 페이드 마스크
    final (fadeStart, fadeEnd) = _getFadeZone(size, axis);

    late Offset gradientStart, gradientEnd;
    late List<double> stops;

// t는 gradientStart→gradientEnd로 0..1
    switch (axis) {
      case HistoryAxis.verticalUp:
      // bottom(0,size.h) -> top(0,0)
        gradientStart = Offset(0, size.height);
        gradientEnd   = const Offset(0, 0);
        final tStart = (size.height - fadeStart) / size.height; // 증가 순서 보장
        final tEnd   = (size.height - fadeEnd  ) / size.height;
        stops = [0.0, tStart.clamp(0, 1), tEnd.clamp(0, 1), 1.0];
        break;

      case HistoryAxis.verticalDown:
      // top(0,0) -> bottom(0,size.h)
        gradientStart = const Offset(0, 0);
        gradientEnd   = Offset(0, size.height);
        final tStart = (fadeStart) / size.height;
        final tEnd   = (fadeEnd  ) / size.height;
        stops = [0.0, tStart.clamp(0, 1), tEnd.clamp(0, 1), 1.0];
        break;

      case HistoryAxis.horizontalLeft:
      // right(size.w,0) -> left(0,0)
        gradientStart = Offset(size.width, 0);
        gradientEnd   = const Offset(0, 0);
        final tStart = (size.width - fadeStart) / size.width;
        final tEnd   = (size.width - fadeEnd  ) / size.width;
        stops = [0.0, tStart.clamp(0, 1), tEnd.clamp(0, 1), 1.0];
        break;

      case HistoryAxis.horizontalRight:
      // left(0,0) -> right(size.w,0)
        gradientStart = const Offset(0, 0);
        gradientEnd   = Offset(size.width, 0);
        final tStart = (fadeStart) / size.width;
        final tEnd   = (fadeEnd  ) / size.width;
        stops = [0.0, tStart.clamp(0, 1), tEnd.clamp(0, 1), 1.0];
        break;
    }

// ⚠️ 정렬 금지: ..sort() 제거
    final shaderPaint = Paint()
      ..isAntiAlias = true
      ..blendMode = BlendMode.dstIn
      ..shader = ui.Gradient.linear(
        gradientStart,
        gradientEnd,
        const [Colors.white, Colors.white, Colors.transparent, Colors.transparent],
        stops,
      );

    canvas.drawRect(layerBounds, shaderPaint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _HistoryPainter old) {
    return old.now != now ||
        !identical(old.runtimeTiles, runtimeTiles) ||
        old.historyAxis != historyAxis ||
        old.params != params ||
        old.historyBandPx != historyBandPx ||
        old.fadeSpanPx != fadeSpanPx;
  }
}



/// 타일 1개에 대한 히스토리 상태(런타임 전용)
class _KeyHistoryState {
  DateTime? pressStartAt;                // 누르는 중이면 시각 보관
  final List<_CompletedBar> completed = []; // 놓은 뒤의 바(페이드 중)
}

/// 타일+히스토리 상태를 묶은 런타임 컨테이너
class _KeyTileRuntime {
  KeyTileDataModel model;
  final _KeyHistoryState history = _KeyHistoryState();

  // 타일별 이동 축 (추후 UI에서 수정 가능)
  HistoryAxis axis;

  // 타일별 히스토리 색상(원하면 KeyTileDataModel에 색상 필드 만들어 전달해도 됨)
  Color historyColor;

  _KeyTileRuntime({
    required this.model,
    this.axis = HistoryAxis.verticalUp,
    required this.historyColor, // cyan-ish
  });
}