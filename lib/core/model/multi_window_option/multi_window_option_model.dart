import 'package:freezed_annotation/freezed_annotation.dart';

part 'multi_window_option_model.freezed.dart';
part 'multi_window_option_model.g.dart';
@freezed
abstract class MultiWindowOptionModel with _$MultiWindowOptionModel {
  const factory MultiWindowOptionModel({
    required String windowName,
    double? windowWidth,
    double? windowHeight,
    double? windowX,
    double? windowY,
    bool? isFrameless,
    int? backgroundColor,
    double? cell,
    double? gap,
  }) = _MultiWindowOptionModel;

  factory MultiWindowOptionModel.fromJson(Map<String, dynamic> json) => _$MultiWindowOptionModelFromJson(json);
}