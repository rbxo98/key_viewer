// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SettingsModel {
  WindowManagerPlus? get window;
  GlobalConfigModel get globalConfig;
  double get overlayWidth;
  double get overlayHeight;
  List<PresetModel> get presetList;
  PresetModel get currentPreset;
  Set<int> get pressedKeySet;
  bool get windowSizeLock;
  bool get isOverlayLoading;
  double get cell;
  double get gap;

  /// Create a copy of SettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SettingsModelCopyWith<SettingsModel> get copyWith =>
      _$SettingsModelCopyWithImpl<SettingsModel>(
          this as SettingsModel, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SettingsModel &&
            (identical(other.window, window) || other.window == window) &&
            (identical(other.globalConfig, globalConfig) ||
                other.globalConfig == globalConfig) &&
            (identical(other.overlayWidth, overlayWidth) ||
                other.overlayWidth == overlayWidth) &&
            (identical(other.overlayHeight, overlayHeight) ||
                other.overlayHeight == overlayHeight) &&
            const DeepCollectionEquality()
                .equals(other.presetList, presetList) &&
            (identical(other.currentPreset, currentPreset) ||
                other.currentPreset == currentPreset) &&
            const DeepCollectionEquality()
                .equals(other.pressedKeySet, pressedKeySet) &&
            (identical(other.windowSizeLock, windowSizeLock) ||
                other.windowSizeLock == windowSizeLock) &&
            (identical(other.isOverlayLoading, isOverlayLoading) ||
                other.isOverlayLoading == isOverlayLoading) &&
            (identical(other.cell, cell) || other.cell == cell) &&
            (identical(other.gap, gap) || other.gap == gap));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      window,
      globalConfig,
      overlayWidth,
      overlayHeight,
      const DeepCollectionEquality().hash(presetList),
      currentPreset,
      const DeepCollectionEquality().hash(pressedKeySet),
      windowSizeLock,
      isOverlayLoading,
      cell,
      gap);

  @override
  String toString() {
    return 'SettingsModel(window: $window, globalConfig: $globalConfig, overlayWidth: $overlayWidth, overlayHeight: $overlayHeight, presetList: $presetList, currentPreset: $currentPreset, pressedKeySet: $pressedKeySet, windowSizeLock: $windowSizeLock, isOverlayLoading: $isOverlayLoading, cell: $cell, gap: $gap)';
  }
}

/// @nodoc
abstract mixin class $SettingsModelCopyWith<$Res> {
  factory $SettingsModelCopyWith(
          SettingsModel value, $Res Function(SettingsModel) _then) =
      _$SettingsModelCopyWithImpl;
  @useResult
  $Res call(
      {WindowManagerPlus? window,
      GlobalConfigModel globalConfig,
      double overlayWidth,
      double overlayHeight,
      List<PresetModel> presetList,
      PresetModel currentPreset,
      Set<int> pressedKeySet,
      bool windowSizeLock,
      bool isOverlayLoading,
      double cell,
      double gap});

  $GlobalConfigModelCopyWith<$Res> get globalConfig;
  $PresetModelCopyWith<$Res> get currentPreset;
}

