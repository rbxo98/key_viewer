import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:key_viewer_v2/core/lib/key_input_monitor.dart';
import 'package:key_viewer_v2/core/model/key/key_tile_data_model.dart';
import 'package:key_viewer_v2/core/widget/key_tile_widget.dart';
import 'package:key_viewer_v2/settings/page/widget/key_tile_settings_dialog_widget.dart';

class KeyTileSettingDialog extends StatefulWidget {
  final KeyTileDataModel? keyTileData;
  final double width;

  // 에디터와 동일한 픽셀 크기 미리보기를 원할 경우 사용 (원치 않으면 null)
  final double? cellPx;
  final double? gapPx;

  const KeyTileSettingDialog({
    super.key,
    this.keyTileData,
    this.width = 560,
    this.cellPx,
    this.gapPx,
  });

  @override
  State<KeyTileSettingDialog> createState() => _KeyTileSettingDialogState();
}

class _KeyTileSettingDialogState extends State<KeyTileSettingDialog> {
  static const double _INT_FIELD_W = 64;

  late KeyTileDataModel keyTileDataModel;

  bool _previewPressed = false;

  final _nameCtrl = TextEditingController();
  final _gwCtrl = TextEditingController();
  final _ghCtrl = TextEditingController();

  // 키 매핑
  bool _isMapping = false;

  // 기타 옵션
  bool _advancedOpen = false;

  final KeyInputMonitor keyInputMonitor = KeyInputMonitor();

  @override
  void initState() {
    super.initState();
    keyTileDataModel =
        (widget.keyTileData ?? KeyTileDataModel.empty());
    _nameCtrl.text = keyTileDataModel.label;
    _gwCtrl.text = keyTileDataModel.gw.toString();
    _ghCtrl.text = keyTileDataModel.gh.toString();
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _gwCtrl.dispose();
    _ghCtrl.dispose();
    keyInputMonitor.dispose();
    super.dispose();
  }

  // ───────────────── 유틸 ─────────────────
  int _clampGridValue(String text) {
    final v = int.tryParse(text) ?? 0;
    return v.clamp(0, 50);
  }

  TextStyle get _cap =>
      const TextStyle(color: Colors.white70, fontWeight: FontWeight.w600);

  InputDecoration _fieldDeco({String? hint}) => InputDecoration(
    isDense: true,
    hintText: hint,
    hintStyle: TextStyle(color: Colors.white.withOpacity(0.45)),
    filled: true,
    fillColor: Colors.white.withOpacity(0.06),
    contentPadding:
    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide:
      BorderSide(color: Colors.white.withOpacity(0.18), width: 1),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Color(0xFF7AB8FF), width: 1),
    ),
    counterText: '',
  );

  // ───────────────── 숫자/색상/폰트 위젯 ─────────────────
  Widget _intField({
    required TextEditingController controller,
    required void Function(int) onChanged,
    double width = _INT_FIELD_W,
  }) {
    return SizedBox(
      width: width,
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(2),
        ],
        textInputAction: TextInputAction.done,
        onSubmitted: (_) {
          final c = _clampGridValue(controller.text);
          if ((int.tryParse(controller.text) ?? c) != c) {
            controller.text = '$c';
            controller.selection =
                TextSelection.collapsed(offset: controller.text.length);
          }
          onChanged(c);
          setState(() {});
        },
        onChanged: (_) {
          final v = int.tryParse(controller.text) ?? 0;
          if (v > 50) {
            controller.text = '50';
            controller.selection = const TextSelection.collapsed(offset: 2);
          }
          onChanged(int.tryParse(controller.text) ?? 0);
          setState(() {});
        },
        textAlign: TextAlign.center,
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.w600),
        decoration: _fieldDeco(hint: '0~50'),
        cursorHeight: 16,
        maxLength: 2,
      ),
    );
  }

  // ───────────────── 저장 ─────────────────
  void _saveAndClose() {
    Navigator.pop(context, keyTileDataModel);
  }

  void _close() {
    Navigator.pop(context, widget.keyTileData);
  }

  void _removeAndClose() {
    Navigator.pop(context, widget.keyTileData?.copyWith(isDeleted: true));
  }

  // ───────────────── 키 매핑: KeyInputMonitor 사용 ─────────────────
  void _toggleMapping() {
    setState(() => _isMapping = !_isMapping);

    if (_isMapping) {
      keyInputMonitor.pressedKeys.addListener(_onKey);
      keyInputMonitor.start();
    } else {
      keyInputMonitor.pressedKeys.removeListener(_onKey);
      keyInputMonitor.stop();
    }
  }

  void _onKey() {
    if (!_isMapping || keyInputMonitor.pressedKeys.value.isEmpty) return;
    final vk = keyInputMonitor.pressedKeys.value.first;
    setState(() {
      keyTileDataModel = keyTileDataModel.copyWith(key: vk);
      _isMapping = false;
    });

  }

  // ───────────────── 섹션 헬퍼 ─────────────────
  Widget _section(String title, {required List<Widget> children}) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: Colors.white70)),
          const SizedBox(height: 8),
          ...children,
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _row2(String label, Widget right) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Text(label, style: _cap), const SizedBox(width: 16), right],
    );
  }


