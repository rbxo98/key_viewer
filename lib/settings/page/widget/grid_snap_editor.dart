import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:key_viewer_v2/core/model/key/key_tile_data_model.dart';

/// 격자 사양: 1칸 픽셀(cell) + 구분선(gap) = pitch
class SnapGridSpec {
  final double cell; // 1칸 크기(px)
  final double gap;  // 구분선 두께(px)
  const SnapGridSpec({this.cell = 4, this.gap = 1});
  double get pitch => cell + gap;
}

class GridSnapEditor extends StatefulWidget {
  /// 고정 크기. 지정하지 않으면 부모 제약을 꽉 채움(Expanded 권장).
  final Size? areaSize;

  /// 배치 대상 타일 집합(모델). 외부에서 바뀌면 동기화됨.
  final Set<KeyTileDataModel> targetKeyList;

  /// 현재 눌려있는 VK 코드들. 타일의 b.key가 포함되면 pressed로 렌더.
  final Set<int> pressedVks;

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

  const GridSnapEditor({
    super.key,
    this.areaSize,
    required this.targetKeyList,
    required this.pressedVks,
    this.grid = const SnapGridSpec(),
    this.onChanged,
    this.onPixelSizeChanged,
    this.isEditor = true,
    this.showBackground = true,
    this.liveSnap = true,
    this.backgroundColor = const Color(0xFF2F3337),
    this.gridLineColor = Colors.white,
    this.gridLineOpacity = 0.06,
  });

  @override
  State<GridSnapEditor> createState() => _GridSnapEditorState();
}

class _GridSnapEditorState extends State<GridSnapEditor> {
  late List<KeyTileDataModel> _tiles; // 내부 편집 버퍼
  String? _dragId;
  Offset _dragStartLocal = Offset.zero;
  late int _startGx, _startGy;
  Size _lastSize = Size.zero;

  // liveSnap=false일 때, 드래그 델타를 임시로 들고 있다가 드롭 시 반영
  int _pendingDgx = 0;
  int _pendingDgy = 0;

  double get _pitch => widget.grid.pitch;

  @override
  void initState() {
    super.initState();
    _tiles = widget.targetKeyList.map((e) => e.copyWith()).toList();
  }

  @override
  void didUpdateWidget(covariant GridSnapEditor oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 외부 데이터 변경 시 동기화
    if (!identical(oldWidget.targetKeyList, widget.targetKeyList)) {
      _tiles = widget.targetKeyList.map((e) => e.copyWith()).toList();
    }
    // 격자 변경 → 클램프
    if (oldWidget.grid.pitch != widget.grid.pitch && _lastSize != Size.zero) {
      for (final b in _tiles) _clampGrid(b, _lastSize);
      setState(() {});
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

  void _clampGrid(KeyTileDataModel b, Size area) {
    final maxGx = math.max(0, ((area.width  - _wPx(b.gw)) / _pitch).floor());
    final maxGy = math.max(0, ((area.height - _hPx(b.gh)) / _pitch).floor());
    b.gx = b.gx.clamp(0, maxGx);
    b.gy = b.gy.clamp(0, maxGy);
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
      // 크기 결정: areaSize 우선, 없으면 부모 제약 꽉 채움
      final effectiveSize = widget.areaSize ??
          Size(
            constraints.hasBoundedWidth ? constraints.maxWidth : 600,
            constraints.hasBoundedHeight ? constraints.maxHeight : 400,
          );

      // 사이즈 변동 시 클램프 + 콜백
      if (effectiveSize != _lastSize) {
        for (final b in _tiles) {
          _clampGrid(b, effectiveSize);
        }
        _lastSize = effectiveSize;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          widget.onPixelSizeChanged?.call(effectiveSize);
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

      // 타일 렌더
      for (final b in _tiles) {
        final pressed = widget.pressedVks.contains(b.key);
        final tile = KeyTile(
          label: b.label,
          pressed: pressed,
          keyTileStyleModel: b.style,
        );

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
                  builder: (_) => KeyTileSettingDialog(keyTileData: b),
                );
                if (data != null) {
                  final idx = _tiles.indexWhere((e) => e.primaryKey == b.primaryKey);
                  if (idx >= 0) {
                    setState(() => _tiles[idx] = data);
                    final snapshot = _tiles.map((e) => e.copyWith()).toSet();
                    widget.onChanged?.call(snapshot);
                  }
                }
              },
              child: tile,
            ),
          );
        } else {
          // viewer: 입력 무시
          content = IgnorePointer(child: tile);
        }

        children.add(Positioned(
          left: _xPx(b.gx),
          top: _yPx(b.gy),
          width: _wPx(b.gw),
          height: _hPx(b.gh),
          child: content,
        ));
      }

      return SizedBox(
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
