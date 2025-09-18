import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'package:key_viewer_v2/core/widget/key_tile_widget.dart';
import 'package:key_viewer_v2/core/model/key/key_info_model.dart';
// ↓ KeyInputMonitor 경로는 프로젝트 구조에 맞게 조정
import 'package:key_viewer_v2/core/input/key_input_monitor.dart';

// ──────────────────────────────────────────────────────────────────────────────
// Key Mapping Dialog (간단 버전: 다음에 눌린 키 1개 캡처 + 이름 입력)
// ──────────────────────────────────────────────────────────────────────────────
class KeyMappingResult {
  final int vk;
  final String name; // 입력 이름(없으면 라벨)
  KeyMappingResult(this.vk, this.name);
}

Future<KeyMappingResult?> showKeyMappingDialog(
    BuildContext context, {
      double width = 420,
      bool excludeModifiers = true,
    }) {
  return showDialog<KeyMappingResult?>(
    context: context,
    barrierDismissible: true,
    builder: (_) => _KeyMappingDialog(
      width: width,
      excludeModifiers: excludeModifiers,
    ),
  );
}

class _KeyMappingDialog extends StatefulWidget {
  final double width;
  final bool excludeModifiers;
  const _KeyMappingDialog({required this.width, this.excludeModifiers = true});

  @override
  State<_KeyMappingDialog> createState() => _KeyMappingDialogState();
}

