import 'dart:math' as math;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:key_viewer_v2/core/model/key/key_tile_data_model.dart';
import 'package:key_viewer_v2/core/widget/key_tile_widget.dart';
import 'package:key_viewer_v2/settings/page/widget/key_tile_settings_dialog.dart';
import 'package:flutter/scheduler.dart' show Ticker;

/// 격자 사양: 1칸 픽셀(cell) + 구분선(gap) = pitch
class SnapGridSpec {
  final double cell; // 1칸 크기(px)
  final double gap;  // 구분선 두께(px)
  const SnapGridSpec({this.cell = 4, this.gap = 1});
  double get pitch => cell + gap;
}

/// 히스토리 이동 축(기본: 위로)
enum HistoryAxis {
  verticalUp,
  verticalDown,
  horizontalLeft,
  horizontalRight,
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

  // 키별 축(확장 포인트) — 지금은 모두 위로, 이후 타일 설정에서 주입 가능
  HistoryAxis _axisFor(int keyCode) => HistoryAxis.verticalUp;

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


// 교체:
  double get _topMostY {
    if (_tiles.isEmpty) return widget.historyBandPx;
    double m = double.infinity;
    for (final t in _tiles) {
      // 화면상의 실제 top: 타일 y + 상단 밴드 오프셋
      final topPx = _yPx(t.gy) + widget.historyBandPx;
      if (topPx < m) m = topPx;
    }
    return m.isFinite ? m : widget.historyBandPx;
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
      final rt = _KeyTileRuntime(model: m);
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

      // ★ 최초 입력 프레임에 즉시 그리기
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
    final usableH = area.height - widget.historyBandPx - _hPx(b.gh) - epsilon; // ★

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
  /// 필요 시 setState + onChanged까지 해주는 헬퍼.
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
            behavior: HitTestBehavior.opaque,
            onPointerDown: (e) => _beginDrag(b, e.localPosition),
            onPointerMove: (e) => _updateDrag(e.localPosition),
            onPointerUp: (_) => _endDrag(),
            onPointerCancel: (_) => _endDrag(),
            child: GestureDetector(
              onTap: () async {
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
          top:  _yPx(b.gy) + widget.historyBandPx, // ★ 상단 밴드만큼 내림
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
                topMostY: _topMostY,
                tileRectOf: _tileRect,
                liveColorOf: (rt) => rt.historyColor.withOpacity(0.90),
                doneColorOf: (rt) => rt.historyColor.withOpacity(0.65),
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
  final double trailSpeed; // ★ 추가

  const _HistoryParams({
    required this.barMin,
    required this.barMax,
    required this.fadeSec,
    required this.fadeStartRatio,
    required this.barRadius,
    required this.shadowBlur,
    required this.shadowOpacity,
    this.trailSpeed = 140, // 기본값: 라이브 바 속도와 동일
  });
}


class _HistoryPainter extends CustomPainter {
  final DateTime now;
  final List<_KeyTileRuntime> runtimeTiles;
  final double topMostY;
  final Rect Function(KeyTileDataModel) tileRectOf;
  final Color Function(_KeyTileRuntime) liveColorOf;
  final Color Function(_KeyTileRuntime) doneColorOf;
  final _HistoryParams params;

  const _HistoryPainter({
    required this.now,
    required this.runtimeTiles,
    required this.topMostY,
    required this.tileRectOf,
    required this.liveColorOf,
    required this.doneColorOf,
    required this.params,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // z 정렬(보기 일관성)
    final sorted = [...runtimeTiles]..sort((a, b) {
      final r = a.model.gy.compareTo(b.model.gy);
      if (r != 0) return r;

      final c = a.model.gx.compareTo(b.model.gx);
      if (c != 0) return c;

      return a.model.primaryKey.compareTo(b.model.primaryKey);
    });

    for (final rt in sorted) {
      final slot = tileRectOf(rt.model);

      // 완료바
      for (final c in rt.history.completed) {
        final t = now.difference(c.createdAt).inMilliseconds / 1000.0;
        if (t < 0 || t > params.fadeSec) continue;

        // 알파(뒤쪽 30% 구간에서 페이드)
        final fadeStart = params.fadeSec * params.fadeStartRatio;
        final alpha = (t < fadeStart)
            ? 1.0
            : ((params.fadeSec - t) / (params.fadeSec - fadeStart)).clamp(0.0, 1.0);

        // ★ 시간에 비례해 위로 이동
        final travel = t * params.trailSpeed;

        _drawBar(
          canvas,
          slot,
          rt.axis,
          magnitude: c.height,              // 완료 시점 고정 높이
          baseY: topMostY - travel,         // ★ 기준선을 위로 끌어올림
          color: doneColorOf(rt).withOpacity(alpha),
          withShadow: true,
        );
      }


      // 라이브바
      final start = rt.history.pressStartAt;
      if (start != null) {
        final elapsed = now.difference(start).inMilliseconds / 1000.0;
        final h = (elapsed * _GridSnapEditorState._BAR_SPEED)
            .clamp(params.barMin, params.barMax);
        _drawBar(
          canvas,
          slot,
          rt.axis,
          magnitude: h,
          baseY: topMostY,
          color: liveColorOf(rt),
          withShadow: false,
        );
      }
    }
  }

  void _drawBar(
      Canvas canvas,
      Rect tileRect,
      HistoryAxis axis, {
        required double magnitude,
        required double baseY,
        required Color color,
        required bool withShadow,
      }) {
    late RRect rr;

    switch (axis) {
      case HistoryAxis.verticalUp:
      // 가로폭 = 타일 폭, 위로 성장
        final left = tileRect.left;
        final width = tileRect.width;
        final top = baseY - magnitude;
        rr = RRect.fromRectAndRadius(
          Rect.fromLTWH(left, top, width, magnitude),
          Radius.circular(params.barRadius),
        );
        break;

      case HistoryAxis.verticalDown:
        final left = tileRect.left;
        final width = tileRect.width;
        final top = tileRect.bottom + 8; // (임시) 여백
        rr = RRect.fromRectAndRadius(
          Rect.fromLTWH(left, top, width, magnitude),
          Radius.circular(params.barRadius),
        );
        break;

      case HistoryAxis.horizontalLeft:
        final top = baseY - params.barMin;
        final height = params.barMin;
        final right = tileRect.left;
        rr = RRect.fromRectAndRadius(
          Rect.fromLTWH(right - magnitude, top, magnitude, height),
          Radius.circular(params.barRadius),
        );
        break;

      case HistoryAxis.horizontalRight:
        final top = baseY - params.barMin;
        final height = params.barMin;
        final left = tileRect.right;
        rr = RRect.fromRectAndRadius(
          Rect.fromLTWH(left, top, magnitude, height),
          Radius.circular(params.barRadius),
        );
        break;
    }

    if (withShadow) {
      final sp = Paint()
        ..color = color.withOpacity(params.shadowOpacity)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, params.shadowBlur);
      canvas.drawRRect(rr.shift(const Offset(0, 2)), sp);
    }

    final fp = Paint()..color = color;
    canvas.drawRRect(rr, fp);
  }

  @override
  bool shouldRepaint(covariant _HistoryPainter old) =>
      old.now != now ||
          !identical(old.runtimeTiles, runtimeTiles) ||
          old.topMostY != topMostY;
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
    this.historyColor = const Color(0xFF00E5FF), // cyan-ish
  });
}

