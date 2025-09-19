// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'config_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GlobalConfigModel {
  double get windowWidth;
  set windowWidth(double value);
  double get windowHeight;
  set windowHeight(double value);
  double get windowX;
  set windowX(double value);
  double get windowY;
  set windowY(double value);
  double get overlayWith;
  set overlayWith(double value);
  double get overlayHeight;
  set overlayHeight(double value);
  double get overlayX;
  set overlayX(double value);
  double get overlayY;
  set overlayY(double value);
  List<KeyTileDataModel> get keyTileData;
  set keyTileData(List<KeyTileDataModel> value);

  /// Create a copy of GlobalConfigModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GlobalConfigModelCopyWith<GlobalConfigModel> get copyWith =>
      _$GlobalConfigModelCopyWithImpl<GlobalConfigModel>(
          this as GlobalConfigModel, _$identity);

  /// Serializes this GlobalConfigModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  String toString() {
    return 'GlobalConfigModel(windowWidth: $windowWidth, windowHeight: $windowHeight, windowX: $windowX, windowY: $windowY, overlayWith: $overlayWith, overlayHeight: $overlayHeight, overlayX: $overlayX, overlayY: $overlayY, keyTileData: $keyTileData)';
  }
}

/// @nodoc
abstract mixin class $GlobalConfigModelCopyWith<$Res> {
  factory $GlobalConfigModelCopyWith(
          GlobalConfigModel value, $Res Function(GlobalConfigModel) _then) =
      _$GlobalConfigModelCopyWithImpl;
  @useResult
  $Res call(
      {double windowWidth,
      double windowHeight,
      double windowX,
      double windowY,
      double overlayWith,
      double overlayHeight,
      double overlayX,
      double overlayY,
      List<KeyTileDataModel> keyTileData});
}