// ───────────────── 위젯 빌더 ─────────────────

  Widget _colorRow({
    required String label,
    required int argb,
    required void Function(int) onChanged,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: _cap),
        const SizedBox(width: 16),
        Row(
          children: [
            GestureDetector(
              onTap: () {
                Color temp = Color(argb);
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    backgroundColor: const Color(0xFF2A2C30),
                    content: ColorPicker(
                      pickerColor: temp,
                      onColorChanged: (c) => temp = c,
                    ),
                    actions: [
                      TextButton(onPressed: () => Navigator.pop(context), child: const Text('취소')),
                      FilledButton(
                        onPressed: () {
                          onChanged(temp.value);
                          setState(() {});
                          Navigator.pop(context);
                        },
                        child: const Text('확인'),
                      ),
                    ],
                  ),
                );
              },
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: Color(argb),
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _weightDropdown({
    required String label,
    required int value,
    required void Function(int) onChanged,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: _cap),
        const SizedBox(width: 16),
        DropdownButton<int>(
          value: 4,
          dropdownColor: const Color(0xFF2A2C30),
          items: [
              DropdownMenuItem(
                value: 4,
                child: Text('normal', style: const TextStyle(color: Colors.white)),
              ),
            DropdownMenuItem(
              value: 6,
              child: Text('bold', style: const TextStyle(color: Colors.white)),
            ),
          ],
          onChanged: (v) {
            if (v == null) return;
            onChanged(v);
            setState(() {});
          },
        ),
      ],
    );
  }

  // ───────────────── 빌드 ─────────────────
  @override
  Widget build(BuildContext context) {
    final bg = const Color(0xFF202124);
    final textColor = Colors.white.withOpacity(0.92);

    return LayoutBuilder(builder: (context, c) {
      final w = widget.width.clamp(360.0, c.maxWidth - 48.0).toDouble();
      final maxH = (c.maxHeight - 48.0).clamp(420.0, 900.0);

      return Dialog(
        backgroundColor: bg,
        insetPadding:
        const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12)),
        child: SizedBox(
          width: w,
          height: maxH.toDouble(),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 12),
            child: Column(
              children: [
                // 헤더
                Row(children: [
                  Text('KeyTile 설정',
                      style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 16)),
                  const Spacer(),
                  Row(children: [
                    const Text('Pressed',
                        style: TextStyle(color: Colors.white70)),
                    Switch(
                      value: _previewPressed,
                      onChanged: (v) =>
                          setState(() => _previewPressed = v),
                    ),
                  ]),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close,
                        size: 18, color: Colors.white70),
                  ),
                ]),
                const SizedBox(height: 12),

                // ── 미리보기(고정)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('미리보기', style: _cap),
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: _PreviewBox(
                        model: keyTileDataModel,
                        pressed: _previewPressed,
                        cellPx: widget.cellPx,
                        gapPx: widget.gapPx,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 28),

                // ── 스크롤 영역
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.zero,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 키 매핑
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text('키 매핑', style: _cap),
                            const SizedBox(width: 16),
                            Wrap(
                              crossAxisAlignment:
                              WrapCrossAlignment.center,
                              spacing: 8,
                              children: [
                                OutlinedButton(
                                  onPressed: _toggleMapping,
                                  child: Text(
                                    _isMapping
                                        ? '아무 키나 누르세요…'
                                        : (keyTileDataModel.key != 0
                                        ? "${keyTileDataModel.key}"
                                        : '키 설정'),
                                  ),
                                ),
                                if (_isMapping)
                                  const Icon(Icons.keyboard,
                                      size: 16, color: Colors.white70),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),

                        // 키 이름 (가운데 정렬 + 실시간 반영)
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text('키 이름', style: _cap),
                            const SizedBox(width: 16),
                            SizedBox(
                              width: _INT_FIELD_W,
                              child: TextField(
                                controller: _nameCtrl,
                                textAlign: TextAlign.center,
                                textInputAction: TextInputAction.done,
                                onChanged: (txt) => setState(() {
                                  keyTileDataModel =
                                      keyTileDataModel.copyWith(
                                          label: txt);
                                }),
                                onSubmitted: (_) => _saveAndClose(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                                decoration:
                                _fieldDeco(hint: 'ex. W'),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),

                        // gw / gh
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text('너비(그리드)', style: _cap),
                            const SizedBox(width: 16),
                            _intField(
                              controller: _gwCtrl,
                              onChanged: (v) => setState(() {
                                keyTileDataModel =
                                    keyTileDataModel.copyWith(gw: v);
                              }),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text('높이(그리드)', style: _cap),
                            const SizedBox(width: 16),
                            _intField(
                              controller: _ghCtrl,
                              onChanged: (v) => setState(() {
                                keyTileDataModel =
                                    keyTileDataModel.copyWith(gh: v);
                              }),
                            ),
                          ],
                        ),

                        const SizedBox(height: 12),
                        const Divider(height: 1, color: Colors.white12),
                        const SizedBox(height: 8),

                        ExpansionTile(
                          initiallyExpanded: _advancedOpen,
                          onExpansionChanged: (v) => setState(() => _advancedOpen = v),
                          tilePadding: EdgeInsets.zero,
                          collapsedIconColor: Colors.white70,
                          iconColor: Colors.white70,
                          title: Text('기타 설정', style: _cap.copyWith(fontSize: 13)),
                          childrenPadding: EdgeInsets.zero,
                          children: [
                            // ── Border (idle)
                            _section('Border (idle)', children: [
                              _row2('Radius', IntOnlyField(
                                value: keyTileDataModel.style.idleBorderRadius.round(),
                                onChanged: (v) => setState(() =>
                                keyTileDataModel = keyTileDataModel.copyWith
                                    .style(idleBorderRadius: v.toDouble())),
                                min: 0, max: 64, hint: '0~64',
                              )),
                              const SizedBox(height: 8),
                              _row2('Width', IntOnlyField(
                                value: keyTileDataModel.style.idleBorderWidth.round(),
                                onChanged: (v) => setState(() =>
                                keyTileDataModel = keyTileDataModel.copyWith.style(idleBorderWidth: v.toDouble())),
                                min: 0, max: 20, hint: '0~20',
                              )),
                              const SizedBox(height: 8),
                              _colorRow(
                                label: 'Color',
                                argb: keyTileDataModel.style.idleBorderColor,
                                onChanged: (v) => setState(() =>
                                keyTileDataModel = keyTileDataModel.copyWith.style(idleBorderColor: v)),
                              ),
                            ]),

                            // ── Border (pressed)
                            _section('Border (pressed)', children: [
                              _row2('Radius', IntOnlyField(
                                value: keyTileDataModel.style.pressedBorderRadius.round(),
                                onChanged: (v) => setState(() =>
                                keyTileDataModel = keyTileDataModel.copyWith.style(pressedBorderRadius: v.toDouble())),
                                min: 0, max: 64, hint: '0~64',
                              )),
                              const SizedBox(height: 8),
                              _row2('Width', IntOnlyField(
                                value: keyTileDataModel.style.pressedBorderWidth.round(),
                                onChanged: (v) => setState(() =>
                                keyTileDataModel = keyTileDataModel.copyWith.style(pressedBorderWidth: v.toDouble())),
                                min: 0, max: 20, hint: '0~20',
                              )),
                              const SizedBox(height: 8),
                              _colorRow(
                                label: 'Color',
                                argb: keyTileDataModel.style.pressedBorderColor,
                                onChanged: (v) => setState(() =>
                                keyTileDataModel = keyTileDataModel.copyWith.style(pressedBorderColor: v)),
                              ),
                            ]),

                            // ── Background
                            _section('Background', children: [
                              _colorRow(
                                label: 'Idle',
                                argb: keyTileDataModel.style.idleBackgroundColor,
                                onChanged: (v) => setState(() =>
                                keyTileDataModel = keyTileDataModel.copyWith.style(idleBackgroundColor: v)),
                              ),
                              const SizedBox(height: 8),
                              _colorRow(
                                label: 'Pressed',
                                argb: keyTileDataModel.style.pressedBackgroundColor,
                                onChanged: (v) => setState(() =>
                                keyTileDataModel = keyTileDataModel.copyWith.style(pressedBackgroundColor: v)),
                              ),
                            ]),

                            // ── Key Font
                            _section('Key Font (idle)', children: [
                              _row2('Size', IntOnlyField(
                                value: keyTileDataModel.style.idleKeyFontSize.round(),
                                onChanged: (v) => setState(() =>
                                keyTileDataModel = keyTileDataModel.copyWith.style(idleKeyFontSize: v.toDouble())),
                                min: 1, max: 96, hint: '1~96',
                              )),
                              const SizedBox(height: 8),
                              _weightDropdown(
                                label: 'Weight',
                                value: keyTileDataModel.style.idleKeyFontWeight,
                                onChanged: (w) => setState(() =>
                                keyTileDataModel = keyTileDataModel.copyWith.style(idleKeyFontWeight: w)),
                              ),
                              const SizedBox(height: 8),
                              _colorRow(
                                label: 'Color',
                                argb: keyTileDataModel.style.idleKeyFontColor,
                                onChanged: (v) => setState(() =>
                                keyTileDataModel = keyTileDataModel.copyWith.style(idleKeyFontColor: v)),
                              ),
                            ]),

                            _section('Key Font (pressed)', children: [
                              _row2('Size', IntOnlyField(
                                value: keyTileDataModel.style.pressedKeyFontSize.round(),
                                onChanged: (v) => setState(() =>
                                keyTileDataModel = keyTileDataModel.copyWith.style(pressedKeyFontSize: v.toDouble())),
                                min: 1, max: 96, hint: '1~96',
                              )),
                              const SizedBox(height: 8),
                              _weightDropdown(
                                label: 'Weight',
                                value: keyTileDataModel.style.pressedKeyFontWeight,
                                onChanged: (w) => setState(() =>
                                keyTileDataModel = keyTileDataModel.copyWith.style(pressedKeyFontWeight: w)),
                              ),
                              const SizedBox(height: 8),
                              _colorRow(
                                label: 'Color',
                                argb: keyTileDataModel.style.pressedKeyFontColor,
                                onChanged: (v) => setState(() =>
                                keyTileDataModel = keyTileDataModel.copyWith.style(pressedKeyFontColor: v)),
                              ),
                            ]),

                            // ── Counter Font
                            _section('Counter Font (idle)', children: [
                              _row2('Size', IntOnlyField(
                                value: keyTileDataModel.style.idleCounterFontSize.round(),
                                onChanged: (v) => setState(() =>
                                keyTileDataModel = keyTileDataModel.copyWith.style(idleCounterFontSize: v.toDouble())),
                                min: 1, max: 96, hint: '1~96',
                              )),
                              const SizedBox(height: 8),
                              _weightDropdown(
                                label: 'Weight',
                                value: keyTileDataModel.style.idleCounterFontWeight,
                                onChanged: (w) => setState(() =>
                                keyTileDataModel = keyTileDataModel.copyWith.style(idleCounterFontWeight: w)),
                              ),
                              const SizedBox(height: 8),
                              _colorRow(
                                label: 'Color',
                                argb: keyTileDataModel.style.idleCounterFontColor,
                                onChanged: (v) => setState(() =>
                                keyTileDataModel = keyTileDataModel.copyWith.style(idleCounterFontColor: v)),
                              ),
                            ]),

                            _section('Counter Font (pressed)', children: [
                              _row2('Size', IntOnlyField(
                                value: keyTileDataModel.style.pressedCounterFontSize.round(),
                                onChanged: (v) => setState(() =>
                                keyTileDataModel = keyTileDataModel.copyWith.style(pressedCounterFontSize: v.toDouble())),
                                min: 1, max: 96, hint: '1~96',
                              )),
                              const SizedBox(height: 8),
                              _weightDropdown(
                                label: 'Weight',
                                value: keyTileDataModel.style.pressedCounterFontWeight,
                                onChanged: (w) => setState(() =>
                                keyTileDataModel = keyTileDataModel.copyWith.style(pressedCounterFontWeight: w)),
                              ),
                              const SizedBox(height: 8),
                              _colorRow(
                                label: 'Color',
                                argb: keyTileDataModel.style.pressedCounterFontColor,
                                onChanged: (v) => setState(() =>
                                keyTileDataModel = keyTileDataModel.copyWith.style(pressedCounterFontColor: v)),
                              ),
                            ]),
                          ],
                        ),

                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 8),
                const Divider(height: 1, color: Colors.white12),
                const SizedBox(height: 8),

                // 액션
                Row(
                  mainAxisAlignment: widget.keyTileData == null ? MainAxisAlignment.end : MainAxisAlignment.spaceBetween,
                  children: [
                    if(widget.keyTileData != null)
                    OutlinedButton(
                        onPressed: _removeAndClose,
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          side: const BorderSide(color: Colors.red),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.delete_outline, color: Colors.red,),
                            SizedBox(width: 8,),
                            const Text('삭제', style: TextStyle(color: Colors.red),),
                          ],
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () => _close(),
                            child: const Text('취소')),
                        const SizedBox(width: 8),
                        FilledButton(
                            onPressed: _saveAndClose,
                            child: const Text('저장')),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

// ───────────────── 미리보기 ─────────────────
class _PreviewBox extends StatelessWidget {
  const _PreviewBox({
    required this.model,
    required this.pressed,
    this.cellPx,
    this.gapPx,
  });

  final KeyTileDataModel model;
  final bool pressed;
  final double? cellPx;
  final double? gapPx;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        // 에디터 px 모드: 제공 시 그 값대로
        if (cellPx != null) {
          final gw = math.max(1, model.gw);
          final gh = math.max(1, model.gh);
          final gp = (gapPx ?? 0);
          final w = gw * cellPx! + (gw - 1) * gp;
          final h = gh * cellPx! + (gh - 1) * gp;

          return ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: c.maxWidth,
              maxHeight: c.maxHeight,
            ),
            child: SizedBox(
              width: w,
              height: h,
              child: SizedBox.expand(
                child: KeyTile(
                  pressed: pressed,
                  keyTileDataModel: model,
                ),
              ),
            ),
          );
        }

        // 비율 모드(기본): 영역 안에서 gw:gh 유지하며 최대화
        final gw = (model.gw <= 0 ? 1 : model.gw).toDouble();
        final gh = (model.gh <= 0 ? 1 : model.gh).toDouble();
        final ratio = gw / gh;
        final maxW = c.maxWidth, maxH = c.maxHeight;
        double w = maxW, h = w / ratio;
        if (h > maxH) {
          h = maxH;
          w = h * ratio;
        }

        return Center(
          child: SizedBox(
            width: w,
            height: h,
            child: FittedBox(
              fit: BoxFit.contain,
              child: KeyTile(
                pressed: pressed,
                keyTileDataModel: model,
              ),
            ),
          ),
        );
      },
    );
  }
}
