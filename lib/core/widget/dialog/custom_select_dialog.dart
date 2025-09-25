import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomSelectDialog extends StatefulWidget {
  final String title;
  final String? subTitle;
  final String? confirmText;
  final String cancelText;
  final void Function() onConfirm;
  final void Function()? onCancel;
  CustomSelectDialog({required this.title, this.subTitle, this.confirmText = "확인", this.cancelText = '취소', required this.onConfirm, this.onCancel});
  @override
  State<StatefulWidget> createState() => _CustomSelectDialogState();

}

class _CustomSelectDialogState extends State<CustomSelectDialog> {
  @override
  Widget build(BuildContext context) {
    final bg = const Color(0xFF202124);
    final textColor = Colors.white.withOpacity(0.92);

    return LayoutBuilder(builder: (context, c) {
      return Dialog(
        backgroundColor: bg,
        insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12)),
        child: Container(
          width: 250,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 12),
            child: Column(
              spacing: 16,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(widget.title,),
                if(widget.subTitle != null)
                Text(widget.subTitle!, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: textColor),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          widget.onCancel?.call();
                        },
                        child: const Text('취소')),
                    const SizedBox(width: 8),
                    FilledButton(
                        onPressed: (){
                          Navigator.of(context).pop();
                          widget.onConfirm();
                        },
                        child: const Text('완료')),
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