import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class IntOnlyField extends StatefulWidget {
  const IntOnlyField({
    super.key,
    required this.value,
    required this.onChanged,
    this.hint,
    this.min = 0,
    this.max = 999,
    this.width = 80,
    this.maxLength = 4,
  });

  final int value;
  final ValueChanged<int> onChanged;
  final String? hint;
  final int min;
  final int max;
  final double width;
  final int maxLength;

  @override
  State<IntOnlyField> createState() => IntOnlyFieldState();
}

class IntOnlyFieldState extends State<IntOnlyField> {
  late final TextEditingController _ctrl;
  late final FocusNode _focus;

  @override
  void initState() {
    super.initState();
    _ctrl = TextEditingController(text: widget.value.toString());
    _focus = FocusNode();
  }

  @override
  void didUpdateWidget(covariant IntOnlyField oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 외부 값이 바뀌었고, 지금 포커스가 없을 때만 텍스트 동기화 (포커스 유지)
    if (!_focus.hasFocus && widget.value.toString() != _ctrl.text) {
      _ctrl.text = widget.value.toString();
      _ctrl.selection = TextSelection.collapsed(offset: _ctrl.text.length);
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    _focus.dispose();
    super.dispose();
  }

  void _applyClampAndNotify() {
    final raw = int.tryParse(_ctrl.text) ?? widget.value;
    final clamped = raw.clamp(widget.min, widget.max);
    if (raw != clamped) {
      _ctrl.text = '$clamped';
      _ctrl.selection = TextSelection.collapsed(offset: _ctrl.text.length);
    }
    widget.onChanged(clamped);
    // 포커스 유지: 다시 자기 자신에 포커스 요청
    if (!_focus.hasFocus) {
      _focus.requestFocus();
    }
    setState(() {}); // 로컬 리빌드
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: TextField(
        focusNode: _focus,
        controller: _ctrl,
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(widget.maxLength),
        ],
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        decoration: InputDecoration(
          isDense: true,
          hintText: widget.hint,
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
        ),
        onChanged: (_) {
          // 즉시 클램프 & 콜백 (표시값도 바로 교정)
          final v = int.tryParse(_ctrl.text);
          if (v != null) {
            final c = v.clamp(widget.min, widget.max);
            if (c != v) {
              _ctrl.text = '$c';
              _ctrl.selection = TextSelection.collapsed(offset: _ctrl.text.length);
            }
            widget.onChanged(c);
          }
        },
        onEditingComplete: _applyClampAndNotify, // 엔터/완료 눌러도 포커스 유지
        onSubmitted: (_) => _applyClampAndNotify(),
      ),
    );
  }
}