class _KeyMappingDialogState extends State<_KeyMappingDialog> {
  late final KeyInputMonitor _monitor;
  VoidCallback? _listener;
  Set<int> _last = <int>{};
  bool _listening = false;
  int? _vk;
  String? _label;
  final _nameCtrl = TextEditingController();
  final _nameFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _monitor = KeyInputMonitor();
  }

  @override
  void dispose() {
    _stop();
    _monitor.dispose();
    _nameCtrl.dispose();
    _nameFocus.dispose();
    super.dispose();
  }

  void _begin() {
    if (_listening) return;
    setState(() {
      _listening = true;
      _vk = null;
      _label = null;
    });
    _last = _monitor.snapshotPressed();
    _monitor.start();

    _listener = () {
      final cur = _monitor.pressedKeys.value;
      final newly = cur.difference(_last);
      _last = cur;
      if (newly.isEmpty) return;

      final vk = newly.first;
      if (widget.excludeModifiers && _isMod(vk)) return;

      final label = _vkLabel(vk);
      setState(() {
        _vk = vk;
        _label = label;
        _listening = false;
        if (_nameCtrl.text.trim().isEmpty) {
          _nameCtrl.text = label;
          _nameFocus.requestFocus();
          _nameCtrl.selection = TextSelection(baseOffset: 0, extentOffset: _nameCtrl.text.length);
        }
      });

      _stop();
    };

    _monitor.pressedKeys.addListener(_listener!);
  }

  void _stop() {
    if (_listener != null) {
      _monitor.pressedKeys.removeListener(_listener!);
      _listener = null;
    }
    _monitor.stop();
  }

  bool _isMod(int vk) {
    const mods = {0x10, 0xA0, 0xA1, 0x11, 0xA2, 0xA3, 0x12, 0xA4, 0xA5, 0x5B, 0x5C};
    return mods.contains(vk);
  }

  String _vkLabel(int vk) {
    if (vk >= 0x41 && vk <= 0x5A) return String.fromCharCode(vk);
    if (vk >= 0x30 && vk <= 0x39) return String.fromCharCode(vk);
    if (vk >= 0x70 && vk <= 0x87) return 'F${vk - 0x70 + 1}';
    if (vk >= 0x60 && vk <= 0x69) return 'Num ${vk - 0x60}';
    switch (vk) {
      case 0x0D:
        return 'Enter';
      case 0x1B:
        return 'Esc';
      case 0x20:
        return 'Space';
      case 0x08:
        return 'Backspace';
      case 0x09:
        return 'Tab';
      case 0x25:
        return 'Left';
      case 0x26:
        return 'Up';
      case 0x27:
        return 'Right';
      case 0x28:
        return 'Down';
      case 0x2E:
        return 'Delete';
      case 0x2D:
        return 'Insert';
      case 0x21:
        return 'Page Up';
      case 0x22:
        return 'Page Down';
      case 0x24:
        return 'Home';
      case 0x23:
        return 'End';
      case 0x14:
        return 'Caps Lock';
      case 0x90:
        return 'Num Lock';
      case 0x91:
        return 'Scroll Lock';
      case 0x2C:
        return 'Print Screen';
      case 0x15:
        return '한/영';
      case 0x19:
        return '한자';
    }
    const oem = {
      0xBA: ';',
      0xBB: '=',
      0xBC: ',',
      0xBD: '-',
      0xBE: '.',
      0xBF: '/',
      0xC0: '`',
      0xDB: '[',
      0xDC: r'\\',
      0xDD: ']',
      0xDE: '\'',
      0xE2: r'\\ (Non-US)',
    };
    return oem[vk] ?? 'VK 0x${vk.toRadixString(16).toUpperCase()}';
  }

  void _confirm() {
    if (_vk == null) return;
    final name = _nameCtrl.text.trim().isNotEmpty ? _nameCtrl.text.trim() : (_label ?? 'Key');
    Navigator.pop(context, KeyMappingResult(_vk!, name));
  }

  @override
  Widget build(BuildContext context) {
    final bg = const Color(0xFF202124);
    final textColor = Colors.white.withOpacity(0.9);
    final cap = Colors.white.withOpacity(0.7);

    return LayoutBuilder(builder: (context, c) {
      final w = widget.width.clamp(280.0, c.maxWidth - 48.0).toDouble();
      return Dialog(
        backgroundColor: bg,
        insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: SizedBox(
          width: w,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(children: [
                  Text('키 매핑', style: TextStyle(color: textColor, fontWeight: FontWeight.w700)),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close, size: 18, color: Colors.white70),
                  ),
                ]),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('키', style: TextStyle(color: cap, fontWeight: FontWeight.w600)),
                    const SizedBox(width: 16),
                    InkWell(
                      onTap: _begin,
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: (_listening ? const Color(0x1A7AB8FF) : Colors.white.withOpacity(0.06)),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: _listening ? const Color(0xFF7AB8FF) : Colors.white.withOpacity(0.18)),
                        ),
                        child: Text(
                          _listening ? '아무 키나 눌러주세요…' : (_label ?? 'Click to set key'),
                          style: TextStyle(color: textColor, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('키 이름', style: TextStyle(color: cap, fontWeight: FontWeight.w600)),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextField(
                        controller: _nameCtrl,
                        focusNode: _nameFocus,
                        textInputAction: TextInputAction.done,
                        onSubmitted: (_) => _confirm(),
                        style: TextStyle(color: textColor, fontWeight: FontWeight.w600),
                        decoration: InputDecoration(
                          isDense: true,
                          hintText: _label ?? '예: Jump',
                          hintStyle: TextStyle(color: Colors.white.withOpacity(0.45)),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.06),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.white.withOpacity(0.18)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Color(0xFF7AB8FF)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  TextButton(onPressed: () => Navigator.pop(context), child: const Text('취소')),
                  const SizedBox(width: 8),
                  FilledButton(onPressed: (_vk != null) ? _confirm : null, child: const Text('확인')),
                ]),
              ],
            ),
          ),
        ),
      );
    });
  }
}

// ──────────────────────────────────────────────────────────────────────────────
// KeyTileSettingDialog
// ──────────────────────────────────────────────────────────────────────────────

class KeyTileSettingDialog extends StatefulWidget {
  final KeyTileDataModel keyTileData;
  final double width; // dialog width (height = auto)

  const KeyTileSettingDialog({
    super.key,
    required this.keyTileData,
    this.width = 560,
  });

  @override
  State<KeyTileSettingDialog> createState() => _KeyTileSettingDialogState();
}

class _KeyTileSettingDialogState extends State<KeyTileSettingDialog> {
  late KeyTileDataModel keyTileDataModel;

  // 미리보기
  bool _previewPressed = false;

