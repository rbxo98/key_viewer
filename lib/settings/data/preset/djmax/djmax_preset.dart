import 'package:key_viewer_v2/core/model/key/key_tile_data_model.dart';
import 'package:key_viewer_v2/core/model/preset/preset_model.dart';
import 'package:win32/win32.dart';

final _baseGx = 0;
final _baseGy = 30;
PresetModel DJMAXPresetModel = PresetModel(
  createdAt: DateTime.now(),
    presetName: "DJMAX RESPECT V",
    keyTileDataGroup: [
      KeyTileDataGroupModel(
          name: "8B",
        keyTileData: djmaxPreset
      ),
    ], isObserver: false);
final List<KeyTileDataModel> djmaxPreset = [
  KeyTileDataModel(
      primaryKey: "DJMAX_PRESET_KEY_1",
      key: VIRTUAL_KEY.VK_A,
      label: "A",
      keyCount: 0,
      gx: _baseGx,
      gy: _baseGy,
      gw: 10,
      gh: 10,
      style: KeyTileStyleModel.empty(),
      isDeleted: false),

  KeyTileDataModel(
      primaryKey: "DJMAX_PRESET_KEY_2",
      key: VIRTUAL_KEY.VK_S,
      label: "S",
      keyCount: 0,
      gx: _baseGx+10,
      gy: _baseGy,
      gw: 10,
      gh: 10,
      style: KeyTileStyleModel.empty(),
      isDeleted: false),

  KeyTileDataModel(
      primaryKey: "DJMAX_PRESET_KEY_3",
      key: VIRTUAL_KEY.VK_D,
      label: "D",
      keyCount: 0,
      gx: _baseGx+20,
      gy: _baseGy,
      gw: 10,
      gh: 10,
      style: KeyTileStyleModel.empty(),
      isDeleted: false),

  KeyTileDataModel(
      primaryKey: "DJMAX_PRESET_KEY_4",
      key: VIRTUAL_KEY.VK_L,
      label: "L",
      keyCount: 0,
      gx: _baseGx+30,
      gy: _baseGy,
      gw: 10,
      gh: 10,
      style: KeyTileStyleModel.empty(),
      isDeleted: false),

  KeyTileDataModel(
      primaryKey: "DJMAX_PRESET_KEY_5",
      key: VIRTUAL_KEY.VK_OEM_1,
      label: ";",
      keyCount: 0,
      gx: _baseGx+40,
      gy: _baseGy,
      gw: 10,
      gh: 10,
      style: KeyTileStyleModel.empty(),
      isDeleted: false),

  KeyTileDataModel(
      primaryKey: "DJMAX_PRESET_KEY_6",
      key: VIRTUAL_KEY.VK_OEM_7,
      label: "A",
      keyCount: 0,
      gx: _baseGx+50,
      gy: _baseGy,
      gw: 10,
      gh: 10,
      style: KeyTileStyleModel.empty(),
      isDeleted: false),

  KeyTileDataModel(
      primaryKey: "DJMAX_PRESET_KEY_7",
      key: VIRTUAL_KEY.VK_SPACE,
      label: "SPACE",
      keyCount: 0,
      gx: _baseGx,
      gy: _baseGy+10,
      gw: 30,
      gh: 10,
      style: KeyTileStyleModel.empty(),
      isDeleted: false),

  KeyTileDataModel(
      primaryKey: "DJMAX_PRESET_KEY_8",
      key: VIRTUAL_KEY.VK_HANGEUL,
      label: "ALT",
      keyCount: 0,
      gx: _baseGx+30,
      gy: _baseGy+10,
      gw: 30,
      gh: 10,
      style: KeyTileStyleModel.empty(),
      isDeleted: false),

  KeyTileDataModel(
      primaryKey: "DJMAX_PRESET_KEY_9",
      key: VIRTUAL_KEY.VK_LSHIFT,
      label: "LSHIFT",
      keyCount: 0,
      gx: _baseGx,
      gy: _baseGy+20,
      gw: 30,
      gh: 10,
      style: KeyTileStyleModel.empty(),
      isDeleted: false),

  KeyTileDataModel(
      primaryKey: "DJMAX_PRESET_KEY_10",
      key: VIRTUAL_KEY.VK_RSHIFT,
      label: "RSHIFT",
      keyCount: 0,
      gx: _baseGx+30,
      gy: _baseGy+20,
      gw: 30,
      gh: 10,
      style: KeyTileStyleModel.empty(),
      isDeleted: false),
];