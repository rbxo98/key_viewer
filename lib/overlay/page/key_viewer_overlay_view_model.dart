import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:key_viewer_v2/core/model/key/key_tile_data_model.dart';
import 'package:key_viewer_v2/overlay/page/model/key_viewer_model.dart';
import 'package:window_manager_plus/window_manager_plus.dart';

final keyViewerOverlayViewModelProvider = StateNotifierProvider<KeyViewerOverlayViewModel, KeyViewerModel>((ref) => KeyViewerOverlayViewModel(KeyViewerModel()));

class KeyViewerOverlayViewModel extends StateNotifier<KeyViewerModel> {
  KeyViewerOverlayViewModel(super.state);

  void setupWindowByGrid() {
    WindowManagerPlus.current.setAsFrameless();
  }

  void updatePressedKeySet(Set<int> value) {
    state = state.copyWith(pressedKeySet: value);
  }

  void updateOverlayKeyTile(dynamic arguments) {
    final decodeData = jsonDecode(arguments as String);
    final listData = decodeData as List<dynamic>;
    final snapshot = listData.map((e) => KeyTileDataModel.fromJson(e as Map<String, dynamic>)).toSet();
    state = state.copyWith(keyTileData: {...snapshot});
  }
}