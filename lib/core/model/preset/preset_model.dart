import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:key_viewer_v2/core/model/key/key_tile_data_model.dart';

part 'preset_model.freezed.dart';
part 'preset_model.g.dart';
@freezed
abstract class PresetModel with _$PresetModel {
  factory PresetModel({
    required double windowWidth,
    required double windowHeight,
    @Default([])
    List<KeyTileDataModel> keyTileData,
  }) = _PresetModel;

  factory PresetModel.fromJson(Map<String, dynamic> json) => _$PresetModelFromJson(json);

}