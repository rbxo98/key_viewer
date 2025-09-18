import 'package:freezed_annotation/freezed_annotation.dart';

part 'config_model.freezed.dart';
part 'config_model.g.dart';
@unfreezed
abstract class GlobalConfigModel with _$GlobalConfigModel {
  factory GlobalConfigModel({
    required double windowWidth,
    required double windowHeight,
  }) = _GlobalConfigModel;

  factory GlobalConfigModel.fromJson(Map<String, dynamic> json) => _$GlobalConfigModelFromJson(json);
  factory GlobalConfigModel.empty() => GlobalConfigModel(windowWidth: 600, windowHeight: 600);
}