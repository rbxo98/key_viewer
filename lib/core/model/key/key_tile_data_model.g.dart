// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'key_tile_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_KeyTileDataModel _$KeyTileDataModelFromJson(Map<String, dynamic> json) =>
    _KeyTileDataModel(
      primaryKey: json['primaryKey'] as String,
      key: (json['key'] as num).toInt(),
      label: json['label'] as String,
      keyCount: (json['keyCount'] as num).toInt(),
      gx: (json['gx'] as num).toInt(),
      gy: (json['gy'] as num).toInt(),
      gw: (json['gw'] as num).toInt(),
      gh: (json['gh'] as num).toInt(),
      style: KeyTileStyleModel.fromJson(json['style'] as Map<String, dynamic>),
      isDeleted: json['isDeleted'] as bool,
    );

Map<String, dynamic> _$KeyTileDataModelToJson(_KeyTileDataModel instance) =>
    <String, dynamic>{
      'primaryKey': instance.primaryKey,
      'key': instance.key,
      'label': instance.label,
      'keyCount': instance.keyCount,
      'gx': instance.gx,
      'gy': instance.gy,
      'gw': instance.gw,
      'gh': instance.gh,
      'style': instance.style,
      'isDeleted': instance.isDeleted,
    };

_KeyTileStyleModel _$KeyTileStyleModelFromJson(Map<String, dynamic> json) =>
    _KeyTileStyleModel(
      idleBorderRadius: (json['idleBorderRadius'] as num).toDouble(),
      idleBorderWidth: (json['idleBorderWidth'] as num).toDouble(),
      idleBorderColor: (json['idleBorderColor'] as num).toInt(),
      idleBackgroundColor: (json['idleBackgroundColor'] as num).toInt(),
      pressedBorderRadius: (json['pressedBorderRadius'] as num).toDouble(),
      pressedBorderWidth: (json['pressedBorderWidth'] as num).toDouble(),
      pressedBorderColor: (json['pressedBorderColor'] as num).toInt(),
      pressedBackgroundColor: (json['pressedBackgroundColor'] as num).toInt(),
      idleKeyFontSize: (json['idleKeyFontSize'] as num).toDouble(),
      idleKeyFontWeight: (json['idleKeyFontWeight'] as num).toInt(),
      idleKeyFontColor: (json['idleKeyFontColor'] as num).toInt(),
      pressedKeyFontSize: (json['pressedKeyFontSize'] as num).toDouble(),
      pressedKeyFontWeight: (json['pressedKeyFontWeight'] as num).toInt(),
      pressedKeyFontColor: (json['pressedKeyFontColor'] as num).toInt(),
      idleCounterFontSize: (json['idleCounterFontSize'] as num).toDouble(),
      idleCounterFontWeight: (json['idleCounterFontWeight'] as num).toInt(),
      idleCounterFontColor: (json['idleCounterFontColor'] as num).toInt(),
      pressedCounterFontSize:
          (json['pressedCounterFontSize'] as num).toDouble(),
      pressedCounterFontWeight:
          (json['pressedCounterFontWeight'] as num).toInt(),
      pressedCounterFontColor: (json['pressedCounterFontColor'] as num).toInt(),
      historyBarColor: (json['historyBarColor'] as num).toInt(),
      historyBarZIndex: (json['historyBarZIndex'] as num).toInt(),
    );

Map<String, dynamic> _$KeyTileStyleModelToJson(_KeyTileStyleModel instance) =>
    <String, dynamic>{
      'idleBorderRadius': instance.idleBorderRadius,
      'idleBorderWidth': instance.idleBorderWidth,
      'idleBorderColor': instance.idleBorderColor,
      'idleBackgroundColor': instance.idleBackgroundColor,
      'pressedBorderRadius': instance.pressedBorderRadius,
      'pressedBorderWidth': instance.pressedBorderWidth,
      'pressedBorderColor': instance.pressedBorderColor,
      'pressedBackgroundColor': instance.pressedBackgroundColor,
      'idleKeyFontSize': instance.idleKeyFontSize,
      'idleKeyFontWeight': instance.idleKeyFontWeight,
      'idleKeyFontColor': instance.idleKeyFontColor,
      'pressedKeyFontSize': instance.pressedKeyFontSize,
      'pressedKeyFontWeight': instance.pressedKeyFontWeight,
      'pressedKeyFontColor': instance.pressedKeyFontColor,
      'idleCounterFontSize': instance.idleCounterFontSize,
      'idleCounterFontWeight': instance.idleCounterFontWeight,
      'idleCounterFontColor': instance.idleCounterFontColor,
      'pressedCounterFontSize': instance.pressedCounterFontSize,
      'pressedCounterFontWeight': instance.pressedCounterFontWeight,
      'pressedCounterFontColor': instance.pressedCounterFontColor,
      'historyBarColor': instance.historyBarColor,
      'historyBarZIndex': instance.historyBarZIndex,
    };
