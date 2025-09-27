import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:key_viewer_v2/core/model/key/key_tile_data_model.dart';
import 'package:key_viewer_v2/core/model/multi_window_option/multi_window_option_model.dart';
import 'package:key_viewer_v2/overlay/page/model/key_viewer_model.dart';
import 'package:key_viewer_v2/settings/page/widget/grid_snap_editor.dart';
import 'package:window_manager_plus/window_manager_plus.dart';

final keyViewerOverlayViewModelProvider = StateNotifierProvider<KeyViewerOverlayViewModel, KeyViewerModel>((ref) => KeyViewerOverlayViewModel(KeyViewerModel.empty()));

class KeyViewerOverlayViewModel extends StateNotifier<KeyViewerModel> {
  KeyViewerOverlayViewModel(super.state);

  void updateOverlayKeyTile(dynamic arguments) {
    // Settings에서 받은 데이터를 그대로 표시만
    final decodeData = jsonDecode(arguments as String);
    final listData = decodeData as List<dynamic>;
    final keyTileData = listData[0] as List<dynamic>;
    final currentData = listData[1] as List<dynamic>;
    final historyAxis = HistoryAxis.fromJson(listData[2] as String);
    final keyData = keyTileData.map((e) => KeyTileDataModel.fromJson(e)).toSet();
    final currentKeys = currentData.map((e) => e as int).toSet();
    state = state.copyWith(
        keyTileData: keyData,
        pressedKeySet: currentKeys,
        historyAxis: historyAxis
    );
  }

  void updatePressedKeySet(Set<int> value) {
    state = state.copyWith(pressedKeySet: value);
  }
}