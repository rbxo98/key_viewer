import 'dart:convert';

import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:key_viewer_v2/core/lib/key_input_monitor.dart';
import 'package:key_viewer_v2/core/lib/pref_provider.dart';
import 'package:key_viewer_v2/core/model/key/key_tile_data_model.dart';
import 'package:key_viewer_v2/core/model/preset/preset_model.dart';
import 'package:key_viewer_v2/settings/app/setting_app.dart';
import 'package:key_viewer_v2/settings/data/preset/base/observer_group.dart';
import 'package:key_viewer_v2/settings/data/preset/djmax/djmax_preset.dart';
import 'package:key_viewer_v2/settings/page/settings_preset_management_dialog.dart';
import 'package:key_viewer_v2/settings/page/settings_view_model.dart';
import 'package:key_viewer_v2/settings/page/widget/key_tile_group/group_button.dart';
import 'package:key_viewer_v2/settings/page/widget/key_tile_group/key_tile_group_settings_dialog.dart';
import 'package:key_viewer_v2/settings/page/widget/key_tile_preset/key_tile_preset_settings_dialog.dart';
import 'package:key_viewer_v2/settings/page/widget/key_tile_settings_dialog.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:win32/win32.dart';
import 'package:window_manager_plus/window_manager_plus.dart';

import 'widget/grid_snap_editor.dart';

class KeyViewerSettingsPage extends ConsumerStatefulWidget {
  const KeyViewerSettingsPage({Key? key}) : super(key: key);

  @override
  ConsumerState<KeyViewerSettingsPage> createState() => _KeyViewerSettingsPageState();
}

class _KeyViewerSettingsPageState extends ConsumerState<KeyViewerSettingsPage> with WindowListener {
  late final SettingsViewModel viewModel;
  final KeyInputMonitor keyInputMonitor = KeyInputMonitor();

