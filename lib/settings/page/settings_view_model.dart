import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:key_viewer_v2/core/lib/key_input_monitor.dart';
import 'package:key_viewer_v2/core/lib/pref_provider.dart';
import 'package:key_viewer_v2/core/model/multi_window_option/multi_window_option_model.dart';
import 'package:key_viewer_v2/core/model/key/key_tile_data_model.dart';
import 'package:key_viewer_v2/core/model/preset/preset_model.dart';
import 'package:key_viewer_v2/settings/data/preset/djmax/djmax_preset.dart';
import 'package:key_viewer_v2/settings/page/model/settings_model.dart';
import 'package:win32/win32.dart';
import 'package:window_manager_plus/window_manager_plus.dart';

final settingsViewModelProvider = StateNotifierProvider<SettingsViewModel, SettingsModel>((ref) => SettingsViewModel());

class SettingsViewModel extends StateNotifier<SettingsModel> {
  final KeyInputMonitor keyInputMonitor = KeyInputMonitor();
  Set<int> _previousPressedKeys = {};

  SettingsViewModel() : super(SettingsModel.empty()) {
    DesktopMultiWindow.setMethodHandler((method, args) async {
      switch (method.method) {
        case "closeOverlay": {
          state = state.copyWith(window: null);
        }
        default:
          return null;
      }
    });
  }




  void initKeyMonitoring() {
    keyInputMonitor.pressedKeys.addListener(_onKeyPressed);
    keyInputMonitor.start();
  }

  void _onKeyPressed() {
    final currentKeys = keyInputMonitor.pressedKeys.value;

    _updateKeyCount(currentKeys);
    _saveToPreferences(); // 실시간 저장
    if(state.window != null) {
      updateOverlayKeyTile(); // 오버레이 동기화
    }
    _previousPressedKeys = Set.from(currentKeys);
  }

  void _updateKeyCount(Set<int> currentKeys) {
    final currentPreset = state.currentPreset;

    final newlyPressed = currentKeys.difference(_previousPressedKeys);
    final updatedData = state.currentPreset.getCurrentGroup.keyTileData.map((tile) {
      if (newlyPressed.contains(tile.key)) {
        return tile.copyWith(keyCount: tile.keyCount + 1);
      }
      return tile;
    }).toSet();

    final updatedKeySetGroup = [...currentPreset.keyTileDataGroup];
    updatedKeySetGroup[state.currentPreset.currentGroupIdx] = updatedKeySetGroup[state.currentPreset.currentGroupIdx].copyWith(keyTileData: updatedData.toList());

    state = state
        .copyWith(pressedKeySet: currentKeys)
        .copyWith.currentPreset(keyTileDataGroup: updatedKeySetGroup);
  }

  void _saveToPreferences() {
    state = state.copyWith.globalConfig(currentPresetName: state.currentPreset.presetName);
    PrefProvider.instance.setGlobalConfig(state.globalConfig);
  }
  
  Future<void> setWindowSize(Size? size) async {
    if(size != null) WindowManagerPlus.current.setSize(size);
    WindowManagerPlus.current.setMinimumSize(Size(600,600));
  }


  void setWindowPosition({Offset? pos}) {
    if(pos != null) WindowManagerPlus.current.setPosition(pos);
  }

  Future<WindowManagerPlus?> showOverlay() async {
    if(state.isOverlayLoading) return null;
    state = state.copyWith(isOverlayLoading : true);
    final window = await WindowManagerPlus.createWindow(
      [jsonEncode(MultiWindowOptionModel(
        windowName : "KeyViewerOverlay",
        windowWidth: state.overlayWidth,
        windowHeight: state.overlayHeight,
        windowX: state.globalConfig.overlayX,
        windowY: state.globalConfig.overlayY,
        isFrameless: true,
        cell: state.cell,
        gap: state.gap,
      ).toJson())],
    );
    await window?.setSize(Size(state.overlayWidth, state.overlayHeight));
    await window?.setPosition(Offset(state.globalConfig.overlayX, state.globalConfig.overlayY));
    await window?.setAsFrameless();
    await window?.show();
    state = state.copyWith(window: window);
    await updateOverlayKeyTile();
    state = state.copyWith(isOverlayLoading : false);
    return window;
  }

  Future<void> resizeOverlay() async {
    final window = state.window;
    await window?.setSize(Size(state.overlayWidth, state.overlayHeight));
    state = state.copyWith(window: window);
  }


  void setWindowLock() async {
    WindowManagerPlus.current.setResizable(state.windowSizeLock);
  }

  Future<void> updateOverlayKeyTile() async {
    final window = state.window;
    if(window == null) return;
    await WindowManagerPlus.current.invokeMethodToWindow(
        window.id,
        "updateKeyTile",
        jsonEncode([
          state.currentPreset.keyTileDataGroup[state.currentPreset.currentGroupIdx].keyTileData.toList(),
          state.pressedKeySet.toList()
        ]));
  }


  Future<bool> closeOverlay() async {
    try{
      state.window?.close();
      state = state.copyWith(window: null);
      return true;
    }
    catch(e){
      print(e);
      return false;
    }
  }

