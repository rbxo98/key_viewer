import 'package:key_viewer_v2/core/model/key/key_tile_data_model.dart';
import 'package:key_viewer_v2/core/model/preset/preset_model.dart';

import 'settings_model.dart';

extension SettingsModelExtension on SettingsModel {
  /// 현재 프리셋을 업데이트하고 presetList와 globalConfig를 동기화하는 메소드
  SettingsModel updateCurrentPresetSync(PresetModel updatedPreset) {
    final updatedPresetList = [...presetList];
    final targetPresetIdx = getCurrentPresetIndex;

    if (targetPresetIdx >= 0 && targetPresetIdx < presetList.length) {
      updatedPresetList[targetPresetIdx] = updatedPreset;
    }

    return copyWith
        .globalConfig(presetList: updatedPresetList,
        currentPresetName: updatedPreset.presetName)
        .copyWith(presetList: updatedPresetList, currentPreset: updatedPreset);
  }

  /// 키 타일 데이터를 업데이트하고 모든 관련 상태를 동기화하는 메소드
  SettingsModel updateKeyTileDataSync(Set<KeyTileDataModel> keyTileData) {
    if(currentPreset.currentGroupIdx >= 0){
      final preset = currentPreset;
      final group = preset.getCurrentGroup.copyWith(
          keyTileData: keyTileData.toList());
      final newGroups = [...preset.keyTileDataGroup];
      newGroups[preset.currentGroupIdx] = group;

      final updatedPreset = preset.copyWith(keyTileDataGroup: newGroups);
      return updateCurrentPresetSync(updatedPreset);
    }
    return this;
  }

  /// 키 타일을 추가하고 모든 관련 상태를 동기화하는 메소드
  SettingsModel addKeyTileSync(KeyTileDataModel keyTile) {
    final preset = currentPreset;
    final currentKeyTiles = {...preset.getCurrentKeyTileData, keyTile};
    return updateKeyTileDataSync(currentKeyTiles);
  }


  /// 키 카운트를 업데이트하고 모든 관련 상태를 동기화하는 메소드
  SettingsModel updateKeyCountSync(Set<int> pressedKeys,
      Set<int> newlyPressed) {
    final preset = currentPreset;
    final updatedKeyTiles = preset.getCurrentGroup.keyTileData.map((tile) {
      if (newlyPressed.contains(tile.key)) {
        return tile.copyWith(keyCount: tile.keyCount + 1);
      }
      return tile;
    }).toSet();

    return updateKeyTileDataSync(updatedKeyTiles).copyWith(
        pressedKeySet: pressedKeys);
  }

  /// 키 타일 데이터 그룹을 추가하고 동기화하는 메소드
  SettingsModel addKeyTileDataGroupSync(KeyTileDataGroupModel group) {
    final updatedGroups = [...currentPreset.keyTileDataGroup, group];
    final updatedPreset = currentPreset.copyWith(
        keyTileDataGroup: updatedGroups);
    return updateCurrentPresetSync(updatedPreset);
  }

  SettingsModel removeKeyTileDataGroupSync(KeyTileDataGroupModel group) {
    final updatedGroups = [...currentPreset.keyTileDataGroup]..removeWhere((e) => e.name == group.name);
    final updatedPreset = currentPreset.copyWith(
        keyTileDataGroup: updatedGroups,
      currentGroupIdx: currentPreset.currentGroupIdx >= updatedGroups.length ? updatedGroups.length - 1 : currentPreset.currentGroupIdx
    );
    return updateCurrentPresetSync(updatedPreset);
  }


  /// 현재 키 타일 데이터 그룹을 변경하고 동기화하는 메소드
  SettingsModel setCurrentKeyTileDataGroupSync(int groupIndex) {
    if (groupIndex >= currentPreset.keyTileDataGroup.length) {
      return this; // 잘못된 인덱스인 경우 현재 상태 반환
    }

    final updatedPreset = currentPreset.copyWith(currentGroupIdx: groupIndex);
    return updateCurrentPresetSync(updatedPreset);
  }

  /// 프리셋을 추가하고 현재 프리셋으로 설정하는 메소드
  SettingsModel addPresetSync(PresetModel preset) {
    final updatedPresetList = [...presetList, preset];
    return copyWith
        .globalConfig(
        presetList: updatedPresetList, currentPresetName: preset.presetName)
        .copyWith(presetList: updatedPresetList, currentPreset: preset);
  }

  /// 프리셋을 설정하고 동기화하는 메소드
  SettingsModel setPresetSync(PresetModel preset) {
    return copyWith
        .globalConfig(currentPresetName: preset.presetName)
        .copyWith(currentPreset: preset);
  }

  SettingsModel updatePresetInfoSync(PresetModel preset) {
    final currentPresetIndex = getCurrentPresetIndex;
    final updatedPresetList = [...presetList];
    if (currentPresetIndex >= 0 && currentPresetIndex < presetList.length) {
      updatedPresetList[currentPresetIndex] = preset;
    }
    return copyWith
        .globalConfig(
        currentPresetName: preset.presetName,
      presetList: updatedPresetList
    )
        .copyWith(currentPreset: preset, presetList: updatedPresetList);
  }

  /// 현재 프리셋의 isObserver 값을 설정하고 동기화하는 메소드
  SettingsModel setCurrentPresetObserverSync(bool isObserver) {
    final updatedPreset = currentPreset.copyWith(isObserver: isObserver);
    return updateCurrentPresetSync(updatedPreset);
  }

}