/// @nodoc
class _$GlobalConfigModelCopyWithImpl<$Res>
    implements $GlobalConfigModelCopyWith<$Res> {
  _$GlobalConfigModelCopyWithImpl(this._self, this._then);

  final GlobalConfigModel _self;
  final $Res Function(GlobalConfigModel) _then;

  /// Create a copy of GlobalConfigModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? windowWidth = null,
    Object? windowHeight = null,
    Object? windowX = null,
    Object? windowY = null,
    Object? overlayWith = null,
    Object? overlayHeight = null,
    Object? overlayX = null,
    Object? overlayY = null,
    Object? keyTileData = null,
  }) {
    return _then(_self.copyWith(
      windowWidth: null == windowWidth
          ? _self.windowWidth
          : windowWidth // ignore: cast_nullable_to_non_nullable
              as double,
      windowHeight: null == windowHeight
          ? _self.windowHeight
          : windowHeight // ignore: cast_nullable_to_non_nullable
              as double,
      windowX: null == windowX
          ? _self.windowX
          : windowX // ignore: cast_nullable_to_non_nullable
              as double,
      windowY: null == windowY
          ? _self.windowY
          : windowY // ignore: cast_nullable_to_non_nullable
              as double,
      overlayWith: null == overlayWith
          ? _self.overlayWith
          : overlayWith // ignore: cast_nullable_to_non_nullable
              as double,
      overlayHeight: null == overlayHeight
          ? _self.overlayHeight
          : overlayHeight // ignore: cast_nullable_to_non_nullable
              as double,
      overlayX: null == overlayX
          ? _self.overlayX
          : overlayX // ignore: cast_nullable_to_non_nullable
              as double,
      overlayY: null == overlayY
          ? _self.overlayY
          : overlayY // ignore: cast_nullable_to_non_nullable
              as double,
      keyTileData: null == keyTileData
          ? _self.keyTileData
          : keyTileData // ignore: cast_nullable_to_non_nullable
              as List<KeyTileDataModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _GlobalConfigModel implements GlobalConfigModel {
  _GlobalConfigModel(
      {required this.windowWidth,
      required this.windowHeight,
      required this.windowX,
      required this.windowY,
      required this.overlayWith,
      required this.overlayHeight,
      required this.overlayX,
      required this.overlayY,
      this.keyTileData = const []});
  factory _GlobalConfigModel.fromJson(Map<String, dynamic> json) =>
      _$GlobalConfigModelFromJson(json);

  @override
  double windowWidth;
  @override
  double windowHeight;
  @override
  double windowX;
  @override
  double windowY;
  @override
  double overlayWith;
  @override
  double overlayHeight;
  @override
  double overlayX;
  @override
  double overlayY;
  @override
  @JsonKey()
  List<KeyTileDataModel> keyTileData;

  /// Create a copy of GlobalConfigModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GlobalConfigModelCopyWith<_GlobalConfigModel> get copyWith =>
      __$GlobalConfigModelCopyWithImpl<_GlobalConfigModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$GlobalConfigModelToJson(
      this,
    );
  }

  @override
  String toString() {
    return 'GlobalConfigModel(windowWidth: $windowWidth, windowHeight: $windowHeight, windowX: $windowX, windowY: $windowY, overlayWith: $overlayWith, overlayHeight: $overlayHeight, overlayX: $overlayX, overlayY: $overlayY, keyTileData: $keyTileData)';
  }
}

/// @nodoc
abstract mixin class _$GlobalConfigModelCopyWith<$Res>
    implements $GlobalConfigModelCopyWith<$Res> {
  factory _$GlobalConfigModelCopyWith(
          _GlobalConfigModel value, $Res Function(_GlobalConfigModel) _then) =
      __$GlobalConfigModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {double windowWidth,
      double windowHeight,
      double windowX,
      double windowY,
      double overlayWith,
      double overlayHeight,
      double overlayX,
      double overlayY,
      List<KeyTileDataModel> keyTileData});
}

/// @nodoc
class __$GlobalConfigModelCopyWithImpl<$Res>
    implements _$GlobalConfigModelCopyWith<$Res> {
  __$GlobalConfigModelCopyWithImpl(this._self, this._then);

  final _GlobalConfigModel _self;
  final $Res Function(_GlobalConfigModel) _then;

  /// Create a copy of GlobalConfigModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? windowWidth = null,
    Object? windowHeight = null,
    Object? windowX = null,
    Object? windowY = null,
    Object? overlayWith = null,
    Object? overlayHeight = null,
    Object? overlayX = null,
    Object? overlayY = null,
    Object? keyTileData = null,
  }) {
    return _then(_GlobalConfigModel(
      windowWidth: null == windowWidth
          ? _self.windowWidth
          : windowWidth // ignore: cast_nullable_to_non_nullable
              as double,
      windowHeight: null == windowHeight
          ? _self.windowHeight
          : windowHeight // ignore: cast_nullable_to_non_nullable
              as double,
      windowX: null == windowX
          ? _self.windowX
          : windowX // ignore: cast_nullable_to_non_nullable
              as double,
      windowY: null == windowY
          ? _self.windowY
          : windowY // ignore: cast_nullable_to_non_nullable
              as double,
      overlayWith: null == overlayWith
          ? _self.overlayWith
          : overlayWith // ignore: cast_nullable_to_non_nullable
              as double,
      overlayHeight: null == overlayHeight
          ? _self.overlayHeight
          : overlayHeight // ignore: cast_nullable_to_non_nullable
              as double,
      overlayX: null == overlayX
          ? _self.overlayX
          : overlayX // ignore: cast_nullable_to_non_nullable
              as double,
      overlayY: null == overlayY
          ? _self.overlayY
          : overlayY // ignore: cast_nullable_to_non_nullable
              as double,
      keyTileData: null == keyTileData
          ? _self.keyTileData
          : keyTileData // ignore: cast_nullable_to_non_nullable
              as List<KeyTileDataModel>,
    ));
  }
}

// dart format on
