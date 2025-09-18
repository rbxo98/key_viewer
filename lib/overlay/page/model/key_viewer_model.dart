import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:key_viewer_v2/core/model/key/key_tile_data_model.dart';

part 'key_viewer_model.freezed.dart';

@freezed
abstract class KeyViewerModel with _$KeyViewerModel {
  factory KeyViewerModel({
    @Default({})
    Set<KeyTileDataModel> keyTileData,
    @Default({})
    Set<int> pressedKeySet,
  }) = _KeyViewerModel;

  factory KeyViewerModel.empty() => KeyViewerModel();
}