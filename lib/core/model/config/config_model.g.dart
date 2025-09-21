// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GlobalConfigModel _$GlobalConfigModelFromJson(Map<String, dynamic> json) =>
    _GlobalConfigModel(
      presetList: (json['presetList'] as List<dynamic>?)
              ?.map((e) => PresetModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      currentPresetName: json['currentPresetName'] as String?,
      windowWidth: (json['windowWidth'] as num?)?.toDouble() ?? 600,
      windowHeight: (json['windowHeight'] as num?)?.toDouble() ?? 600,
      windowX: (json['windowX'] as num?)?.toDouble() ?? 0,
      windowY: (json['windowY'] as num?)?.toDouble() ?? 0,
      overlayWith: (json['overlayWith'] as num?)?.toDouble() ?? 600,
      overlayHeight: (json['overlayHeight'] as num?)?.toDouble() ?? 600,
      overlayX: (json['overlayX'] as num?)?.toDouble() ?? 0,
      overlayY: (json['overlayY'] as num?)?.toDouble() ?? 0,
      isWindowSizeLock: json['isWindowSizeLock'] ?? 0,
      showDJMAXPreset: json['showDJMAXPreset'] as bool? ?? true,
      showCommon4KPreset: json['showCommon4KPreset'] as bool? ?? true,
      showCommon7KPreset: json['showCommon7KPreset'] as bool? ?? true,
      showMuseDashPreset: json['showMuseDashPreset'] as bool? ?? true,
      showSixtaGatePreset: json['showSixtaGatePreset'] as bool? ?? true,
    );

Map<String, dynamic> _$GlobalConfigModelToJson(_GlobalConfigModel instance) =>
    <String, dynamic>{
      'presetList': instance.presetList,
      'currentPresetName': instance.currentPresetName,
      'windowWidth': instance.windowWidth,
      'windowHeight': instance.windowHeight,
      'windowX': instance.windowX,
      'windowY': instance.windowY,
      'overlayWith': instance.overlayWith,
      'overlayHeight': instance.overlayHeight,
      'overlayX': instance.overlayX,
      'overlayY': instance.overlayY,
      'isWindowSizeLock': instance.isWindowSizeLock,
      'showDJMAXPreset': instance.showDJMAXPreset,
      'showCommon4KPreset': instance.showCommon4KPreset,
      'showCommon7KPreset': instance.showCommon7KPreset,
      'showMuseDashPreset': instance.showMuseDashPreset,
      'showSixtaGatePreset': instance.showSixtaGatePreset,
    };
