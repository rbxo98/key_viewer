import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:key_viewer_v2/core/model/key/key_tile_data_model.dart';
import 'package:key_viewer_v2/settings/page/widget/grid_snap_editor.dart';

part 'key_viewer_model.freezed.dart';

@freezed
abstract class KeyViewerModel with _$KeyViewerModel {
  factory KeyViewerModel({
    @Default({})
    Set<KeyTileDataModel> keyTileData,
    @Default({})
    Set<int> pressedKeySet,
    required HistoryAxis historyAxis,
  }) = _KeyViewerModel;

  factory KeyViewerModel.empty() => KeyViewerModel(
    historyAxis: HistoryAxis.verticalUp
  );
}