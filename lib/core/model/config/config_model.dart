import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:key_viewer_v2/core/model/key/key_tile_data_model.dart';
import 'package:key_viewer_v2/core/model/preset/preset_model.dart';

part 'config_model.freezed.dart';
part 'config_model.g.dart';
@unfreezed
abstract class GlobalConfigModel with _$GlobalConfigModel {
  factory GlobalConfigModel({
    @Default([])
    List<PresetModel> presetList,
    String? currentPresetName,
    @Default(600)
    double windowWidth,
    @Default(600)
    double windowHeight,
    @Default(0)
    double windowX,
    @Default(0)
    double windowY,
    @Default(600)
    double overlayWith,
    @Default(600)
    double overlayHeight,
    @Default(0)
    double overlayX,
    @Default(0)
    double overlayY,
    @Default(0)
    isWindowSizeLock,
    @Default(true)
    bool showDJMAXPreset,
    @Default(true)
    bool showCommon4KPreset,
    @Default(true)
    bool showCommon7KPreset,
    @Default(true)
    bool showMuseDashPreset,
    @Default(true)
    bool showSixtaGatePreset,
  }) = _GlobalConfigModel;

  factory GlobalConfigModel.fromJson(Map<String, dynamic> json) => _$GlobalConfigModelFromJson(json);
  factory GlobalConfigModel.empty() => GlobalConfigModel();
}