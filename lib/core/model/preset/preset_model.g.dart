// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preset_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PresetModel _$PresetModelFromJson(Map<String, dynamic> json) => _PresetModel(
      presetName: json['presetName'] as String,
      switchKey: (json['switchKey'] as num?)?.toInt() ?? VIRTUAL_KEY.VK_TAB,
      keyTileDataGroup: (json['keyTileDataGroup'] as List<dynamic>?)
              ?.map((e) =>
                  KeyTileDataGroupModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      currentGroupIdx: (json['currentGroupIdx'] as num?)?.toInt() ?? 0,
      createdAt: DateTime.parse(json['createdAt'] as String),
      isObserver: json['isObserver'] as bool? ?? false,
    );

Map<String, dynamic> _$PresetModelToJson(_PresetModel instance) =>
    <String, dynamic>{
      'presetName': instance.presetName,
      'switchKey': instance.switchKey,
      'keyTileDataGroup': instance.keyTileDataGroup,
      'currentGroupIdx': instance.currentGroupIdx,
      'createdAt': instance.createdAt.toIso8601String(),
      'isObserver': instance.isObserver,
    };

_KeyTileDataGroupModel _$KeyTileDataGroupModelFromJson(
        Map<String, dynamic> json) =>
    _KeyTileDataGroupModel(
      name: json['name'] as String,
      keyTileData: (json['keyTileData'] as List<dynamic>?)
              ?.map((e) => KeyTileDataModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$KeyTileDataGroupModelToJson(
        _KeyTileDataGroupModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'keyTileData': instance.keyTileData,
    };