  // 컨트롤러
  final _nameCtrl = TextEditingController();
  final _gwCtrl = TextEditingController();
  final _ghCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    keyTileDataModel = widget.keyTileData;
    _nameCtrl.text = keyTileDataModel.label;
    _gwCtrl.text = keyTileDataModel.gw.toString();
    _ghCtrl.text = keyTileDataModel.gh.toString();
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _gwCtrl.dispose();
    _ghCtrl.dispose();
    super.dispose();
  }

  // 숫자 필드 공통 처리(0~50 클램프)
  int _clampGridValue(String text) {
    final v = int.tryParse(text) ?? 0;
    return v.clamp(0, 50);
  }

  // Label/Caption 스타일
  TextStyle get _cap => const TextStyle(color: Colors.white70, fontWeight: FontWeight.w600);
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

  // 정수필드 위젯(0~50)
  Widget _intField({
    required TextEditingController controller,
    required void Function(int) onChanged,
    double width = 64,
  }) {
    return SizedBox(
      width: width,
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        inputFormatters: const [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(2),
        ],
        textInputAction: TextInputAction.done,
        onSubmitted: (_) {
          final c = _clampGridValue(controller.text);
          if ((int.tryParse(controller.text) ?? c) != c) {
            controller.text = '$c';
            controller.selection = TextSelection.collapsed(offset: controller.text.length);
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
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        decoration: _fieldDeco(hint: '0~50'),
        cursorHeight: 16,
        maxLength: 2,
      ),
    );
  }

  // 색상 선택(스와치 + ColorPicker)
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

  // 더블(사이즈/반지름/두께) 필드
  Widget _doubleField({
    required double value,
    required void Function(double) onChanged,
    String? hint,
    double min = 0,
    double max = 100,
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
          LengthLimitingTextInputFormatter(6),
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
          setState(() {});
        },
        onChanged: (_) {
          final v = double.tryParse(ctrl.text);
          if (v != null) {
            onChanged(v.clamp(min, max).toDouble());
            setState(() {});
          }
        },
      ),
    );
  }

  // FontWeight 드롭다운(100~900)
  Widget _weightDropdown({
    required String label,
    required int value,
    required void Function(int) onChanged,
  }) {
    const weights = [100, 200, 300, 400, 500, 600, 700, 800, 900];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: _cap),
        const SizedBox(width: 16),
        DropdownButton<int>(
          value: weights.contains(value) ? value : 400,
          dropdownColor: const Color(0xFF2A2C30),
          items: [
            for (final w in weights)
              DropdownMenuItem(
                value: w,
                child: Text('w$w', style: const TextStyle(color: Colors.white)),
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

  // 저장 팝
  void _saveAndClose() {
    final gw = _clampGridValue(_gwCtrl.text);
    final gh = _clampGridValue(_ghCtrl.text);
    final label = _nameCtrl.text.trim();

    final updated = keyTileDataModel.copyWith(
      label: label.isEmpty ? keyTileDataModel.label : label,
      gw: gw,
      gh: gh,
    );
    Navigator.pop(context, updated);
  }

  // 키 매핑 호출
  Future<void> _openKeyMapping() async {
    final res = await showKeyMappingDialog(context, width: 520);
    if (res == null) return;
    setState(() {
      // VK 코드/이름 반영 (모델 필드명 맞춰 수정)
      keyTileDataModel = keyTileDataModel.copyWith(key: res.vk, label: res.name);
      if (_nameCtrl.text.trim().isEmpty) _nameCtrl.text = res.name;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bg = const Color(0xFF202124);
    final textColor = Colors.white.withOpacity(0.92);

    return LayoutBuilder(builder: (context, c) {
      final w = widget.width.clamp(360.0, c.maxWidth - 48.0).toDouble();
      return Dialog(
        backgroundColor: bg,
        insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: SizedBox(
          width: w,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 12),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // 헤더
                  Row(children: [
                    Text('KeyTile 설정',
                        style: TextStyle(color: textColor, fontWeight: FontWeight.w700, fontSize: 16)),
                    const Spacer(),
                    Row(children: [
                      const Text('Pressed', style: TextStyle(color: Colors.white70)),
                      Switch(
                        value: _previewPressed,
                        onChanged: (v) => setState(() => _previewPressed = v),
                      ),
                    ]),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close, size: 18, color: Colors.white70),
                    ),
                  ]),
                  const SizedBox(height: 12),

                  // 미리보기
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.04),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.white.withOpacity(0.10)),
                    ),
                    child: KeyTile(
                      label: keyTileDataModel.label,
                      pressed: _previewPressed,
                      keyTileStyleModel: keyTileDataModel.style,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // 키 매핑 + 이름
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('키 매핑', style: _cap),
                      const SizedBox(width: 16),
                      OutlinedButton(
                        onPressed: _openKeyMapping,
                        child: Text(
                          keyTileDataModel.key != 0 ? 'VK ${keyTileDataModel.key}' : 'Click to set key',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('키 이름', style: _cap),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextField(
                          controller: _nameCtrl,
                          textInputAction: TextInputAction.done,
                          onSubmitted: (_) => _saveAndClose(),
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                          decoration: _fieldDeco(hint: '예: Jump'),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // 크기 (gw/gh)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('너비(그리드)', style: _cap),
                      const SizedBox(width: 16),
                      _intField(
                        controller: _gwCtrl,
                        onChanged: (v) => keyTileDataModel = keyTileDataModel.copyWith(gw: v),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('높이(그리드)', style: _cap),
                      const SizedBox(width: 16),
                      _intField(
                        controller: _ghCtrl,
                        onChanged: (v) => keyTileDataModel = keyTileDataModel.copyWith(gh: v),
                      ),
                    ],
                  ),

                  const SizedBox(height: 18),

                  // ── Border (idle/pressed)
                  _section('Border (idle)', children: [
                    _row2('Radius', _doubleField(
                      value: keyTileDataModel.style.idleBorderRadius,
                      onChanged: (v) => setState(() =>
                      keyTileDataModel = keyTileDataModel.copyWith.style(idleBorderRadius: v)),
                      min: 0, max: 64, hint: '0~64',
                    )),
                    const SizedBox(height: 8),
                    _row2('Width', _doubleField(
                      value: keyTileDataModel.style.idleBorderWidth,
                      onChanged: (v) => setState(() =>
                      keyTileDataModel = keyTileDataModel.copyWith.style(idleBorderWidth: v)),
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

                  _section('Border (pressed)', children: [
                    _row2('Radius', _doubleField(
                      value: keyTileDataModel.style.pressedBorderRadius,
                      onChanged: (v) => setState(() =>
                      keyTileDataModel = keyTileDataModel.copyWith.style(pressedBorderRadius: v)),
                      min: 0, max: 64, hint: '0~64',
                    )),
                    const SizedBox(height: 8),
                    _row2('Width', _doubleField(
                      value: keyTileDataModel.style.pressedBorderWidth,
                      onChanged: (v) => setState(() =>
                      keyTileDataModel = keyTileDataModel.copyWith.style(pressedBorderWidth: v)),
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

                  // Background
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

                  // Key Font
                  _section('Key Font (idle)', children: [
                    _row2('Size', _doubleField(
                      value: keyTileDataModel.style.idleKeyFontSize,
                      onChanged: (v) => setState(() =>
                      keyTileDataModel = keyTileDataModel.copyWith.style(idleKeyFontSize: v)),
                      min: 6, max: 96, hint: '6~96',
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
                    _row2('Size', _doubleField(
                      value: keyTileDataModel.style.pressedKeyFontSize,
                      onChanged: (v) => setState(() =>
                      keyTileDataModel = keyTileDataModel.copyWith.style(pressedKeyFontSize: v)),
                      min: 6, max: 96, hint: '6~96',
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

                  // Counter Font
                  _section('Counter Font (idle)', children: [
                    _row2('Size', _doubleField(
                      value: keyTileDataModel.style.idleCounterFontSize,
                      onChanged: (v) => setState(() =>
                      keyTileDataModel = keyTileDataModel.copyWith.style(idleCounterFontSize: v)),
                      min: 6, max: 96, hint: '6~96',
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
                    _row2('Size', _doubleField(
                      value: keyTileDataModel.style.pressedCounterFontSize,
                      onChanged: (v) => setState(() =>
                      keyTileDataModel = keyTileDataModel.copyWith.style(pressedCounterFontSize: v)),
                      min: 6, max: 96, hint: '6~96',
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

                  const SizedBox(height: 20),

                  // 액션
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(onPressed: () => Navigator.pop(context), child: const Text('취소')),
                      const SizedBox(width: 8),
                      FilledButton(onPressed: _saveAndClose, child: const Text('저장')),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  // 섹션 헬퍼
  Widget _section(String title, {required List<Widget> children}) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(title,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.white70)),
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
}
