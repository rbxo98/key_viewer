// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'multi_window_option_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MultiWindowOptionModel _$MultiWindowOptionModelFromJson(
        Map<String, dynamic> json) =>
    _MultiWindowOptionModel(
      windowName: json['windowName'] as String,
      windowWidth: (json['windowWidth'] as num?)?.toDouble(),
      windowHeight: (json['windowHeight'] as num?)?.toDouble(),
      windowX: (json['windowX'] as num?)?.toDouble(),
      windowY: (json['windowY'] as num?)?.toDouble(),
      isFrameless: json['isFrameless'] as bool?,
      backgroundColor: (json['backgroundColor'] as num?)?.toInt(),
    );

Map<String, dynamic> _$MultiWindowOptionModelToJson(
        _MultiWindowOptionModel instance) =>
    <String, dynamic>{
      'windowName': instance.windowName,
      'windowWidth': instance.windowWidth,
      'windowHeight': instance.windowHeight,
      'windowX': instance.windowX,
      'windowY': instance.windowY,
      'isFrameless': instance.isFrameless,
      'backgroundColor': instance.backgroundColor,
    };
