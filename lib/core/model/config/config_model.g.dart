// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GlobalConfigModel _$GlobalConfigModelFromJson(Map<String, dynamic> json) =>
    _GlobalConfigModel(
      windowWidth: (json['windowWidth'] as num).toDouble(),
      windowHeight: (json['windowHeight'] as num).toDouble(),
      windowX: (json['windowX'] as num).toDouble(),
      windowY: (json['windowY'] as num).toDouble(),
      overlayWith: (json['overlayWith'] as num).toDouble(),
      overlayHeight: (json['overlayHeight'] as num).toDouble(),
      overlayX: (json['overlayX'] as num).toDouble(),
      overlayY: (json['overlayY'] as num).toDouble(),
      keyTileData: (json['keyTileData'] as List<dynamic>?)
              ?.map((e) => KeyTileDataModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$GlobalConfigModelToJson(_GlobalConfigModel instance) =>
    <String, dynamic>{
      'windowWidth': instance.windowWidth,
      'windowHeight': instance.windowHeight,
      'windowX': instance.windowX,
      'windowY': instance.windowY,
      'overlayWith': instance.overlayWith,
      'overlayHeight': instance.overlayHeight,
      'overlayX': instance.overlayX,
      'overlayY': instance.overlayY,
      'keyTileData': instance.keyTileData,
    };
