// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preset_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PresetModel _$PresetModelFromJson(Map<String, dynamic> json) => _PresetModel(
      windowWidth: (json['windowWidth'] as num).toDouble(),
      windowHeight: (json['windowHeight'] as num).toDouble(),
      keyTileData: (json['keyTileData'] as List<dynamic>?)
              ?.map((e) => KeyTileDataModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$PresetModelToJson(_PresetModel instance) =>
    <String, dynamic>{
      'windowWidth': instance.windowWidth,
      'windowHeight': instance.windowHeight,
      'keyTileData': instance.keyTileData,
    };
