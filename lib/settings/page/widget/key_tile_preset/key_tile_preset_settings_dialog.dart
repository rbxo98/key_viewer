import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:key_viewer_v2/core/lib/key_input_monitor.dart';
import 'package:key_viewer_v2/core/model/preset/preset_model.dart';
import 'package:key_viewer_v2/settings/data/preset/djmax/djmax_preset.dart';
import 'package:key_viewer_v2/settings/page/settings_view_model.dart';
import 'package:key_viewer_v2/settings/page/widget/key_tile_group/key_tile_group_settings_dialog.dart';
import 'package:uuid/v4.dart';

class KeyTilePresetSettingsDialog extends ConsumerStatefulWidget {
  final PresetModel? presetModel;
  final bool isDeletable;
  const KeyTilePresetSettingsDialog({super.key, this.presetModel, this.isDeletable = false});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _KeyTilePresetSettingsDialogState();

}

class _KeyTilePresetSettingsDialogState extends ConsumerState<KeyTilePresetSettingsDialog> {
  final KeyInputMonitor keyInputMonitor = KeyInputMonitor();
  late PresetModel presetModel;
  final TextEditingController _nameCtrl = TextEditingController();
  final ScrollController _scrollController = ScrollController();

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
            switchKey: keyInputMonitor.snapshotPressed().first
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

  void _presetChanged(PresetModel preset) {
    final newPreset = presetModel.copyWith(
        primaryKey: UuidV4().generate(),
        presetName: "${preset.presetName} copy",
        switchKey: preset.switchKey,
        keyTileDataGroup: [...preset.keyTileDataGroup.map((e) =>
            e.copyWith(
                primaryKey: UuidV4().generate(),
              keyTileData: [
                ...e.keyTileData.map((k) => k.copyWith(primaryKey: UuidV4().generate()))
              ]
            ))
        ]
    );
    setState(() {
      presetModel = newPreset;
      _nameCtrl.text = newPreset.presetName;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bg = const Color(0xFF202124);
    final textColor = Colors.white.withOpacity(0.92);
    final presetList = ref.read(settingsViewModelProvider).presetList;
    return LayoutBuilder(builder: (context, c) {
      final w = 560.clamp(360.0, c.maxWidth - 48.0).toDouble();
      final maxH = MediaQuery.of(context).size.height*0.8;
      return Dialog(
        backgroundColor: bg,
        insetPadding:
        const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12)),
        child: Container(
          width: w,
          constraints: BoxConstraints(maxHeight: maxH, minHeight: 160),
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

                Flexible(
                  child: Scrollbar(
                    thumbVisibility: true,
                    controller: _scrollController,
                    child: ReorderableListView.builder(
                      scrollController: _scrollController,
                      shrinkWrap: true,
                      buildDefaultDragHandles: false,
                      itemCount: presetModel.keyTileDataGroup.length +1,
                      itemBuilder: (context, index) {
                        if(index < presetModel.keyTileDataGroup.length){
                          final group = presetModel.keyTileDataGroup[index];
                          return ReorderableDragStartListener(
                            key: ValueKey(group.primaryKey),
                            index: index,
                            child: ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text(group.name),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                spacing: 8,
                                children: [
                                  IconButton(onPressed: (){
                                    if(group.keyTileData.length <= 1) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text("더 이상 그룹을 제거할 수 없습니다."))
                                      );
                                      return;
                                    }
                                    setState(() {
                                      final newList = [...presetModel.keyTileDataGroup]..removeAt(index);
                                      presetModel = presetModel.copyWith(keyTileDataGroup: newList);
                                    });
                                  }, icon: const Icon(Icons.delete),),
                                  IconButton(
                                    icon: const Icon(Icons.edit),
                                    onPressed: () async {
                                      final data = await showDialog<KeyTileDataGroupModel>(
                                          context: context,
                                          builder: (BuildContext context) => KeyTileGroupSettingsDialog(
                                            keyTileDataGroup: group,
                                          )
                                      );
                                      if(data != null){
                                        setState(() {
                                          presetModel = presetModel.copyWith(keyTileDataGroup: presetModel.keyTileDataGroup.map((e) => e.primaryKey == data.primaryKey ? data : e).toList());
                                        });
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                        return FilledButton(
                            key: ValueKey("ADD_BUTTON"),
                            onPressed: () async {
                          final data = await showDialog<KeyTileDataGroupModel>(
                            context: context,
                            builder: (BuildContext context) => KeyTileGroupSettingsDialog());
                          if(data == null) return;
                          setState(() {
                            presetModel = presetModel.copyWith(keyTileDataGroup: [
                              ...presetModel.keyTileDataGroup,
                              data,
                            ]);
                          });
                        }, child: Icon(Icons.add));
                      },
                      onReorder: (int oldIndex, int newIndex) {
                        // 마지막 항목(추가 버튼)이 관련된 경우는 무시
                        if (oldIndex >= presetModel.keyTileDataGroup.length) {
                          return;
                        }

                        setState(() {
                          final List<KeyTileDataGroupModel> updatedList = List.from(presetModel.keyTileDataGroup);

                          // newIndex 조정 (추가 버튼 위치 고려)
                          if (newIndex > presetModel.keyTileDataGroup.length) {
                            newIndex = presetModel.keyTileDataGroup.length;
                          }

                          if (newIndex > oldIndex) {
                            newIndex -= 1;
                          }

                          final KeyTileDataGroupModel item = updatedList.removeAt(oldIndex);
                          updatedList.insert(newIndex, item);

                          presetModel = presetModel.copyWith(keyTileDataGroup: updatedList);
                        });
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 18,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    if(widget.isDeletable)
                      OutlinedButton(
                          onPressed: () {
                            Navigator.of(context).pop(presetModel.copyWith(isDeleted: true));
                          },
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
                          ))
                    else PopupMenuButton<PresetModel>(
                      tooltip: "",
                        itemBuilder: (context) {
                          return [
                            PopupMenuItem<PresetModel>(
                              child: Text(DJMAXPresetModel.presetName),
                              value: DJMAXPresetModel,
                            ),
                            ...presetList.map((e) => PopupMenuItem<PresetModel>(
                              child: Text(e.presetName),
                              value: e,
                            )),
                          ];
                        },
                        onSelected: (v) {
                          _presetChanged(v);
                        },
                      child: Text("기존 프리셋에서 선택"),
                    ),
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
              ],
            ),
          ),
        ),
      );
    });
  }

}