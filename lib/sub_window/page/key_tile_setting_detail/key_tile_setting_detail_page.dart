import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:key_viewer_v2/core/model/key/key_tile_data_model.dart';

import 'package:key_viewer_v2/core/widget/key_tile_widget.dart';
import 'package:window_manager_plus/window_manager_plus.dart';

class KeyTileSettingDetailPage extends StatefulWidget {
  final KeyTileStyleModel? initial;
  final ValueChanged<KeyTileStyleModel>? onChanged;
  final String previewLabel;

  const KeyTileSettingDetailPage({
    super.key,
    this.initial,
    this.onChanged,
    this.previewLabel = 'A',
  });

  @override
  State<KeyTileSettingDetailPage> createState() => _KeyTileSettingDetailPageState();
}

class _KeyTileSettingDetailPageState extends State<KeyTileSettingDetailPage> with WindowListener {
  late KeyTileStyleModel style;
  bool previewPressed = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    style = widget.initial ?? KeyTileStyleModel.empty();
  }

  void _emit() => widget.onChanged?.call(style);

  // ---------- UI helpers ----------
  Widget _sectionTitle(String title) => Padding(
    padding: const EdgeInsets.only(top: 16, bottom: 8),
    child: Text(title,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w700,
          color: Colors.white70,
        )),
  );

  Widget _rowLabel(String text) => Text(
    text,
    style: const TextStyle(
      color: Colors.white70,
      fontWeight: FontWeight.w600,
    ),
  );

  InputDecoration _fieldDeco({String? hint}) => InputDecoration(
    isDense: true,
    hintText: hint,
    hintStyle: TextStyle(color: Colors.white.withOpacity(0.45)),
    filled: true,
    fillColor: Colors.white.withOpacity(0.06),
    contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: Colors.white.withOpacity(0.18), width: 1),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Color(0xFF7AB8FF), width: 1),
    ),
    counterText: '',
  );

  // 숫자 필드( double )
  Widget _doubleField({
    required double value,
    required void Function(double) onChanged,
    double min = 0,
    double max = 1000,
    int maxLen = 6,
    String? hint,
    double width = 80,
  }) {
    final ctrl = TextEditingController(text: value.toString());
    return SizedBox(
      width: width,
      child: TextField(
        controller: ctrl,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
          LengthLimitingTextInputFormatter(maxLen),
        ],
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        decoration: _fieldDeco(hint: hint),
        onSubmitted: (_) {
          final v = double.tryParse(ctrl.text) ?? value;
          final c = v.clamp(min, max);
          if (v != c) {
            ctrl.text = '$c';
            ctrl.selection = TextSelection.collapsed(offset: ctrl.text.length);
          }
          onChanged(c.toDouble());
          _emit();
          setState(() {});
        },
        onChanged: (_) {
          final v = double.tryParse(ctrl.text);
          if (v != null) {
            onChanged(v.clamp(min, max).toDouble());
            _emit();
            setState(() {});
          }
        },
      ),
    );
  }

  // 정수 필드( int )
  Widget _intField({
    required int value,
    required void Function(int) onChanged,
    int min = 0,
    int max = 1000,
    int maxLen = 4,
    String? hint,
    double width = 80,
  }) {
    final ctrl = TextEditingController(text: value.toString());
    return SizedBox(
      width: width,
      child: TextField(
        controller: ctrl,
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(maxLen),
        ],
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        decoration: _fieldDeco(hint: hint),
        onSubmitted: (_) {
          final v = int.tryParse(ctrl.text) ?? value;
          final c = v.clamp(min, max);
          if (v != c) {
            ctrl.text = '$c';
            ctrl.selection = TextSelection.collapsed(offset: ctrl.text.length);
          }
          onChanged(c);
          _emit();
          setState(() {});
        },
        onChanged: (_) {
          final v = int.tryParse(ctrl.text);
          if (v != null) {
            onChanged(v.clamp(min, max));
            _emit();
            setState(() {});
          }
        },
      ),
    );
  }

  // 색상 선택(요청하신 패턴: 스와치 + ColorPicker 다이얼로그)
  Widget _colorRow({
    required String label,
    required int argb,
    required void Function(int) onChanged,
  }) {
    final textColor = Colors.white.withOpacity(0.9);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _rowLabel(label),
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
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('취소'),
                      ),
                      FilledButton(
                        onPressed: () {
                          onChanged(temp.value);
                          _emit();
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
            const SizedBox(width: 8),
            // HEX 입력(선택): #AARRGGBB
            SizedBox(
              width: 110,
              child: TextField(
                controller: TextEditingController(
                    text: '#${argb.toRadixString(16).padLeft(8, '0').toUpperCase()}'),
                style:
                TextStyle(color: textColor, fontWeight: FontWeight.w600, fontFamily: 'monospace'),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[#0-9a-fA-F]')),
                  LengthLimitingTextInputFormatter(9),
                ],
                decoration: _fieldDeco(),
                onSubmitted: (s) {
                  final v = _parseHexColor(s.trim());
                  if (v != null) {
                    onChanged(v);
                    _emit();
                    setState(() {});
                  }
                },
              ),
            ),
          ],
        )
      ],
    );
  }

  int? _parseHexColor(String s) {
    s = s.replaceFirst('#', '').toUpperCase();
    if (s.length == 6) s = 'FF$s'; // RRGGBB -> AARRGGBB
    if (s.length != 8) return null;
    final v = int.tryParse(s, radix: 16);
    return v;
  }

  Widget _weightDropdown({
    required String label,
    required int value,
    required void Function(int) onChanged,
  }) {
    const weights = [4,6];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _rowLabel(label),
        const SizedBox(width: 16),
        DropdownButton<int>(
          value: weights.contains(value) ? value : 400,
          dropdownColor: const Color(0xFF2A2C30),
          items: [
            DropdownMenuItem(
              value: weights[0],
              child: Text('noraml', style: const TextStyle(color: Colors.white)),
            ),
            DropdownMenuItem(
              value: weights[1],
              child: Text('bold', style: const TextStyle(color: Colors.white)),
            )

          ],
          onChanged: (v) {
            if (v == null) return;
            onChanged(v);
            _emit();
            setState(() {});
          },
        ),
      ],
    );
  }

  // ---------- build ----------
  @override
  Widget build(BuildContext context) {
    final bg = const Color(0xFF202124);

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bg,
        title: Text('KeyTile 스타일 설정', style: const TextStyle(color: Colors.white),),
        actions: [
          Row(
            children: [
              const Text('Pressed', style: TextStyle(color: Colors.white70)),
              Switch(
                value: previewPressed,
                onChanged: (v) => setState(() => previewPressed = v),
              ),
              const SizedBox(width: 8),
            ],
          ),
        ],
      ),
      body: Scrollbar(
        controller: _scrollController,

        child: SingleChildScrollView(
          controller: _scrollController,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.04),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white.withOpacity(0.10)),
                ),
                child: SizedBox(
                  width: 60,
                  height: 60,
                  child: KeyTile(
                    keyTileDataModel: KeyTileDataModel.empty().copyWith(
                      style: style,
                      label: 'Q',
                    ),
                    pressed: previewPressed,
                  ),
                ),
              ),

              // Border
              _sectionTitle('Border (idle)'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _rowLabel('Radius'),
                  _doubleField(
                    value: style.idleBorderRadius,
                    onChanged: (v) => style = style.copyWith(idleBorderRadius: v),
                    min: 0, max: 64, hint: '0~64',
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _rowLabel('Width'),
                  _doubleField(
                    value: style.idleBorderWidth,
                    onChanged: (v) => style = style.copyWith(idleBorderWidth: v),
                    min: 0, max: 20, hint: '0~20',
                  ),
                ],
              ),
              const SizedBox(height: 8),
              _colorRow(
                label: 'Color',
                argb: style.idleBorderColor,
                onChanged: (v) => style = style.copyWith(idleBorderColor: v),
              ),

              _sectionTitle('Border (pressed)'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _rowLabel('Radius'),
                  _doubleField(
                    value: style.pressedBorderRadius,
                    onChanged: (v) => style = style.copyWith(pressedBorderRadius: v),
                    min: 0, max: 64, hint: '0~64',
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _rowLabel('Width'),
                  _doubleField(
                    value: style.pressedBorderWidth,
                    onChanged: (v) => style = style.copyWith(pressedBorderWidth: v),
                    min: 0, max: 20, hint: '0~20',
                  ),
                ],
              ),
              const SizedBox(height: 8),
              _colorRow(
                label: 'Color',
                argb: style.pressedBorderColor,
                onChanged: (v) => style = style.copyWith(pressedBorderColor: v),
              ),

              // Background
              _sectionTitle('Background'),
              _colorRow(
                label: 'Idle',
                argb: style.idleBackgroundColor,
                onChanged: (v) => style = style.copyWith(idleBackgroundColor: v),
              ),
              const SizedBox(height: 8),
              _colorRow(
                label: 'Pressed',
                argb: style.pressedBackgroundColor,
                onChanged: (v) => style = style.copyWith(pressedBackgroundColor: v),
              ),

              // Key Font
              _sectionTitle('Key Font (idle)'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _rowLabel('Size'),
                  _doubleField(
                    value: style.idleKeyFontSize,
                    onChanged: (v) => style = style.copyWith(idleKeyFontSize: v),
                    min: 6, max: 96, hint: '6~96',
                  ),
                ],
              ),
              const SizedBox(height: 8),
              _weightDropdown(
                label: 'Weight',
                value: style.idleKeyFontWeight,
                onChanged: (v) => style = style.copyWith(idleKeyFontWeight: v),
              ),
              const SizedBox(height: 8),
              _colorRow(
                label: 'Color',
                argb: style.idleKeyFontColor,
                onChanged: (v) => style = style.copyWith(idleKeyFontColor: v),
              ),

              _sectionTitle('Key Font (pressed)'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _rowLabel('Size'),
                  _doubleField(
                    value: style.pressedKeyFontSize,
                    onChanged: (v) => style = style.copyWith(pressedKeyFontSize: v),
                    min: 6, max: 96, hint: '6~96',
                  ),
                ],
              ),
              const SizedBox(height: 8),
              _weightDropdown(
                label: 'Weight',
                value: style.pressedKeyFontWeight,
                onChanged: (v) => style = style.copyWith(pressedKeyFontWeight: v),
              ),
              const SizedBox(height: 8),
              _colorRow(
                label: 'Color',
                argb: style.pressedKeyFontColor,
                onChanged: (v) => style = style.copyWith(pressedKeyFontColor: v),
              ),

              // Counter Font
              _sectionTitle('Counter Font (idle)'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _rowLabel('Size'),
                  _doubleField(
                    value: style.idleCounterFontSize,
                    onChanged: (v) => style = style.copyWith(idleCounterFontSize: v),
                    min: 6, max: 96, hint: '6~96',
                  ),
                ],
              ),
              const SizedBox(height: 8),
              _weightDropdown(
                label: 'Weight',
                value: style.idleCounterFontWeight,
                onChanged: (v) => style = style.copyWith(idleCounterFontWeight: v),
              ),
              const SizedBox(height: 8),
              _colorRow(
                label: 'Color',
                argb: style.idleCounterFontColor,
                onChanged: (v) => style = style.copyWith(idleCounterFontColor: v),
              ),

              _sectionTitle('Counter Font (pressed)'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _rowLabel('Size'),
                  _doubleField(
                    value: style.pressedCounterFontSize,
                    onChanged: (v) => style = style.copyWith(pressedCounterFontSize: v),
                    min: 6, max: 96, hint: '6~96',
                  ),
                ],
              ),
              const SizedBox(height: 8),
              _weightDropdown(
                label: 'Weight',
                value: style.pressedCounterFontWeight,
                onChanged: (v) => style = style.copyWith(pressedCounterFontWeight: v),
              ),
              const SizedBox(height: 8),
              _colorRow(
                label: 'Color',
                argb: style.pressedCounterFontColor,
                onChanged: (v) => style = style.copyWith(pressedCounterFontColor: v),
              ),

              const SizedBox(height: 16),
            ],
          ),

        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () => setState(() {
                style = KeyTileStyleModel.empty();
                _emit();
              }),
              child: const Text('Reset'),
            ),
            const SizedBox(width: 8),
            FilledButton(
              onPressed: _emit,
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
