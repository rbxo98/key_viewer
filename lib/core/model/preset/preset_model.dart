import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:key_viewer_v2/core/model/key/key_tile_data_model.dart';
import 'package:key_viewer_v2/settings/data/preset/base/observer_group.dart';
import 'package:key_viewer_v2/settings/page/widget/grid_snap_editor.dart';
import 'package:uuid/v4.dart';
import 'package:win32/win32.dart';

part 'preset_model.freezed.dart';
part 'preset_model.g.dart';
@freezed
abstract class PresetModel with _$PresetModel {
  PresetModel._();
  factory PresetModel({
  required String presetName,
    required String primaryKey,
  @Default(VIRTUAL_KEY.VK_TAB)
  int switchKey,
  @Default([])
  List<KeyTileDataGroupModel> keyTileDataGroup,
  @Default(0)
  int currentGroupIdx,
  required DateTime createdAt,
    @Default(false)
    bool isObserver,
    @Default(false)
    bool isDeleted,
    @JsonKey(defaultValue: HistoryAxis.verticalUp, fromJson: HistoryAxis.fromJson, toJson: HistoryAxis.toJson)
    required HistoryAxis historyAxis,
  }) = _PresetModel;

  factory PresetModel.fromJson(Map<String, dynamic> json) => _$PresetModelFromJson(json);
  factory PresetModel.empty() => PresetModel(
      presetName: "새 프리셋",
    primaryKey: UuidV4().generate(),
    keyTileDataGroup: [KeyTileDataGroupModel.empty()],
    createdAt: DateTime.now(),
    isObserver: false,
    historyAxis: HistoryAxis.verticalUp
  );

  KeyTileDataGroupModel get getCurrentGroup => currentGroupIdx >= 0 ? keyTileDataGroup[currentGroupIdx] : observerGroup;
  List<KeyTileDataModel> get getCurrentKeyTileData =>  currentGroupIdx >= 0 ? keyTileDataGroup[currentGroupIdx].keyTileData : [];
}

@freezed
abstract class KeyTileDataGroupModel with _$KeyTileDataGroupModel {
  KeyTileDataGroupModel._();
  factory KeyTileDataGroupModel({
    required String primaryKey,
    required String name,
    @Default([])
    List<KeyTileDataModel> keyTileData,
    @Default(false)
  bool isDeleted,
  }) = _KeyTileDataGroupModel;

  factory KeyTileDataGroupModel.fromJson(Map<String, dynamic> json) => _$KeyTileDataGroupModelFromJson(json);
  factory KeyTileDataGroupModel.empty() => KeyTileDataGroupModel(
      primaryKey: UuidV4().generate(),
      name: "새 그룹",
  );
  factory KeyTileDataGroupModel.observer() => KeyTileDataGroupModel(
      primaryKey: UuidV4().generate(),
      name: "Observer",
  );
}