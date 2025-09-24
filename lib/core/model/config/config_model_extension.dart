import 'package:key_viewer_v2/core/model/config/config_model.dart';
import 'package:key_viewer_v2/core/model/preset/preset_model.dart';

extension GlobalConfigModelExtension on GlobalConfigModel {
  /// 프리셋 리스트에서 특정 프리셋을 업데이트하는 메소드
  GlobalConfigModel updatePresetInList(PresetModel updatedPreset) {
    final updatedList = [...presetList];
    final targetIndex = presetList.indexWhere((p) => p.presetName == updatedPreset.presetName);

    if (targetIndex >= 0) {
      updatedList[targetIndex] = updatedPreset;
      return copyWith(presetList: updatedList);
    }

    return this; // 프리셋을 찾지 못한 경우 현재 상태 반환
  }

  /// 프리셋을 추가하고 현재 프리셋으로 설정하는 메소드
  GlobalConfigModel addPresetAndSetCurrent(PresetModel preset) {
    final updatedList = [...presetList, preset];
    return copyWith(presetList: updatedList, currentPresetName: preset.presetName);
  }

  /// 현재 프리셋 이름을 설정하는 메소드
  GlobalConfigModel setCurrentPreset(String presetName) {
    return copyWith(currentPresetName: presetName);
  }

  /// 윈도우 설정을 업데이트하는 메소드
  GlobalConfigModel updateWindowSettings({
    double? windowWidth,
    double? windowHeight,
    double? windowX,
    double? windowY,
    bool? isWindowSizeLock,
  }) {
    return copyWith(
      windowWidth: windowWidth ?? this.windowWidth,
      windowHeight: windowHeight ?? this.windowHeight,
      windowX: windowX ?? this.windowX,
      windowY: windowY ?? this.windowY,
      isWindowSizeLock: isWindowSizeLock ?? this.isWindowSizeLock,
    );
  }

  /// 오버레이 설정을 업데이트하는 메소드
  GlobalConfigModel updateOverlaySettings({
    double? overlayWidth,
    double? overlayHeight,
    double? overlayX,
    double? overlayY,
  }) {
    return copyWith(
      overlayWith: overlayWidth ?? this.overlayWith,
      overlayHeight: overlayHeight ?? this.overlayHeight,
      overlayX: overlayX ?? this.overlayX,
      overlayY: overlayY ?? this.overlayY,
    );
  }

  /// 특정 프리셋의 isObserver 값을 설정하는 메소드
  GlobalConfigModel setPresetObserver(String presetName, bool isObserver) {
    final updatedList = presetList.map((preset) {
      if (preset.presetName == presetName) {
        return preset.copyWith(isObserver: isObserver);
      }
      return preset;
    }).toList();

    return copyWith(presetList: updatedList);
  }
}