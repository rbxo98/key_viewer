import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:key_viewer_v2/settings/page/widget/grid_snap_editor.dart';

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
    @JsonKey(defaultValue: HistoryAxis.verticalUp, fromJson: HistoryAxis.fromJson, toJson: HistoryAxis.toJson)
    required HistoryAxis historyAxis,
  }) = _MultiWindowOptionModel;

  factory MultiWindowOptionModel.fromJson(Map<String, dynamic> json) => _$MultiWindowOptionModelFromJson(json);
}