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
  Set<KeyTileDataModel> get keyTileData;
  bool get windowSizeLock;

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
                .equals(other.keyTileData, keyTileData) &&
            (identical(other.windowSizeLock, windowSizeLock) ||
                other.windowSizeLock == windowSizeLock));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      window,
      globalConfig,
      overlayWidth,
      overlayHeight,
      const DeepCollectionEquality().hash(keyTileData),
      windowSizeLock);

  @override
  String toString() {
    return 'SettingsModel(window: $window, globalConfig: $globalConfig, overlayWidth: $overlayWidth, overlayHeight: $overlayHeight, keyTileData: $keyTileData, windowSizeLock: $windowSizeLock)';
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
      Set<KeyTileDataModel> keyTileData,
      bool windowSizeLock});

  $GlobalConfigModelCopyWith<$Res> get globalConfig;
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
    Object? keyTileData = null,
    Object? windowSizeLock = null,
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
      keyTileData: null == keyTileData
          ? _self.keyTileData
          : keyTileData // ignore: cast_nullable_to_non_nullable
              as Set<KeyTileDataModel>,
      windowSizeLock: null == windowSizeLock
          ? _self.windowSizeLock
          : windowSizeLock // ignore: cast_nullable_to_non_nullable
              as bool,
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
}

/// @nodoc

class _SettingsModel implements SettingsModel {
  const _SettingsModel(
      {this.window,
      required this.globalConfig,
      required this.overlayWidth,
      required this.overlayHeight,
      final Set<KeyTileDataModel> keyTileData = const {},
      required this.windowSizeLock})
      : _keyTileData = keyTileData;

  @override
  final WindowManagerPlus? window;
  @override
  final GlobalConfigModel globalConfig;
  @override
  final double overlayWidth;
  @override
  final double overlayHeight;
  final Set<KeyTileDataModel> _keyTileData;
  @override
  @JsonKey()
  Set<KeyTileDataModel> get keyTileData {
    if (_keyTileData is EqualUnmodifiableSetView) return _keyTileData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_keyTileData);
  }

  @override
  final bool windowSizeLock;

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
                .equals(other._keyTileData, _keyTileData) &&
            (identical(other.windowSizeLock, windowSizeLock) ||
                other.windowSizeLock == windowSizeLock));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      window,
      globalConfig,
      overlayWidth,
      overlayHeight,
      const DeepCollectionEquality().hash(_keyTileData),
      windowSizeLock);

  @override
  String toString() {
    return 'SettingsModel(window: $window, globalConfig: $globalConfig, overlayWidth: $overlayWidth, overlayHeight: $overlayHeight, keyTileData: $keyTileData, windowSizeLock: $windowSizeLock)';
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
      Set<KeyTileDataModel> keyTileData,
      bool windowSizeLock});

  @override
  $GlobalConfigModelCopyWith<$Res> get globalConfig;
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
    Object? keyTileData = null,
    Object? windowSizeLock = null,
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
      keyTileData: null == keyTileData
          ? _self._keyTileData
          : keyTileData // ignore: cast_nullable_to_non_nullable
              as Set<KeyTileDataModel>,
      windowSizeLock: null == windowSizeLock
          ? _self.windowSizeLock
          : windowSizeLock // ignore: cast_nullable_to_non_nullable
              as bool,
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
}

// dart format on
