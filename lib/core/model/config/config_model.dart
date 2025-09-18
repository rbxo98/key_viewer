import 'package:freezed_annotation/freezed_annotation.dart';

part 'config_model.freezed.dart';
part 'config_model.g.dart';
@unfreezed
abstract class GlobalConfigModel with _$GlobalConfigModel {
  factory GlobalConfigModel({
    required double windowWidth,
    required double windowHeight,
    required double windowX,
    required double windowY
  }) = _GlobalConfigModel;

  factory GlobalConfigModel.fromJson(Map<String, dynamic> json) => _$GlobalConfigModelFromJson(json);
  factory GlobalConfigModel.empty() => GlobalConfigModel(windowWidth: 600, windowHeight: 600, windowX: 0, windowY: 0);
}