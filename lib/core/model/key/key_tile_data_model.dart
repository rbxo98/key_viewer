
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/v4.dart';

part 'key_tile_data_model.freezed.dart';
part 'key_tile_data_model.g.dart';

@unfreezed
abstract class KeyTileDataModel with _$KeyTileDataModel {
  factory KeyTileDataModel({
    required final String primaryKey,
    required int key,
    required String label,
    required int keyCount,
    required int gx,
    required int gy,
    required int gw,
    required int gh,
    required KeyTileStyleModel style,
    required bool isDeleted,
  }) = _KeyTileDataModel;

  factory KeyTileDataModel.fromJson(Map<String, dynamic> json) => _$KeyTileDataModelFromJson(json);
  factory KeyTileDataModel.empty() => KeyTileDataModel(primaryKey: UuidV4().generate(), label: '', key: 0, keyCount: 0, gx: 0, gy: 0, gw: 10, gh: 10, style: KeyTileStyleModel.empty(), isDeleted: false);

}

@freezed
abstract class KeyTileStyleModel with _$KeyTileStyleModel {
  const factory KeyTileStyleModel({
    required double idleBorderRadius,
    required double idleBorderWidth,
    required int idleBorderColor,
    required int idleBackgroundColor,
    required double pressedBorderRadius,
    required double pressedBorderWidth,
    required int pressedBorderColor,
    required int pressedBackgroundColor,

    required double idleKeyFontSize,
    required int idleKeyFontWeight,
    required int idleKeyFontColor,
    required double pressedKeyFontSize,
    required int pressedKeyFontWeight,
    required int pressedKeyFontColor,

    required double idleCounterFontSize,
    required int idleCounterFontWeight,
    required int idleCounterFontColor,
    required double pressedCounterFontSize,
    required int pressedCounterFontWeight,
    required int pressedCounterFontColor,

  }) = _KeyTileStyleModel;

  factory KeyTileStyleModel.fromJson(Map<String, dynamic> json) =>
      _$KeyTileStyleModelFromJson(json);

  factory KeyTileStyleModel.empty() => KeyTileStyleModel(
    idleBorderRadius: 8,
    idleBorderWidth: 2,
    idleBorderColor: 0xFF757575,
    idleBackgroundColor: 0xFF2A2A2A,
    pressedBorderRadius: 8,
    pressedBorderWidth: 2,
    pressedBorderColor: 0xFF81D4FA,
    pressedBackgroundColor: 0xFF2196F3,

    idleKeyFontSize: 14,
    idleKeyFontWeight: 6,
    idleKeyFontColor: 0xFFEEEEEE,
    pressedKeyFontSize: 14,
    pressedKeyFontWeight: 6,
    pressedKeyFontColor: 0xFFFFFFFF,

    idleCounterFontSize: 14,
    idleCounterFontWeight: 6,
    idleCounterFontColor: 0xFFEEEEEE,
    pressedCounterFontSize: 14,
    pressedCounterFontWeight: 6,
    pressedCounterFontColor: 0xFFFFFFFF,
  );
}