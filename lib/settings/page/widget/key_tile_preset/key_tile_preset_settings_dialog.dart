import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:key_viewer_v2/core/lib/key_input_monitor.dart';
import 'package:key_viewer_v2/core/model/preset/preset_model.dart';
import 'package:key_viewer_v2/settings/data/preset/base/default_preset.dart';
import 'package:key_viewer_v2/settings/data/preset/djmax/djmax_preset.dart';
import 'package:key_viewer_v2/settings/data/preset/ez2on/ez2on_preset.dart';
import 'package:key_viewer_v2/settings/data/preset/musedash/musedash_preset.dart';
import 'package:key_viewer_v2/settings/page/settings_view_model.dart';
import 'package:key_viewer_v2/settings/page/widget/grid_snap_editor.dart';
import 'package:key_viewer_v2/settings/page/widget/key_tile_group/key_tile_group_settings_dialog.dart';
import 'package:uuid/v4.dart';

class KeyTilePresetSettingsDialog extends ConsumerStatefulWidget {
  final PresetModel? presetModel;
  const KeyTilePresetSettingsDialog({super.key, this.presetModel});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _KeyTilePresetSettingsDialogState();

}

class _KeyTilePresetSettingsDialogState extends ConsumerState<KeyTilePresetSettingsDialog> {
  final KeyInputMonitor keyInputMonitor = KeyInputMonitor();
  late PresetModel presetModel;
  final TextEditingController _nameCtrl = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isMapping = false;
  bool _advancedOpen = false;

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
    super.initState();
  }

  @override
  void dispose() {
    keyInputMonitor.stop();
    keyInputMonitor.dispose();
    super.dispose();
  }

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

    final pressedKeys = keyInputMonitor.snapshotPressed();
    if (pressedKeys.isEmpty) return;

    final vk = pressedKeys.first;

    // 마우스 관련 키 코드 필터링 (102는 마우스 버튼일 가능성)
    if (vk == 102 || vk == 1 || vk == 2) { // VK_LBUTTON, VK_RBUTTON 등
      return;
    }


    setState(() {
      presetModel = presetModel.copyWith(
          switchKey: keyInputMonitor.snapshotPressed().first
      );
      _isMapping = false;
    });

    keyInputMonitor.pressedKeys.removeListener(_onKey);
    keyInputMonitor.stop();
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
                      Text('프리셋 ${widget.presetModel == null ? '추가' : '수정'}',
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
                const SizedBox(height: 18,),
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

                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    Text('옵저버 활성화', style: _cap),
                    const SizedBox(width: 16),
                    Wrap(
                      crossAxisAlignment:
                      WrapCrossAlignment.center,
                      spacing: 8,
                      children: [
                        Switch(value: presetModel.isObservable, onChanged: (v){
                          setState(() {
                            presetModel = presetModel.copyWith(isObservable: v);
                          });
                        }),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 18,),

                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    Text('그룹 전환 키', style: _cap),
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
                                : (presetModel.switchKey != 0
                                ? "${presetModel.switchKey}"
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

                ExpansionTile(
                  initiallyExpanded: _advancedOpen,
                  onExpansionChanged: (v) => setState(() => _advancedOpen = v),
                  tilePadding: EdgeInsets.zero,
                  collapsedIconColor: Colors.white70,
                  iconColor: Colors.white70,
                  title: Text('기타 설정', style: _cap.copyWith(fontSize: 13)),
                  childrenPadding: EdgeInsets.zero,
                  children: [
                  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("히스토리바 방향", style: _cap),
                    const SizedBox(width: 16),
                    DropdownButton<HistoryAxis>(
                      value: presetModel.historyAxis,
                      dropdownColor: const Color(0xFF2A2C30),
                      items: [
                        ...HistoryAxis.values.map((e) =>
                            DropdownMenuItem(
                              value: e,
                              child: Text(e.optionName, style: const TextStyle(color: Colors.white)),
                            ),)
                      ],
                      onChanged: (v) {
                        if (v == null) return;
                        setState(() {
                          presetModel = presetModel.copyWith(historyAxis: v);
                        });
                      },
                    ),
                  ],
                ),
                  ],
                ),

                const SizedBox(height: 18,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    PopupMenuButton<PresetModel>(
                      tooltip: "",
                      itemBuilder: (context) {
                        return [
                          ...presetList.map((e) => PopupMenuItem<PresetModel>(
                            child: Text(e.presetName),
                            value: e,
                          )),

                          PopupMenuItem<PresetModel>(
                            child: Text(DEFAULTPresetModel.presetName),
                            value: DEFAULTPresetModel,
                          ),
                          PopupMenuItem<PresetModel>(
                            child: Text(DJMAXPresetModel.presetName),
                            value: DJMAXPresetModel,
                          ),
                          PopupMenuItem<PresetModel>(
                            child: Text(EZ2ONPresetModel.presetName),
                            value: EZ2ONPresetModel,
                          ),
                          PopupMenuItem<PresetModel>(
                            child: Text(MUSEDASHPresetModel.presetName),
                            value: MUSEDASHPresetModel,
                          ),
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