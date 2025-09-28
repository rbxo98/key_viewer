import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:key_viewer_v2/core/lib/key_input_monitor.dart';
import 'package:key_viewer_v2/core/model/preset/preset_model.dart';
import 'package:key_viewer_v2/core/widget/dialog/custom_select_dialog.dart';
import 'package:key_viewer_v2/settings/data/preset/djmax/djmax_preset.dart';
import 'package:key_viewer_v2/settings/page/settings_view_model.dart';
import 'package:key_viewer_v2/settings/page/widget/key_tile_group/key_tile_group_settings_dialog.dart';
import 'package:key_viewer_v2/settings/page/widget/key_tile_preset/key_tile_preset_settings_dialog.dart';

class SettingsPresetManagementDialog extends ConsumerStatefulWidget {
  final PresetModel? presetModel;
  final bool isDeletable;
  const SettingsPresetManagementDialog({super.key, this.presetModel, this.isDeletable = false});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingsPresetManagementDialogState();

}

class _SettingsPresetManagementDialogState extends ConsumerState<SettingsPresetManagementDialog> {
  late final viewModel = ref.read(settingsViewModelProvider.notifier);
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _presetChanged(PresetModel preset) => setState(() {

  });

  @override
  Widget build(BuildContext context) {
    final bg = const Color(0xFF202124);
    final textColor = Colors.white.withOpacity(0.92);
    final presetList = ref.read(settingsViewModelProvider).presetList;
    final state = ref.watch(settingsViewModelProvider);
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
                      Row(
                        spacing: 8,
                        children: [
                          Text('프리셋 관리',
                              style: TextStyle(
                                  color: textColor,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16)),
                          Tooltip(
                              message: "드래그 앤 드랍으로 순서 변경",
                              child: Icon(Icons.info_outline, size: 18,)),
                        ],
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close,
                            size: 18, color: Colors.white70),
                      ),
                    ]),

                Flexible(
                  child: Scrollbar(
                    thumbVisibility: true,
                    controller: _scrollController,
                    child: ReorderableListView.builder(
                      scrollController: _scrollController,
                      shrinkWrap: true,
                      buildDefaultDragHandles: false,
                      itemCount: state.presetList.length + 1,
                      itemBuilder: (context, index) {
                        if(index <state.presetList.length){
                          final preset = state.presetList[index];
                          return ReorderableDragStartListener(
                            key: ValueKey(preset.primaryKey),
                            index: index,
                            child: ListTile(
                              onTap: (){
                                viewModel.setPreset(state.presetList[index]);
                                viewModel.updateOverlayKeyTile();
                              },
                              contentPadding: EdgeInsets.zero,
                              title: Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: preset.presetName,
                                    ),
                                    if(state.currentPreset.primaryKey == preset.primaryKey)
                                      const TextSpan(text: " (현재 사용중)", style: TextStyle(color: Colors.greenAccent))
                                  ]
                                )
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                spacing: 8,
                                children: [
                                  IconButton(onPressed: () async {
                                    if(state.presetList.length == 1) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: const Text("더 이상 프리셋을 제거할 수 없습니다.")));
                                      return;
                                    }
                                    showDialog(context: context, builder: (_) => CustomSelectDialog(
                                        title: "${preset.presetName} 프리셋을 제거합니다.",
                                        confirmText: "확인",
                                        onConfirm: () {
                                          final presetList = [...state.presetList];
                                          final targetIndex = presetList.indexWhere((p) => p.primaryKey == preset.primaryKey);
                                          presetList.removeAt(targetIndex);
                                          final nextIndex = targetIndex == index ? 0 : index;
                                          viewModel.updatePresetListInfo(presetList);
                                          viewModel.setPreset(presetList[nextIndex]);
                                          viewModel.updateOverlayKeyTile();
                                        }
                                    ));
                                  }, icon: const Icon(Icons.delete),),
                                  IconButton(
                                    icon: const Icon(Icons.edit),
                                    onPressed: () async {
                                      final data = await showDialog(context: context, builder: (_) => KeyTilePresetSettingsDialog(presetModel: preset));
                                      if(data != null) {
                                        final presetList = [...state.presetList];
                                        final targetIndex = presetList.indexWhere((p) => p.primaryKey == preset.primaryKey);
                                        presetList[targetIndex] = data;
                                        viewModel.updatePresetListInfo(presetList);
                                        viewModel.setPreset(data);
                                        viewModel.updateOverlayKeyTile();
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
                              final data = await showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (_) => KeyTilePresetSettingsDialog());
                              if(data != null) {
                                viewModel.addPreset(data);
                                viewModel.updateOverlayKeyTile();
                              }
                            }, child: Icon(Icons.add));
                      },
                      onReorder: (int oldIndex, int newIndex) {
                        // 마지막 항목(추가 버튼)이 관련된 경우는 무시
                        if (oldIndex >= state.presetList.length) {
                          return;
                        }

                        setState(() {
                          final List<PresetModel> updatedList = List.from(state.presetList);

                          // newIndex 조정 (추가 버튼 위치 고려)
                          if (newIndex > state.presetList.length) {
                            newIndex = state.presetList.length;
                          }

                          if (newIndex > oldIndex) {
                            newIndex -= 1;
                          }

                          final PresetModel item = updatedList.removeAt(oldIndex);
                          updatedList.insert(newIndex, item);
                          viewModel.updatePresetListInfo(updatedList);
                        });
                        if (oldIndex >= state.presetList.length ||
                            newIndex >= state.presetList.length) {
                          return;
                        }
                      },
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      );
    });
  }

}