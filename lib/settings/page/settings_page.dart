import 'dart:convert';

import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:key_viewer_v2/core/lib/pref_provider.dart';
import 'package:key_viewer_v2/core/model/key/key_tile_data_model.dart';
import 'package:key_viewer_v2/settings/data/preset/djmax/djmax_preset.dart';
import 'package:key_viewer_v2/settings/page/settings_view_model.dart';
import 'package:key_viewer_v2/settings/page/widget/key_tile_group_settings_dialog.dart';
import 'package:key_viewer_v2/settings/page/widget/key_tile_preset_settings_dialog.dart';
import 'package:key_viewer_v2/settings/page/widget/key_tile_settings_dialog.dart';
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
    print(state.presetList);
    return Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(onPressed: (){
              PrefProvider.instance.clear();
            }, child: Text("설정 초기화")),
            Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              child: Column(
                spacing: 8,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    children: [
                      ElevatedButton(onPressed: () async {
                        if(state.window == null){
                          await viewModel.showOverlay();
                        }
                        else{
                          viewModel.closeOverlay();
                        }
                      }, child: Row(
                        spacing: 8,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("오버레이 ${state.window == null ? "표시" : "닫기"}"),
                          if(state.isOverlayLoading)
                            SizedBox(
                                width: 14,
                                height: 14,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                )),
                        ],
                      )),
                    ],
                  ),

                  Row(
                    spacing: 8,
                    children: [
                      DropdownButton(
                        value: state.currentPreset,
                          hint: Text("프리셋 선택"),
                          items: [
                            ...state.presetList.map((e) =>
                                DropdownMenuItem(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(e.presetName),
                                      IconButton(onPressed: (){

                                      }, icon: Icon(Icons.edit))
                                    ],
                                  ),
                                  value: e,)),
                          ], onChanged: (v){
                        viewModel.setPreset(v);
                        viewModel.updateOverlayKeyTile();
                      }),

                      FilledButton(onPressed: () async {
                        final data = await showDialog(context: context, builder: (_) => KeyTilePreSetSettingsDialog());
                        if(data != null) viewModel.addPreset(data);
                      }, child: Icon(Icons.add))
                    ],
                  ),

                  SizedBox(height: 8,),

                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      ...state.currentPreset.keyTileDataGroup.map((e) =>
                          FilledButton(
                              onPressed: (){
                                viewModel.setCurrentKeyTileDataGroup(
                                  state.currentPreset.keyTileDataGroup.indexOf(e)
                                );
                              },
                              child: Text(e.name))),
                      IconButton(onPressed: () async {
                        final data = await showDialog(context: context, builder: (_) => KeyTileGroupSettingsDialog());
                        if(data != null) viewModel.addKeyTileDataGroup(data);
                      }, icon: Icon(Icons.add)),
                    ],
                  )
                ],
              ),
            ),
            Expanded(
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

          Row(
            children: [
              Text('전역 환경 설정'),
              SizedBox(width: 20),
              FloatingActionButton(
                heroTag: null,
                onPressed: () async {
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