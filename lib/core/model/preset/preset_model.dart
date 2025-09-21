import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:key_viewer_v2/core/model/key/key_tile_data_model.dart';
import 'package:win32/win32.dart';

part 'preset_model.freezed.dart';
part 'preset_model.g.dart';
@freezed
abstract class PresetModel with _$PresetModel {
  PresetModel._();
  factory PresetModel({
    required String presetName,
    @Default(VIRTUAL_KEY.VK_TAB)
    int switchKey,
    @Default([])
    List<KeyTileDataGroupModel> keyTileDataGroup,
    @Default(0)
    int currentGroupIdx,
  }) = _PresetModel;

  factory PresetModel.fromJson(Map<String, dynamic> json) => _$PresetModelFromJson(json);
  factory PresetModel.empty() => PresetModel(
      presetName: "새 프리셋",
  );

  KeyTileDataGroupModel get getCurrentGroup => keyTileDataGroup[currentGroupIdx];
  List<KeyTileDataModel> get getCurrentKeyTileData => keyTileDataGroup[currentGroupIdx].keyTileData;
}

@freezed
abstract class KeyTileDataGroupModel with _$KeyTileDataGroupModel {
  KeyTileDataGroupModel._();
  factory KeyTileDataGroupModel({
    required String name,
    @Default([])
    List<KeyTileDataModel> keyTileData,
  }) = _KeyTileDataGroupModel;

  factory KeyTileDataGroupModel.fromJson(Map<String, dynamic> json) => _$KeyTileDataGroupModelFromJson(json);
  factory KeyTileDataGroupModel.empty() => KeyTileDataGroupModel(
      name: "",
  );
}