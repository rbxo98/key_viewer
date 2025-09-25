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
import 'package:key_viewer_v2/settings/page/model/settings_model_extension.dart';
import 'package:win32/win32.dart';
import 'package:window_manager_plus/window_manager_plus.dart';
import 'package:key_viewer_v2/core/model/config/config_model_extension.dart';

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

  void _updateKeyCount(Set<int> currentKeys) {
    final newlyPressed = currentKeys.difference(_previousPressedKeys);
    state = state.updateKeyCountSync(currentKeys, newlyPressed);
  }

  void updateKeyTileData(Set<KeyTileDataModel> data) {
    state = state.updateKeyTileDataSync(data);
    PrefProvider.instance.setGlobalConfig(state.globalConfig);
    updateOverlayKeyTile();
  }

  void addKeyTile(KeyTileDataModel model) {
    state = state.addKeyTileSync(model);
    PrefProvider.instance.setGlobalConfig(state.globalConfig);
    updateOverlayKeyTile();
  }

  void addPreset(PresetModel data) {
    state = state.addPresetSync(data);
    PrefProvider.instance.setGlobalConfig(state.globalConfig);
  }

  void setPreset(PresetModel? preset) {
    if (preset == null) return;
    state = state.setPresetSync(preset);
    PrefProvider.instance.setGlobalConfig(state.globalConfig);
  }

  void updatePresetInfo(PresetModel preset) {
    state = state.updatePresetInfoSync(preset);
    PrefProvider.instance.setGlobalConfig(state.globalConfig);
  }

  void updatePresetListInfo(List<PresetModel> data) {
    state = state.updatePresetListInfoSync(data);
    PrefProvider.instance.setGlobalConfig(state.globalConfig);
  }

  void deletePreset(PresetModel data) {
    state = state.deletePresetSync(data);
    PrefProvider.instance.setGlobalConfig(state.globalConfig);
  }

  void addKeyTileDataGroup(KeyTileDataGroupModel data) {
    state = state.addKeyTileDataGroupSync(data);
    PrefProvider.instance.setGlobalConfig(state.globalConfig);
  }


  void removeKeyTileDataGroup(KeyTileDataGroupModel group) {
    state = state.removeKeyTileDataGroupSync(group);
    PrefProvider.instance.setGlobalConfig(state.globalConfig);
  }



  void setCurrentKeyTileDataGroup(int groupIndex) {
    state = state.setCurrentKeyTileDataGroupSync(groupIndex);
    PrefProvider.instance.setGlobalConfig(state.globalConfig);

    // 오버레이가 열려있다면 새 그룹 데이터로 업데이트
    if (state.window != null) {
      updateOverlayKeyTile();
    }
  }

  /// 현재 프리셋의 isObserver 값을 설정하는 메소드
  void setCurrentPresetObserver(bool isObserver) {
    state = state.setCurrentPresetObserverSync(isObserver);
    PrefProvider.instance.setGlobalConfig(state.globalConfig);

    // 옵션: 오버레이가 열려있다면 업데이트
    if (state.window != null) {
      updateOverlayKeyTile();
    }
  }

  void setWindowSizeConfig({required Size size}) {
    final updatedGlobalConfig = state.globalConfig.updateWindowSettings(
        windowWidth: size.width,
        windowHeight: size.height
    );
    state = state.copyWith(globalConfig: updatedGlobalConfig);
    PrefProvider.instance.setGlobalConfig(state.globalConfig);
  }

  void setWindowPositionConfig({required Offset pos}) {
    final updatedGlobalConfig = state.globalConfig.updateWindowSettings(
        windowX: pos.dx,
        windowY: pos.dy
    );
    state = state.copyWith(globalConfig: updatedGlobalConfig);
    PrefProvider.instance.setGlobalConfig(state.globalConfig);
  }

  void setOverlayPositionConfig({required Offset pos}) {
    final updatedGlobalConfig = state.globalConfig.updateOverlaySettings(
        overlayX: pos.dx,
        overlayY: pos.dy
    );
    state = state.copyWith(globalConfig: updatedGlobalConfig);
    PrefProvider.instance.setGlobalConfig(state.globalConfig);
  }

  Future<void> setEditorSize(Size size) async {
    final updatedGlobalConfig = state.globalConfig.updateOverlaySettings(
        overlayWidth: size.width,
        overlayHeight: size.height
    );
    state = state.copyWith(
        overlayWidth: size.width,
        overlayHeight: size.height,
        globalConfig: updatedGlobalConfig
    );
    PrefProvider.instance.setGlobalConfig(state.globalConfig);
  }

  void toggleWindowSizeLock() {
    final value = !state.windowSizeLock;
    final updatedGlobalConfig = state.globalConfig.updateWindowSettings(isWindowSizeLock: value);
    state = state.copyWith(
        windowSizeLock: value,
        globalConfig: updatedGlobalConfig
    );
    WindowManagerPlus.current.setResizable(value);
    PrefProvider.instance.setGlobalConfig(state.globalConfig);
  }





  void initKeyMonitoring() {
    keyInputMonitor.pressedKeys.addListener(_onKeyPressed);
    keyInputMonitor.pressedKeys.addListener(_onGroupSwitchKeyPressed);
    keyInputMonitor.start();
  }

  void _onGroupSwitchKeyPressed() {
    final targetKey = state.currentPreset.switchKey;
    final currentKeys = keyInputMonitor.pressedKeys.value;
    final currentPreset = state.currentPreset;
    if (currentKeys.length == 1 && currentKeys.contains(targetKey)) {
      int idx = currentPreset.currentGroupIdx+1;
      if(idx >= currentPreset.keyTileDataGroup.length){
        idx = state.currentPreset.isObserver ? -1 : 0;
      }
      setCurrentKeyTileDataGroup(idx);
    }
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
    print(state.currentPreset.keyTileDataGroup);
    await WindowManagerPlus.current.invokeMethodToWindow(
        window.id,
        "updateKeyTile",
        jsonEncode([
          state.currentPreset.getCurrentGroup.keyTileData.toList(),
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

  Future<void> getGlobalConfig() async {
    final globalConfig = (await PrefProvider.instance.getGlobalConfig());
    state = state.copyWith(
        globalConfig: globalConfig,
        presetList: globalConfig.presetList,
        currentPreset: globalConfig.presetList
            .firstWhereOrNull((e) => e.presetName == globalConfig.currentPresetName) ?? PresetModel.empty());

  }



}