/// @nodoc
class _$SettingsModelCopyWithImpl<$Res>
    implements $SettingsModelCopyWith<$Res> {
  _$SettingsModelCopyWithImpl(this._self, this._then);

  final SettingsModel _self;
  final $Res Function(SettingsModel) _then;

  /// Create a copy of SettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? window = freezed,
    Object? globalConfig = null,
    Object? overlayWidth = null,
    Object? overlayHeight = null,
    Object? presetList = null,
    Object? currentPreset = null,
    Object? pressedKeySet = null,
    Object? windowSizeLock = null,
    Object? isOverlayLoading = null,
    Object? cell = null,
    Object? gap = null,
  }) {
    return _then(_self.copyWith(
      window: freezed == window
          ? _self.window
          : window // ignore: cast_nullable_to_non_nullable
              as WindowManagerPlus?,
      globalConfig: null == globalConfig
          ? _self.globalConfig
          : globalConfig // ignore: cast_nullable_to_non_nullable
              as GlobalConfigModel,
      overlayWidth: null == overlayWidth
          ? _self.overlayWidth
          : overlayWidth // ignore: cast_nullable_to_non_nullable
              as double,
      overlayHeight: null == overlayHeight
          ? _self.overlayHeight
          : overlayHeight // ignore: cast_nullable_to_non_nullable
              as double,
      presetList: null == presetList
          ? _self.presetList
          : presetList // ignore: cast_nullable_to_non_nullable
              as List<PresetModel>,
      currentPreset: null == currentPreset
          ? _self.currentPreset
          : currentPreset // ignore: cast_nullable_to_non_nullable
              as PresetModel,
      pressedKeySet: null == pressedKeySet
          ? _self.pressedKeySet
          : pressedKeySet // ignore: cast_nullable_to_non_nullable
              as Set<int>,
      windowSizeLock: null == windowSizeLock
          ? _self.windowSizeLock
          : windowSizeLock // ignore: cast_nullable_to_non_nullable
              as bool,
      isOverlayLoading: null == isOverlayLoading
          ? _self.isOverlayLoading
          : isOverlayLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      cell: null == cell
          ? _self.cell
          : cell // ignore: cast_nullable_to_non_nullable
              as double,
      gap: null == gap
          ? _self.gap
          : gap // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }

  /// Create a copy of SettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GlobalConfigModelCopyWith<$Res> get globalConfig {
    return $GlobalConfigModelCopyWith<$Res>(_self.globalConfig, (value) {
      return _then(_self.copyWith(globalConfig: value));
    });
  }

  /// Create a copy of SettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PresetModelCopyWith<$Res> get currentPreset {
    return $PresetModelCopyWith<$Res>(_self.currentPreset, (value) {
      return _then(_self.copyWith(currentPreset: value));
    });
  }
}

/// @nodoc

class _SettingsModel extends SettingsModel {
  _SettingsModel(
      {this.window,
      required this.globalConfig,
      required this.overlayWidth,
      required this.overlayHeight,
      final List<PresetModel> presetList = const [],
      required this.currentPreset,
      final Set<int> pressedKeySet = const {},
      required this.windowSizeLock,
      required this.isOverlayLoading,
      required this.cell,
      required this.gap})
      : _presetList = presetList,
        _pressedKeySet = pressedKeySet,
        super._();

  @override
  final WindowManagerPlus? window;
  @override
  final GlobalConfigModel globalConfig;
  @override
  final double overlayWidth;
  @override
  final double overlayHeight;
  final List<PresetModel> _presetList;
  @override
  @JsonKey()
  List<PresetModel> get presetList {
    if (_presetList is EqualUnmodifiableListView) return _presetList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_presetList);
  }

  @override
  final PresetModel currentPreset;
  final Set<int> _pressedKeySet;
  @override
  @JsonKey()
  Set<int> get pressedKeySet {
    if (_pressedKeySet is EqualUnmodifiableSetView) return _pressedKeySet;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_pressedKeySet);
  }

  @override
  final bool windowSizeLock;
  @override
  final bool isOverlayLoading;
  @override
  final double cell;
  @override
  final double gap;

  /// Create a copy of SettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SettingsModelCopyWith<_SettingsModel> get copyWith =>
      __$SettingsModelCopyWithImpl<_SettingsModel>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SettingsModel &&
            (identical(other.window, window) || other.window == window) &&
            (identical(other.globalConfig, globalConfig) ||
                other.globalConfig == globalConfig) &&
            (identical(other.overlayWidth, overlayWidth) ||
                other.overlayWidth == overlayWidth) &&
            (identical(other.overlayHeight, overlayHeight) ||
                other.overlayHeight == overlayHeight) &&
            const DeepCollectionEquality()
                .equals(other._presetList, _presetList) &&
            (identical(other.currentPreset, currentPreset) ||
                other.currentPreset == currentPreset) &&
            const DeepCollectionEquality()
                .equals(other._pressedKeySet, _pressedKeySet) &&
            (identical(other.windowSizeLock, windowSizeLock) ||
                other.windowSizeLock == windowSizeLock) &&
            (identical(other.isOverlayLoading, isOverlayLoading) ||
                other.isOverlayLoading == isOverlayLoading) &&
            (identical(other.cell, cell) || other.cell == cell) &&
            (identical(other.gap, gap) || other.gap == gap));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      window,
      globalConfig,
      overlayWidth,
      overlayHeight,
      const DeepCollectionEquality().hash(_presetList),
      currentPreset,
      const DeepCollectionEquality().hash(_pressedKeySet),
      windowSizeLock,
      isOverlayLoading,
      cell,
      gap);

  @override
  String toString() {
    return 'SettingsModel(window: $window, globalConfig: $globalConfig, overlayWidth: $overlayWidth, overlayHeight: $overlayHeight, presetList: $presetList, currentPreset: $currentPreset, pressedKeySet: $pressedKeySet, windowSizeLock: $windowSizeLock, isOverlayLoading: $isOverlayLoading, cell: $cell, gap: $gap)';
  }
}