  void updateKeyTileData(Set<KeyTileDataModel> data) {
    final preset = state.currentPreset;
    final group = preset.getCurrentGroup.copyWith(keyTileData: data.toList());
    final newGroup = [...preset.keyTileDataGroup];
    newGroup[preset.currentGroupIdx] = group;

    state = state.copyWith.currentPreset(keyTileDataGroup: newGroup);
    updateOverlayKeyTile();
  }

  void addKeyTile(KeyTileDataModel model) {
    final preset = state.currentPreset;
    final data = {...preset.getCurrentKeyTileData, model};
    final group = preset.getCurrentGroup.copyWith(keyTileData: data.toList());
    final newGroup = [...preset.keyTileDataGroup];
    newGroup[preset.currentGroupIdx] = group;

    state = state
        .copyWith.globalConfig(currentPresetName: state.currentPreset.presetName)
        .copyWith.currentPreset(keyTileDataGroup: newGroup);
    updateOverlayKeyTile();
  }


  Future<void> setEditorSize(Size size) async {
    state = state.copyWith(overlayWidth: size.width, overlayHeight: size.height)
        .copyWith.globalConfig(overlayWith: size.width, overlayHeight: size.height);
    PrefProvider.instance.setGlobalConfig(state.globalConfig);
  }

  Future<void> getGlobalConfig() async {
    final globalConfig = (await PrefProvider.instance.getGlobalConfig());
    state = state.copyWith(
        globalConfig: globalConfig,
        presetList: globalConfig.presetList,
        currentPreset: globalConfig.presetList
            .firstWhereOrNull((e) => e.presetName == globalConfig.currentPresetName) ?? PresetModel.empty());

  }

  void setWindowSizeConfig({required Size size}) {
    state = state.copyWith.globalConfig(windowWidth: size.width, windowHeight: size.height);
    PrefProvider.instance.setGlobalConfig(state.globalConfig);
  }


  void setWindowPositionConfig({required Offset pos}) async  {
    state = state.copyWith.globalConfig(windowX: pos.dx, windowY: pos.dy,);
    PrefProvider.instance.setGlobalConfig(state.globalConfig);
  }

  void setOverlayPositionConfig({required Offset pos}) {
    state = state.copyWith.globalConfig(overlayX: pos.dx, overlayY: pos.dy,);
    PrefProvider.instance.setGlobalConfig(state.globalConfig);
  }

  void toggleWindowSizeLock() {
    final value = !state.windowSizeLock;
    state = state.copyWith(windowSizeLock: value).copyWith.globalConfig(isWindowSizeLock: value);
    WindowManagerPlus.current.setResizable(value);
    PrefProvider.instance.setGlobalConfig(state.globalConfig);
  }

  void setPreset(PresetModel? preset) {
    if(preset == null) return;
    
    state = state
        .copyWith.globalConfig(currentPresetName: preset.presetName)
        .copyWith(currentPreset: preset);
    PrefProvider.instance.setGlobalConfig(state.globalConfig);
  }

  void addPreset(PresetModel data) {
    final presetList = [...state.presetList, data];
    state = state
        .copyWith.globalConfig(presetList: presetList, currentPresetName: data.presetName)
        .copyWith(presetList: presetList, currentPreset: data);
    PrefProvider.instance.setGlobalConfig(state.globalConfig);
  }

  void addKeyTileDataGroup(KeyTileDataGroupModel data) {
    final currentGroupList = [...state.currentPreset.keyTileDataGroup, data];
    final currentPresetList = [...state.presetList];
    final targetPresetIdx = state.getCurrentPresetIndex;

    final updatedPreset = currentPresetList[targetPresetIdx].copyWith(keyTileDataGroup: currentGroupList);
    currentPresetList[targetPresetIdx] = updatedPreset;

    state = state
        .copyWith.globalConfig(presetList: currentPresetList)
        .copyWith(
      presetList: currentPresetList,
      currentPreset: updatedPreset,
    );
    PrefProvider.instance.setGlobalConfig(state.globalConfig);
  }

  void setCurrentKeyTileDataGroup(int groupIndex) {
    if (groupIndex < 0 || groupIndex >= state.currentPreset.keyTileDataGroup.length) {
      return; // 범위 벗어남
    }

    // 1. currentPreset의 currentGroupIdx 업데이트
    final updatedCurrentPreset = state.currentPreset.copyWith(currentGroupIdx: groupIndex);

    // 2. presetList에서 해당 preset도 동일하게 업데이트
    final updatedPresetList = [...state.presetList];
    final targetPresetIdx = state.getCurrentPresetIndex;
    updatedPresetList[targetPresetIdx] = updatedCurrentPreset;

    // 3. state와 globalConfig 모두 업데이트
    state = state
        .copyWith.globalConfig(presetList: updatedPresetList)
        .copyWith(
      presetList: updatedPresetList,
      currentPreset: updatedCurrentPreset,
    );

    // 4. 설정 저장
    PrefProvider.instance.setGlobalConfig(state.globalConfig);

    // 5. 오버레이가 열려있다면 새 그룹 데이터로 업데이트
    if (state.window != null) {
      updateOverlayKeyTile();
    }
  }



}