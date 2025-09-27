import 'package:flutter/material.dart';
import 'package:key_viewer_v2/core/model/key/key_tile_data_model.dart';
import 'package:key_viewer_v2/core/model/preset/preset_model.dart';
import 'package:key_viewer_v2/settings/page/widget/grid_snap_editor.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/v4.dart';
import 'package:win32/win32.dart';

final _baseGx = 25;
final _baseGy = 0;
final PresetModel EZ2ONPresetModel = PresetModel(
    createdAt: DateTime(2025,1,1),
    presetName: "EZ2ON REBOOT : R",
    keyTileDataGroup: [
      KeyTileDataGroupModel(
        primaryKey: "EZ2ON_PRESET_GROUP",
        name: "4K",
        keyTileData: [

          KeyTileDataModel(
              primaryKey: "EZ2ON_PRESET_KEY_1",
              key: VIRTUAL_KEY.VK_D,
              label: "D",
              keyCount: 0,
              gx: _baseGx,
              gy: _baseGy,
              gw: 10,
              gh: 10,
              style: KeyTileStyleModel.empty().copyWith(
                  historyBarColor: Colors.yellow.value
              ),
              isDeleted: false),

          KeyTileDataModel(
              primaryKey: "EZ2ON_PRESET_KEY_2",
              key: VIRTUAL_KEY.VK_F,
              label: "F",
              keyCount: 0,
              gx: _baseGx+10,
              gy: _baseGy,
              gw: 10,
              gh: 10,
              style: KeyTileStyleModel.empty().copyWith(
                  historyBarColor: Colors.blue.value
              ),
              isDeleted: false),

          KeyTileDataModel(
              primaryKey: "EZ2ON_PRESET_KEY_3",
              key: VIRTUAL_KEY.VK_J,
              label: "J",
              keyCount: 0,
              gx: _baseGx+20,
              gy: _baseGy,
              gw: 10,
              gh: 10,
              style: KeyTileStyleModel.empty().copyWith(
                  historyBarColor: Colors.blue.value
              ),
              isDeleted: false),

          KeyTileDataModel(
              primaryKey: "EZ2ON_PRESET_KEY_4",
              key: VIRTUAL_KEY.VK_K,
              label: "K",
              keyCount: 0,
              gx: _baseGx+30,
              gy: _baseGy,
              gw: 10,
              gh: 10,
              style: KeyTileStyleModel.empty().copyWith(
                  historyBarColor: Colors.yellow.value
              ),
              isDeleted: false),
        ],
      ),
      KeyTileDataGroupModel(
        primaryKey: "EZ2ON_PRESET_GROUP",
        name: "5K",
        keyTileData: [
          KeyTileDataModel(
              primaryKey: "EZ2ON_PRESET_KEY_1",
              key: VIRTUAL_KEY.VK_D,
              label: "D",
              keyCount: 0,
              gx: _baseGx,
              gy: _baseGy,
              gw: 10,
              gh: 10,
              style: KeyTileStyleModel.empty().copyWith(
                  historyBarColor: Colors.yellow.value
              ),
              isDeleted: false),

          KeyTileDataModel(
              primaryKey: "EZ2ON_PRESET_KEY_2",
              key: VIRTUAL_KEY.VK_F,
              label: "F",
              keyCount: 0,
              gx: _baseGx+10,
              gy: _baseGy,
              gw: 10,
              gh: 10,
              style: KeyTileStyleModel.empty().copyWith(
                  historyBarColor: Colors.blue.value
              ),
              isDeleted: false),

          KeyTileDataModel(
              primaryKey: "EZ2ON_PRESET_KEY_3",
              key: VIRTUAL_KEY.VK_SPACE,
              label: "SPACE",
              keyCount: 0,
              gx: _baseGx+20,
              gy: _baseGy,
              gw: 20,
              gh: 10,
              style: KeyTileStyleModel.empty().copyWith(
                  historyBarColor: Colors.redAccent.value
              ),
              isDeleted: false),

          KeyTileDataModel(
              primaryKey: "EZ2ON_PRESET_KEY_4",
              key: VIRTUAL_KEY.VK_J,
              label: "J",
              keyCount: 0,
              gx: _baseGx+40,
              gy: _baseGy,
              gw: 10,
              gh: 10,
              style: KeyTileStyleModel.empty().copyWith(
                  historyBarColor: Colors.blue.value
              ),
              isDeleted: false),

          KeyTileDataModel(
              primaryKey: "EZ2ON_PRESET_KEY_5",
              key: VIRTUAL_KEY.VK_K,
              label: "K",
              keyCount: 0,
              gx: _baseGx+50,
              gy: _baseGy,
              gw: 10,
              gh: 10,
              style: KeyTileStyleModel.empty().copyWith(
                  historyBarColor: Colors.yellow.value
              ),
              isDeleted: false),
        ],
      ),
      KeyTileDataGroupModel(
        primaryKey: "EZ2ON_PRESET_GROUP",
        name: "6K",
        keyTileData: [
          KeyTileDataModel(
              primaryKey: "EZ2ON_PRESET_KEY_1",
              key: VIRTUAL_KEY.VK_S,
              label: "S",
              keyCount: 0,
              gx: _baseGx,
              gy: _baseGy,
              gw: 10,
              gh: 10,
              style: KeyTileStyleModel.empty().copyWith(
                  historyBarColor: Colors.yellow.value
              ),
              isDeleted: false),

          KeyTileDataModel(
              primaryKey: "EZ2ON_PRESET_KEY_2",
              key: VIRTUAL_KEY.VK_D,
              label: "D",
              keyCount: 0,
              gx: _baseGx+10,
              gy: _baseGy,
              gw: 10,
              gh: 10,
              style: KeyTileStyleModel.empty().copyWith(
                  historyBarColor: Colors.blue.value
              ),
              isDeleted: false),

          KeyTileDataModel(
              primaryKey: "EZ2ON_PRESET_KEY_3",
              key: VIRTUAL_KEY.VK_F,
              label: "F",
              keyCount: 0,
              gx: _baseGx+20,
              gy: _baseGy,
              gw: 10,
              gh: 10,
              style: KeyTileStyleModel.empty().copyWith(
                  historyBarColor: Colors.yellow.value
              ),
              isDeleted: false),

          KeyTileDataModel(
              primaryKey: "EZ2ON_PRESET_KEY_4",
              key: VIRTUAL_KEY.VK_J,
              label: "J",
              keyCount: 0,
              gx: _baseGx+30,
              gy: _baseGy,
              gw: 10,
              gh: 10,
              style: KeyTileStyleModel.empty().copyWith(
                  historyBarColor: Colors.yellow.value
              ),
              isDeleted: false),

          KeyTileDataModel(
              primaryKey: "EZ2ON_PRESET_KEY_5",
              key: VIRTUAL_KEY.VK_K,
              label: "K",
              keyCount: 0,
              gx: _baseGx+40,
              gy: _baseGy,
              gw: 10,
              gh: 10,
              style: KeyTileStyleModel.empty().copyWith(
                  historyBarColor: Colors.blue.value
              ),
              isDeleted: false),

          KeyTileDataModel(
              primaryKey: "EZ2ON_PRESET_KEY_6",
              key: VIRTUAL_KEY.VK_L,
              label: "L",
              keyCount: 0,
              gx: _baseGx+50,
              gy: _baseGy,
              gw: 10,
              gh: 10,
              style: KeyTileStyleModel.empty().copyWith(
                  historyBarColor: Colors.yellow.value
              ),
              isDeleted: false),
        ],
      ),
      KeyTileDataGroupModel(
        primaryKey: "EZ2ON_PRESET_GROUP",
        name: "8K",
        keyTileData: [
          KeyTileDataModel(
              primaryKey: "EZ2ON_PRESET_KEY_1",
              key: VIRTUAL_KEY.VK_A,
              label: "A",
              keyCount: 0,
              gx: _baseGx,
              gy: _baseGy,
              gw: 10,
              gh: 10,
              style: KeyTileStyleModel.empty().copyWith(
                  historyBarColor: Colors.redAccent.value
              ),
              isDeleted: false),

          KeyTileDataModel(
              primaryKey: "EZ2ON_PRESET_KEY_2",
              key: VIRTUAL_KEY.VK_S,
              label: "S",
              keyCount: 0,
              gx: _baseGx+10,
              gy: _baseGy,
              gw: 10,
              gh: 10,
              style: KeyTileStyleModel.empty().copyWith(
                  historyBarColor: Colors.yellow.value
              ),
              isDeleted: false),

          KeyTileDataModel(
              primaryKey: "EZ2ON_PRESET_KEY_3",
              key: VIRTUAL_KEY.VK_D,
              label: "D",
              keyCount: 0,
              gx: _baseGx+20,
              gy: _baseGy,
              gw: 10,
              gh: 10,
              style: KeyTileStyleModel.empty().copyWith(
                  historyBarColor: Colors.blue.value
              ),
              isDeleted: false),

          KeyTileDataModel(
              primaryKey: "EZ2ON_PRESET_KEY_4",
              key: VIRTUAL_KEY.VK_F,
              label: "F",
              keyCount: 0,
              gx: _baseGx+30,
              gy: _baseGy,
              gw: 10,
              gh: 10,
              style: KeyTileStyleModel.empty().copyWith(
                  historyBarColor: Colors.yellow.value
              ),
              isDeleted: false),

          KeyTileDataModel(
              primaryKey: "EZ2ON_PRESET_KEY_5",
              key: VIRTUAL_KEY.VK_J,
              label: "J",
              keyCount: 0,
              gx: _baseGx+40,
              gy: _baseGy,
              gw: 10,
              gh: 10,
              style: KeyTileStyleModel.empty().copyWith(
                  historyBarColor: Colors.yellow.value
              ),
              isDeleted: false),

          KeyTileDataModel(
              primaryKey: "EZ2ON_PRESET_KEY_6",
              key: VIRTUAL_KEY.VK_K,
              label: "K",
              keyCount: 0,
              gx: _baseGx+50,
              gy: _baseGy,
              gw: 10,
              gh: 10,
              style: KeyTileStyleModel.empty().copyWith(
                  historyBarColor: Colors.blue.value
              ),
              isDeleted: false),

          KeyTileDataModel(
              primaryKey: "EZ2ON_PRESET_KEY_7",
              key: VIRTUAL_KEY.VK_L,
              label: "L",
              keyCount: 0,
              gx: _baseGx+60,
              gy: _baseGy,
              gw: 10,
              gh: 10,
              style: KeyTileStyleModel.empty().copyWith(
                  historyBarColor: Colors.yellow.value,
                  historyBarZIndex: 0
              ),
              isDeleted: false),

          KeyTileDataModel(
              primaryKey: "EZ2ON_PRESET_KEY_8",
              key: VIRTUAL_KEY.VK_OEM_1,
              label: ";",
              keyCount: 0,
              gx: _baseGx+70,
              gy: _baseGy,
              gw: 10,
              gh: 10,
              style: KeyTileStyleModel.empty().copyWith(
                  historyBarColor: Colors.redAccent.value,
                  historyBarZIndex: 0
              ),
              isDeleted: false),
        ],
      ),
    ],
    isObserver: false,
    primaryKey: UuidV4().generate(),
    historyAxis: HistoryAxis.verticalUp
);