/// @nodoc
abstract mixin class _$SettingsModelCopyWith<$Res>
    implements $SettingsModelCopyWith<$Res> {
  factory _$SettingsModelCopyWith(
          _SettingsModel value, $Res Function(_SettingsModel) _then) =
      __$SettingsModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {WindowManagerPlus? window,
      GlobalConfigModel globalConfig,
      double overlayWidth,
      double overlayHeight,
      List<PresetModel> presetList,
      PresetModel currentPreset,
      Set<int> pressedKeySet,
      bool windowSizeLock,
      bool isOverlayLoading,
      double cell,
      double gap});

  @override
  $GlobalConfigModelCopyWith<$Res> get globalConfig;
  @override
  $PresetModelCopyWith<$Res> get currentPreset;
}

/// @nodoc
class __$SettingsModelCopyWithImpl<$Res>
    implements _$SettingsModelCopyWith<$Res> {
  __$SettingsModelCopyWithImpl(this._self, this._then);

  final _SettingsModel _self;
  final $Res Function(_SettingsModel) _then;

  /// Create a copy of SettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? window = freezed,
    Object? globalConfig = null,
    Object? overlayWidth = null,
    Object? overlayHeight = null,
    Object? presetList = null,
    Object? currentPreset = null,
    Object? pressedKeySet = null,
    Object? windowSizeLock = null,
    Object? isOverlayLoading = null,
    Object? cell = null,
    Object? gap = null,
  }) {
    return _then(_SettingsModel(
      window: freezed == window
          ? _self.window
          : window // ignore: cast_nullable_to_non_nullable
              as WindowManagerPlus?,
      globalConfig: null == globalConfig
          ? _self.globalConfig
          : globalConfig // ignore: cast_nullable_to_non_nullable
              as GlobalConfigModel,
      overlayWidth: null == overlayWidth
          ? _self.overlayWidth
          : overlayWidth // ignore: cast_nullable_to_non_nullable
              as double,
      overlayHeight: null == overlayHeight
          ? _self.overlayHeight
          : overlayHeight // ignore: cast_nullable_to_non_nullable
              as double,
      presetList: null == presetList
          ? _self._presetList
          : presetList // ignore: cast_nullable_to_non_nullable
              as List<PresetModel>,
      currentPreset: null == currentPreset
          ? _self.currentPreset
          : currentPreset // ignore: cast_nullable_to_non_nullable
              as PresetModel,
      pressedKeySet: null == pressedKeySet
          ? _self._pressedKeySet
          : pressedKeySet // ignore: cast_nullable_to_non_nullable
              as Set<int>,
      windowSizeLock: null == windowSizeLock
          ? _self.windowSizeLock
          : windowSizeLock // ignore: cast_nullable_to_non_nullable
              as bool,
      isOverlayLoading: null == isOverlayLoading
          ? _self.isOverlayLoading
          : isOverlayLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      cell: null == cell
          ? _self.cell
          : cell // ignore: cast_nullable_to_non_nullable
              as double,
      gap: null == gap
          ? _self.gap
          : gap // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }

  /// Create a copy of SettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GlobalConfigModelCopyWith<$Res> get globalConfig {
    return $GlobalConfigModelCopyWith<$Res>(_self.globalConfig, (value) {
      return _then(_self.copyWith(globalConfig: value));
    });
  }

  /// Create a copy of SettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PresetModelCopyWith<$Res> get currentPreset {
    return $PresetModelCopyWith<$Res>(_self.currentPreset, (value) {
      return _then(_self.copyWith(currentPreset: value));
    });
  }
}

// dart format on
