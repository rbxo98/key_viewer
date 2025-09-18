import 'dart:convert';

import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:key_viewer_v2/core/model/key/key_tile_data_model.dart';
import 'package:key_viewer_v2/core/model/multi_window_option/multi_window_option_model.dart';
import 'package:key_viewer_v2/settings/page/model/settings_model.dart';
import 'package:window_manager_plus/window_manager_plus.dart';

final settingsViewModelProvider = StateNotifierProvider<SettingsViewModel, SettingsModel>((ref) => SettingsViewModel());

class SettingsViewModel extends StateNotifier<SettingsModel> {
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

  Future<WindowManagerPlus?> showOverlay() async {
    if (state.window != null) return state.window!;
    final window = await WindowManagerPlus.createWindow(
      [ jsonEncode(MultiWindowOptionModel(
        windowName : "KeyViewerOverlay",
      ).toJson())],
    );
    window?.setBackgroundColor(Color(0x00000000));
    window?.setSize(Size(state.overlayWidth, state.overlayHeight));
    window?.show();
    state = state.copyWith(window: window);
    return window;
  }

  void resizeOverlay() {
    final window = state.window;
    window?.setSize(Size(state.overlayWidth, state.overlayHeight));
    state = state.copyWith(window: window);
  }

  Future<void> updateOverlayKeyTile() async {
    final window = state.window;
    if(window == null) return;
    await WindowManagerPlus.current.invokeMethodToWindow(window.id, "updateKeyTile", jsonEncode(state.keyTileData.toList()));
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
    state = state.copyWith(keyTileData: data);
    updateOverlayKeyTile();
  }

  void addKeyTile(KeyTileDataModel model) {
    final data = {...state.keyTileData};
    state = state.copyWith(keyTileData: {...data, model});
    updateOverlayKeyTile();
  }

  void setEditorSize(Size size) => state = state.copyWith(overlayWidth: size.width, overlayHeight: size.height);
}