import 'package:flutter/material.dart';
import 'package:key_viewer_v2/core/lib/key_input_monitor.dart';
import 'package:key_viewer_v2/core/model/preset/preset_model.dart';

class KeyTilePreSetSettingsDialog extends StatefulWidget {
  final PresetModel? presetModel;
  const KeyTilePreSetSettingsDialog({super.key, this.presetModel});

  @override
  State<StatefulWidget> createState() => _KeyTilePreSetSettingsDialogState();

}

class _KeyTilePreSetSettingsDialogState extends State<KeyTilePreSetSettingsDialog> {
  final KeyInputMonitor keyInputMonitor = KeyInputMonitor();
  late PresetModel presetModel;
  final TextEditingController _nameCtrl = TextEditingController();

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

  @override
  void initState() {
    presetModel = widget.presetModel ?? PresetModel.empty();
    _nameCtrl.text = presetModel.presetName;
    keyInputMonitor.pressedKeys.addListener((){
      setState(() {
        presetModel = presetModel.copyWith(
          switchKey: keyInputMonitor.pressedKeys.value.first
        );
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    keyInputMonitor.stop();
    keyInputMonitor.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bg = const Color(0xFF202124);
    final textColor = Colors.white.withOpacity(0.92);

    return LayoutBuilder(builder: (context, c) {
      final w = 560.clamp(360.0, c.maxWidth - 48.0).toDouble();
      return Dialog(
        backgroundColor: bg,
        insetPadding:
        const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12)),
        child: SizedBox(
          width: w,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                  Text('프리셋 설정',
                      style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 16)),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close,
                        size: 18, color: Colors.white70),
                  ),
                ]),
                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    Text('프리셋 이름', style: _cap),
                    const SizedBox(width: 16),
                    SizedBox(
                      width: 300,
                      child: TextField(
                        controller: _nameCtrl,
                        textAlign: TextAlign.start,
                        textInputAction: TextInputAction.done,
                        onChanged: (txt) {
                          presetModel = presetModel.copyWith(presetName: txt);
                        },
                        onSubmitted: (txt) {
                          presetModel = presetModel.copyWith(presetName: txt);
                        },
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                        decoration: _fieldDeco(hint: ''),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 18,),

                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: presetModel.keyTileDataGroup.length,
                  itemBuilder: (context, index) {
                    final group = presetModel.keyTileDataGroup[index];
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(group.name),
                      subtitle: Text('Group ${index + 1}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          // Handle edit action
                        },
                      ),
                    );
                  },
                ),

                const SizedBox(height: 18,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('취소')),
                    const SizedBox(width: 8),
                    FilledButton(
                        onPressed: (){
                          Navigator.of(context).pop(presetModel);
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