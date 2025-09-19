import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:key_viewer_v2/core/model/key/key_tile_data_model.dart';

part 'config_model.freezed.dart';
part 'config_model.g.dart';
@unfreezed
abstract class GlobalConfigModel with _$GlobalConfigModel {
  factory GlobalConfigModel({
    required double windowWidth,
    required double windowHeight,
    required double windowX,
    required double windowY,
    required double overlayX,
    required double overlayY,
    @Default([])
    List<KeyTileDataModel> keyTileData,
  }) = _GlobalConfigModel;

  factory GlobalConfigModel.fromJson(Map<String, dynamic> json) => _$GlobalConfigModelFromJson(json);
  factory GlobalConfigModel.empty() => GlobalConfigModel(
      windowWidth: 600,
      windowHeight: 600,
      windowX: 0,
      windowY: 0,
      overlayX: 0,
      overlayY: 0
  );
}