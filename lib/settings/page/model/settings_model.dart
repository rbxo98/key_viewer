import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:key_viewer_v2/core/model/config/config_model.dart';
import 'package:key_viewer_v2/core/model/key/key_tile_data_model.dart';
import 'package:window_manager_plus/window_manager_plus.dart';

part 'settings_model.freezed.dart';

@freezed
abstract class SettingsModel with _$SettingsModel {
  const factory SettingsModel({
    WindowManagerPlus? window,
    required GlobalConfigModel globalConfig,
    required double overlayWidth,
    required double overlayHeight,
    @Default({})
    Set<KeyTileDataModel> keyTileData,
    required bool windowSizeLock,
    required bool isOverlayLoading,
  }) = _SettingsModel;

  factory SettingsModel.empty() => SettingsModel(
      window: null,
      overlayWidth: 0,
      overlayHeight: 0,
      keyTileData: {},
      globalConfig: GlobalConfigModel.empty(),
    windowSizeLock: false,
    isOverlayLoading: false,
  );
}