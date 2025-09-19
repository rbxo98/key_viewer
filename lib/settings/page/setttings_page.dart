import 'dart:convert';

import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:key_viewer_v2/core/lib/pref_provider.dart';
import 'package:key_viewer_v2/core/model/key/key_tile_data_model.dart';
import 'package:key_viewer_v2/settings/page/settings_view_model.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await PrefProvider.init();
      await viewModel.getGlobalConfig();
      final globalConfig = ref.read(settingsViewModelProvider).globalConfig;
      viewModel.setWindowSize(Size(globalConfig.windowWidth, globalConfig.windowHeight));
      viewModel.setWindowPosition(pos: Offset(globalConfig.windowX, globalConfig.windowY));
      viewModel.showOverlay();
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
    }
  }

  @override
  Widget build(BuildContext context) {
    final spec = SnapGridSpec(cell: _cell, gap: _gap);
    final state = ref.watch(settingsViewModelProvider);
    return Scaffold(
        body: Column(
          children: [
            Wrap(
              children: [
                DropdownButton(items: [], onChanged: (v){})
              ],
            ),
            Expanded(
              child: Stack(
                children: [
                  GridSnapEditor(
                    grid: spec,
                    targetKeyList: state.keyTileData,
                    onChanged: (updated) {
                      viewModel.updateKeyTileData(updated);
                    },
                    onPixelSizeChanged: (size){
                      viewModel.setEditorSize(size);
                      viewModel.resizeOverlay();
                    }, pressedKeySet: {},
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
                viewModel.setWindowSizeLock(!state.windowSizeLock);
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