  @override
  void initState() {
    viewModel = ref.read(settingsViewModelProvider.notifier);
    viewModel.initKeyMonitoring();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await viewModel.getGlobalConfig();
      final state = ref.read(settingsViewModelProvider);
      await viewModel.setWindowSize(Size(state.globalConfig.windowWidth, state.globalConfig.windowHeight));
      viewModel.setWindowPosition(pos: Offset(state.globalConfig.windowX, state.globalConfig.windowY));
      viewModel.setWindowLock();
    });
    WindowManagerPlus.current.addListener(this);
    super.initState();
  }

  double _cell = 4;
  double _gap  = 1;


  @override
  void onWindowResized([int? windowId]) async {
    final size = await WindowManagerPlus.current.getSize();
    viewModel.setWindowSizeConfig(size : size);
  }


  @override
  void onWindowMove([int? windowId]) async {
    final pos = await WindowManagerPlus.current.getPosition();
    viewModel.setWindowPositionConfig(pos : pos);
  }

  @override
  Future<dynamic> onEventFromWindow(String eventName, int fromWindowId, dynamic arguments) async {
    switch (eventName) {
      case "updateOverlayPos": {
        final arg = arguments as List<dynamic>;
        final pos = Offset(arg[0] as double, arg[1] as double);
        viewModel.setOverlayPositionConfig(pos: pos);
        return true;
      }
      case "overlayClose" : {
        viewModel.closeOverlay();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final spec = SnapGridSpec(cell: _cell, gap: _gap);
    final state = ref.watch(settingsViewModelProvider);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            child: Column(
              spacing: 8,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  spacing: 8,
                  children: [
                    DropdownButton(
                        value: state.currentPreset,
                        padding: EdgeInsets.zero,
                        hint: Text("프리셋 선택"),
                        items: [
                          ...state.presetList.map((e) =>
                              DropdownMenuItem(
                                child: Text(e.presetName),
                                value: e,)),
                          DropdownMenuItem(child: Text("프리셋 추가"), value: null,)
                        ], onChanged: (v) async {
                      if(v == null){
                        final data = await showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (_) => KeyTilePresetSettingsDialog());
                        if(data != null) viewModel.addPreset(data);
                      }
                      else{
                        viewModel.setPreset(v);
                        viewModel.updateOverlayKeyTile();
                      }
                    }),

                    InkWell(
                      onTap: () async {
                        final data = await showDialog<PresetModel>(
                            barrierDismissible: false,
                            context: context,
                            builder: (_) =>
                                KeyTilePresetSettingsDialog(
                                  presetModel: state.currentPreset,
                                ));
                        if(data == null) return;
                        if(data.isDeleted){
                          viewModel.deletePreset(data);
                        }
                        else{
                          viewModel.updatePresetInfo(data);
                        }
                        viewModel.updateOverlayKeyTile();
                      },
                      customBorder: CircleBorder(),
                      child: Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: SettingsTokens.primary
                        ),
                        child: Icon(Icons.edit),
                      ),
                    )
                  ],
                ),
               if(state.currentPreset.isObservable)
               ...[
                 SizedBox(height: 8,),
                SizedBox(
                  height: 32,
                  width: 120,
                  child: AnimatedToggleSwitch<bool>.dual(
                    current: state.currentPreset.isObserver,
                    first: true,
                    second: false,
                    onChanged: (v) => viewModel.setCurrentPresetObserver(v),
                    styleBuilder: (b) => ToggleStyle(
                        borderColor: SettingsTokens.primary,
                        indicatorColor: SettingsTokens.primary
                    ),
                    iconBuilder: (value) => value
                        ? const Icon(Icons.coronavirus_rounded)
                        : const Icon(Icons.tag_faces_rounded),
                    textBuilder: (value) => value
                        ? const Center(child: Text('관전O'))
                        : const Center(child: Text('관전X')),
                  ),
                ),
               ],

                SizedBox(height: 8,),

                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    if(state.currentPreset.isObserver)
                      KeyTileGroupButton(
                        isSelected: state.currentPreset.currentGroupIdx==-1,
                        group: observerGroup,
                        onTap: (){
                          viewModel.setCurrentKeyTileDataGroup(-1);
                        },
                        onRemove: (group) {},
                      ),
                    ...state.currentPreset.keyTileDataGroup.map((e) =>
                        KeyTileGroupButton(
                          group: e,
                          isSelected: state.currentPreset.keyTileDataGroup.indexOf(e) == state.currentPreset.currentGroupIdx,
                          onTap: (){
                            viewModel.setCurrentKeyTileDataGroup(
                                state.currentPreset.keyTileDataGroup.indexOf(e)
                            );
                          },
                          onRemove: (group) {
                            viewModel.removeKeyTileDataGroup(group);
                          },
                        )),
                    IconButton(onPressed: () async {
                      final data = await showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (_) => KeyTileGroupSettingsDialog());
                      if(data != null) viewModel.addKeyTileDataGroup(data);
                    }, icon: Icon(Icons.add)),
                  ],
                )
              ],
            ),
          ),
          Expanded(
            child: GestureDetector(
              onSecondaryTap: () async {
                final data = await showDialog<KeyTileDataModel>(
                    context: context,
                    builder: (_) => KeyTileSettingDialog(cellPx: _cell, gapPx: _gap,),
                    barrierDismissible: false
                );
                if(data != null){
                  viewModel.addKeyTile(data);
                }
              },
              child: Stack(
                children: [
                  GridSnapEditor(
                    grid: spec,
                    targetKeyList: state.currentPreset.getCurrentKeyTileData.toSet(),
                    onChanged: (updated) {
                      viewModel.updateKeyTileData(updated);
                    },
                    onPixelSizeChanged: (size){
                      // 1) 논리 px → 물리 px 변환
                      final dpr = View.of(context).devicePixelRatio; // or MediaQuery.of(context).devicePixelRatio
                      final physicalSize = Size(size.width * dpr, size.height * dpr);

                      viewModel.setEditorSize(physicalSize);
                      viewModel.resizeOverlay();
                    },
                    pressedKeySet: {},
                    onInitialize: (size) async {
                      final dpr = View.of(context).devicePixelRatio;
                      final physicalSize = Size(size.width * dpr, size.height * dpr);
                      await viewModel.setEditorSize(physicalSize);
                      await viewModel.showOverlay();
                    },
                  ),


                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: ExpandableFab(
        openButtonBuilder: RotateFloatingActionButtonBuilder(
            child: Icon(Icons.settings),
            shape: CircleBorder()
        ),
        closeButtonBuilder: RotateFloatingActionButtonBuilder(
          child: Icon(Icons.close),
        ),
        type: ExpandableFabType.up,
        childrenAnimation: ExpandableFabAnimation.none,
        distance: 70,
        children: [
          Row(
            children: [
              Text('키 추가'),
              SizedBox(width: 20),
              FloatingActionButton(
                heroTag: null,
                onPressed: () async {
                  final data = await showDialog<KeyTileDataModel>(
                      context: context,
                      builder: (_) => KeyTileSettingDialog(cellPx: _cell, gapPx: _gap,),
                      barrierDismissible: false
                  );
                  if(data != null){
                    viewModel.addKeyTile(data);
                  }
                },
                child: Icon(Icons.add),
              ),
            ],
          ),
          Row(
            children: [
              Text('프리셋 관리'),
              SizedBox(width: 20),
              FloatingActionButton(
                heroTag: null,
                onPressed: () async {
                  await showDialog(context: context, builder: (_) => SettingsPresetManagementDialog());
                },
                child: Icon(Icons.menu_book),
              ),
            ],
          ),

          Row(
            children: [
              Text('윈도우 사이즈 잠금'),
              SizedBox(width: 20),
              FloatingActionButton(
                heroTag: null,
                onPressed: () async {
                  viewModel.toggleWindowSizeLock();
                },
                child: state.windowSizeLock?Icon(Icons.lock_open):Icon(Icons.lock),
              ),
            ],
          ),


          // Row(
          //   children: [
          //     Text('전역 환경 설정'),
          //     SizedBox(width: 20),
          //     FloatingActionButton(
          //       heroTag: null,
          //       onPressed: () async {
          //       },
          //       child: Icon(Icons.settings_applications),
          //     ),
          //   ],
          // ),

          Row(
            children: [
              Text('개발 정보'),
              SizedBox(width: 20),
              FloatingActionButton(
                heroTag: null,
                onPressed: () async {
                  launchUrl(Uri.parse('https://lily-library-75e.notion.site/27cc4ce720f38079860ec95b71d189ea?pvs=74'));
                },
                child: Icon(Icons.settings_applications),
              ),
            ],
          ),
        ],
      ),
    );
  }
}