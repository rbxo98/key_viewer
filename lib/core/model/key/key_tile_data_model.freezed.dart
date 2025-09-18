// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'key_tile_data_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$KeyTileDataModel {
  String get primaryKey;
  int get key;
  set key(int value);
  String get label;
  set label(String value);
  int get keyCount;
  set keyCount(int value);
  int get gx;
  set gx(int value);
  int get gy;
  set gy(int value);
  int get gw;
  set gw(int value);
  int get gh;
  set gh(int value);
  KeyTileStyleModel get style;
  set style(KeyTileStyleModel value);

  /// Create a copy of KeyTileDataModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $KeyTileDataModelCopyWith<KeyTileDataModel> get copyWith =>
      _$KeyTileDataModelCopyWithImpl<KeyTileDataModel>(
          this as KeyTileDataModel, _$identity);

  /// Serializes this KeyTileDataModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  String toString() {
    return 'KeyTileDataModel(primaryKey: $primaryKey, key: $key, label: $label, keyCount: $keyCount, gx: $gx, gy: $gy, gw: $gw, gh: $gh, style: $style)';
  }
}

/// @nodoc
abstract mixin class $KeyTileDataModelCopyWith<$Res> {
  factory $KeyTileDataModelCopyWith(
          KeyTileDataModel value, $Res Function(KeyTileDataModel) _then) =
      _$KeyTileDataModelCopyWithImpl;
  @useResult
  $Res call(
      {String primaryKey,
      int key,
      String label,
      int keyCount,
      int gx,
      int gy,
      int gw,
      int gh,
      KeyTileStyleModel style});

  $KeyTileStyleModelCopyWith<$Res> get style;
}

/// @nodoc
class _$KeyTileDataModelCopyWithImpl<$Res>
    implements $KeyTileDataModelCopyWith<$Res> {
  _$KeyTileDataModelCopyWithImpl(this._self, this._then);

  final KeyTileDataModel _self;
  final $Res Function(KeyTileDataModel) _then;

  /// Create a copy of KeyTileDataModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? primaryKey = null,
    Object? key = null,
    Object? label = null,
    Object? keyCount = null,
    Object? gx = null,
    Object? gy = null,
    Object? gw = null,
    Object? gh = null,
    Object? style = null,
  }) {
    return _then(_self.copyWith(
      primaryKey: null == primaryKey
          ? _self.primaryKey
          : primaryKey // ignore: cast_nullable_to_non_nullable
              as String,
      key: null == key
          ? _self.key
          : key // ignore: cast_nullable_to_non_nullable
              as int,
      label: null == label
          ? _self.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      keyCount: null == keyCount
          ? _self.keyCount
          : keyCount // ignore: cast_nullable_to_non_nullable
              as int,
      gx: null == gx
          ? _self.gx
          : gx // ignore: cast_nullable_to_non_nullable
              as int,
      gy: null == gy
          ? _self.gy
          : gy // ignore: cast_nullable_to_non_nullable
              as int,
      gw: null == gw
          ? _self.gw
          : gw // ignore: cast_nullable_to_non_nullable
              as int,
      gh: null == gh
          ? _self.gh
          : gh // ignore: cast_nullable_to_non_nullable
              as int,
      style: null == style
          ? _self.style
          : style // ignore: cast_nullable_to_non_nullable
              as KeyTileStyleModel,
    ));
  }

  /// Create a copy of KeyTileDataModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $KeyTileStyleModelCopyWith<$Res> get style {
    return $KeyTileStyleModelCopyWith<$Res>(_self.style, (value) {
      return _then(_self.copyWith(style: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _KeyTileDataModel implements KeyTileDataModel {
  _KeyTileDataModel(
      {required this.primaryKey,
      required this.key,
      required this.label,
      required this.keyCount,
      required this.gx,
      required this.gy,
      required this.gw,
      required this.gh,
      required this.style});
  factory _KeyTileDataModel.fromJson(Map<String, dynamic> json) =>
      _$KeyTileDataModelFromJson(json);

  @override
  final String primaryKey;
  @override
  int key;
  @override
  String label;
  @override
  int keyCount;
  @override
  int gx;
  @override
  int gy;
  @override
  int gw;
  @override
  int gh;
  @override
  KeyTileStyleModel style;

  /// Create a copy of KeyTileDataModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$KeyTileDataModelCopyWith<_KeyTileDataModel> get copyWith =>
      __$KeyTileDataModelCopyWithImpl<_KeyTileDataModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$KeyTileDataModelToJson(
      this,
    );
  }

  @override
  String toString() {
    return 'KeyTileDataModel(primaryKey: $primaryKey, key: $key, label: $label, keyCount: $keyCount, gx: $gx, gy: $gy, gw: $gw, gh: $gh, style: $style)';
  }
}

/// @nodoc
abstract mixin class _$KeyTileDataModelCopyWith<$Res>
    implements $KeyTileDataModelCopyWith<$Res> {
  factory _$KeyTileDataModelCopyWith(
          _KeyTileDataModel value, $Res Function(_KeyTileDataModel) _then) =
      __$KeyTileDataModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String primaryKey,
      int key,
      String label,
      int keyCount,
      int gx,
      int gy,
      int gw,
      int gh,
      KeyTileStyleModel style});

  @override
  $KeyTileStyleModelCopyWith<$Res> get style;
}

/// @nodoc
class __$KeyTileDataModelCopyWithImpl<$Res>
    implements _$KeyTileDataModelCopyWith<$Res> {
  __$KeyTileDataModelCopyWithImpl(this._self, this._then);

  final _KeyTileDataModel _self;
  final $Res Function(_KeyTileDataModel) _then;

  /// Create a copy of KeyTileDataModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? primaryKey = null,
    Object? key = null,
    Object? label = null,
    Object? keyCount = null,
    Object? gx = null,
    Object? gy = null,
    Object? gw = null,
    Object? gh = null,
    Object? style = null,
  }) {
    return _then(_KeyTileDataModel(
      primaryKey: null == primaryKey
          ? _self.primaryKey
          : primaryKey // ignore: cast_nullable_to_non_nullable
              as String,
      key: null == key
          ? _self.key
          : key // ignore: cast_nullable_to_non_nullable
              as int,
      label: null == label
          ? _self.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      keyCount: null == keyCount
          ? _self.keyCount
          : keyCount // ignore: cast_nullable_to_non_nullable
              as int,
      gx: null == gx
          ? _self.gx
          : gx // ignore: cast_nullable_to_non_nullable
              as int,
      gy: null == gy
          ? _self.gy
          : gy // ignore: cast_nullable_to_non_nullable
              as int,
      gw: null == gw
          ? _self.gw
          : gw // ignore: cast_nullable_to_non_nullable
              as int,
      gh: null == gh
          ? _self.gh
          : gh // ignore: cast_nullable_to_non_nullable
              as int,
      style: null == style
          ? _self.style
          : style // ignore: cast_nullable_to_non_nullable
              as KeyTileStyleModel,
    ));
  }

  /// Create a copy of KeyTileDataModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $KeyTileStyleModelCopyWith<$Res> get style {
    return $KeyTileStyleModelCopyWith<$Res>(_self.style, (value) {
      return _then(_self.copyWith(style: value));
    });
  }
}

/// @nodoc
mixin _$KeyTileStyleModel {
  double get idleBorderRadius;
  double get idleBorderWidth;
  int get idleBorderColor;
  int get idleBackgroundColor;
  double get pressedBorderRadius;
  double get pressedBorderWidth;
  int get pressedBorderColor;
  int get pressedBackgroundColor;
  double get idleKeyFontSize;
  int get idleKeyFontWeight;
  int get idleKeyFontColor;
  double get pressedKeyFontSize;
  int get pressedKeyFontWeight;
  int get pressedKeyFontColor;
  double get idleCounterFontSize;
  int get idleCounterFontWeight;
  int get idleCounterFontColor;
  double get pressedCounterFontSize;
  int get pressedCounterFontWeight;
  int get pressedCounterFontColor;

  /// Create a copy of KeyTileStyleModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $KeyTileStyleModelCopyWith<KeyTileStyleModel> get copyWith =>
      _$KeyTileStyleModelCopyWithImpl<KeyTileStyleModel>(
          this as KeyTileStyleModel, _$identity);

  /// Serializes this KeyTileStyleModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is KeyTileStyleModel &&
            (identical(other.idleBorderRadius, idleBorderRadius) ||
                other.idleBorderRadius == idleBorderRadius) &&
            (identical(other.idleBorderWidth, idleBorderWidth) ||
                other.idleBorderWidth == idleBorderWidth) &&
            (identical(other.idleBorderColor, idleBorderColor) ||
                other.idleBorderColor == idleBorderColor) &&
            (identical(other.idleBackgroundColor, idleBackgroundColor) ||
                other.idleBackgroundColor == idleBackgroundColor) &&
            (identical(other.pressedBorderRadius, pressedBorderRadius) ||
                other.pressedBorderRadius == pressedBorderRadius) &&
            (identical(other.pressedBorderWidth, pressedBorderWidth) ||
                other.pressedBorderWidth == pressedBorderWidth) &&
            (identical(other.pressedBorderColor, pressedBorderColor) ||
                other.pressedBorderColor == pressedBorderColor) &&
            (identical(other.pressedBackgroundColor, pressedBackgroundColor) ||
                other.pressedBackgroundColor == pressedBackgroundColor) &&
            (identical(other.idleKeyFontSize, idleKeyFontSize) ||
                other.idleKeyFontSize == idleKeyFontSize) &&
            (identical(other.idleKeyFontWeight, idleKeyFontWeight) ||
                other.idleKeyFontWeight == idleKeyFontWeight) &&
            (identical(other.idleKeyFontColor, idleKeyFontColor) ||
                other.idleKeyFontColor == idleKeyFontColor) &&
            (identical(other.pressedKeyFontSize, pressedKeyFontSize) ||
                other.pressedKeyFontSize == pressedKeyFontSize) &&
            (identical(other.pressedKeyFontWeight, pressedKeyFontWeight) ||
                other.pressedKeyFontWeight == pressedKeyFontWeight) &&
            (identical(other.pressedKeyFontColor, pressedKeyFontColor) ||
                other.pressedKeyFontColor == pressedKeyFontColor) &&
            (identical(other.idleCounterFontSize, idleCounterFontSize) ||
                other.idleCounterFontSize == idleCounterFontSize) &&
            (identical(other.idleCounterFontWeight, idleCounterFontWeight) ||
                other.idleCounterFontWeight == idleCounterFontWeight) &&
            (identical(other.idleCounterFontColor, idleCounterFontColor) ||
                other.idleCounterFontColor == idleCounterFontColor) &&
            (identical(other.pressedCounterFontSize, pressedCounterFontSize) ||
                other.pressedCounterFontSize == pressedCounterFontSize) &&
            (identical(
                    other.pressedCounterFontWeight, pressedCounterFontWeight) ||
                other.pressedCounterFontWeight == pressedCounterFontWeight) &&
            (identical(
                    other.pressedCounterFontColor, pressedCounterFontColor) ||
                other.pressedCounterFontColor == pressedCounterFontColor));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        idleBorderRadius,
        idleBorderWidth,
        idleBorderColor,
        idleBackgroundColor,
        pressedBorderRadius,
        pressedBorderWidth,
        pressedBorderColor,
        pressedBackgroundColor,
        idleKeyFontSize,
        idleKeyFontWeight,
        idleKeyFontColor,
        pressedKeyFontSize,
        pressedKeyFontWeight,
        pressedKeyFontColor,
        idleCounterFontSize,
        idleCounterFontWeight,
        idleCounterFontColor,
        pressedCounterFontSize,
        pressedCounterFontWeight,
        pressedCounterFontColor
      ]);

  @override
  String toString() {
    return 'KeyTileStyleModel(idleBorderRadius: $idleBorderRadius, idleBorderWidth: $idleBorderWidth, idleBorderColor: $idleBorderColor, idleBackgroundColor: $idleBackgroundColor, pressedBorderRadius: $pressedBorderRadius, pressedBorderWidth: $pressedBorderWidth, pressedBorderColor: $pressedBorderColor, pressedBackgroundColor: $pressedBackgroundColor, idleKeyFontSize: $idleKeyFontSize, idleKeyFontWeight: $idleKeyFontWeight, idleKeyFontColor: $idleKeyFontColor, pressedKeyFontSize: $pressedKeyFontSize, pressedKeyFontWeight: $pressedKeyFontWeight, pressedKeyFontColor: $pressedKeyFontColor, idleCounterFontSize: $idleCounterFontSize, idleCounterFontWeight: $idleCounterFontWeight, idleCounterFontColor: $idleCounterFontColor, pressedCounterFontSize: $pressedCounterFontSize, pressedCounterFontWeight: $pressedCounterFontWeight, pressedCounterFontColor: $pressedCounterFontColor)';
  }
}

/// @nodoc
abstract mixin class $KeyTileStyleModelCopyWith<$Res> {
  factory $KeyTileStyleModelCopyWith(
          KeyTileStyleModel value, $Res Function(KeyTileStyleModel) _then) =
      _$KeyTileStyleModelCopyWithImpl;
  @useResult
  $Res call(
      {double idleBorderRadius,
      double idleBorderWidth,
      int idleBorderColor,
      int idleBackgroundColor,
      double pressedBorderRadius,
      double pressedBorderWidth,
      int pressedBorderColor,
      int pressedBackgroundColor,
      double idleKeyFontSize,
      int idleKeyFontWeight,
      int idleKeyFontColor,
      double pressedKeyFontSize,
      int pressedKeyFontWeight,
      int pressedKeyFontColor,
      double idleCounterFontSize,
      int idleCounterFontWeight,
      int idleCounterFontColor,
      double pressedCounterFontSize,
      int pressedCounterFontWeight,
      int pressedCounterFontColor});
}

/// @nodoc
class _$KeyTileStyleModelCopyWithImpl<$Res>
    implements $KeyTileStyleModelCopyWith<$Res> {
  _$KeyTileStyleModelCopyWithImpl(this._self, this._then);

  final KeyTileStyleModel _self;
  final $Res Function(KeyTileStyleModel) _then;

  /// Create a copy of KeyTileStyleModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idleBorderRadius = null,
    Object? idleBorderWidth = null,
    Object? idleBorderColor = null,
    Object? idleBackgroundColor = null,
    Object? pressedBorderRadius = null,
    Object? pressedBorderWidth = null,
    Object? pressedBorderColor = null,
    Object? pressedBackgroundColor = null,
    Object? idleKeyFontSize = null,
    Object? idleKeyFontWeight = null,
    Object? idleKeyFontColor = null,
    Object? pressedKeyFontSize = null,
    Object? pressedKeyFontWeight = null,
    Object? pressedKeyFontColor = null,
    Object? idleCounterFontSize = null,
    Object? idleCounterFontWeight = null,
    Object? idleCounterFontColor = null,
    Object? pressedCounterFontSize = null,
    Object? pressedCounterFontWeight = null,
    Object? pressedCounterFontColor = null,
  }) {
    return _then(_self.copyWith(
      idleBorderRadius: null == idleBorderRadius
          ? _self.idleBorderRadius
          : idleBorderRadius // ignore: cast_nullable_to_non_nullable
              as double,
      idleBorderWidth: null == idleBorderWidth
          ? _self.idleBorderWidth
          : idleBorderWidth // ignore: cast_nullable_to_non_nullable
              as double,
      idleBorderColor: null == idleBorderColor
          ? _self.idleBorderColor
          : idleBorderColor // ignore: cast_nullable_to_non_nullable
              as int,
      idleBackgroundColor: null == idleBackgroundColor
          ? _self.idleBackgroundColor
          : idleBackgroundColor // ignore: cast_nullable_to_non_nullable
              as int,
      pressedBorderRadius: null == pressedBorderRadius
          ? _self.pressedBorderRadius
          : pressedBorderRadius // ignore: cast_nullable_to_non_nullable
              as double,
      pressedBorderWidth: null == pressedBorderWidth
          ? _self.pressedBorderWidth
          : pressedBorderWidth // ignore: cast_nullable_to_non_nullable
              as double,
      pressedBorderColor: null == pressedBorderColor
          ? _self.pressedBorderColor
          : pressedBorderColor // ignore: cast_nullable_to_non_nullable
              as int,
      pressedBackgroundColor: null == pressedBackgroundColor
          ? _self.pressedBackgroundColor
          : pressedBackgroundColor // ignore: cast_nullable_to_non_nullable
              as int,
      idleKeyFontSize: null == idleKeyFontSize
          ? _self.idleKeyFontSize
          : idleKeyFontSize // ignore: cast_nullable_to_non_nullable
              as double,
      idleKeyFontWeight: null == idleKeyFontWeight
          ? _self.idleKeyFontWeight
          : idleKeyFontWeight // ignore: cast_nullable_to_non_nullable
              as int,
      idleKeyFontColor: null == idleKeyFontColor
          ? _self.idleKeyFontColor
          : idleKeyFontColor // ignore: cast_nullable_to_non_nullable
              as int,
      pressedKeyFontSize: null == pressedKeyFontSize
          ? _self.pressedKeyFontSize
          : pressedKeyFontSize // ignore: cast_nullable_to_non_nullable
              as double,
      pressedKeyFontWeight: null == pressedKeyFontWeight
          ? _self.pressedKeyFontWeight
          : pressedKeyFontWeight // ignore: cast_nullable_to_non_nullable
              as int,
      pressedKeyFontColor: null == pressedKeyFontColor
          ? _self.pressedKeyFontColor
          : pressedKeyFontColor // ignore: cast_nullable_to_non_nullable
              as int,
      idleCounterFontSize: null == idleCounterFontSize
          ? _self.idleCounterFontSize
          : idleCounterFontSize // ignore: cast_nullable_to_non_nullable
              as double,
      idleCounterFontWeight: null == idleCounterFontWeight
          ? _self.idleCounterFontWeight
          : idleCounterFontWeight // ignore: cast_nullable_to_non_nullable
              as int,
      idleCounterFontColor: null == idleCounterFontColor
          ? _self.idleCounterFontColor
          : idleCounterFontColor // ignore: cast_nullable_to_non_nullable
              as int,
      pressedCounterFontSize: null == pressedCounterFontSize
          ? _self.pressedCounterFontSize
          : pressedCounterFontSize // ignore: cast_nullable_to_non_nullable
              as double,
      pressedCounterFontWeight: null == pressedCounterFontWeight
          ? _self.pressedCounterFontWeight
          : pressedCounterFontWeight // ignore: cast_nullable_to_non_nullable
              as int,
      pressedCounterFontColor: null == pressedCounterFontColor
          ? _self.pressedCounterFontColor
          : pressedCounterFontColor // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _KeyTileStyleModel implements KeyTileStyleModel {
  const _KeyTileStyleModel(
      {required this.idleBorderRadius,
      required this.idleBorderWidth,
      required this.idleBorderColor,
      required this.idleBackgroundColor,
      required this.pressedBorderRadius,
      required this.pressedBorderWidth,
      required this.pressedBorderColor,
      required this.pressedBackgroundColor,
      required this.idleKeyFontSize,
      required this.idleKeyFontWeight,
      required this.idleKeyFontColor,
      required this.pressedKeyFontSize,
      required this.pressedKeyFontWeight,
      required this.pressedKeyFontColor,
      required this.idleCounterFontSize,
      required this.idleCounterFontWeight,
      required this.idleCounterFontColor,
      required this.pressedCounterFontSize,
      required this.pressedCounterFontWeight,
      required this.pressedCounterFontColor});
  factory _KeyTileStyleModel.fromJson(Map<String, dynamic> json) =>
      _$KeyTileStyleModelFromJson(json);

  @override
  final double idleBorderRadius;
  @override
  final double idleBorderWidth;
  @override
  final int idleBorderColor;
  @override
  final int idleBackgroundColor;
  @override
  final double pressedBorderRadius;
  @override
  final double pressedBorderWidth;
  @override
  final int pressedBorderColor;
  @override
  final int pressedBackgroundColor;
  @override
  final double idleKeyFontSize;
  @override
  final int idleKeyFontWeight;
  @override
  final int idleKeyFontColor;
  @override
  final double pressedKeyFontSize;
  @override
  final int pressedKeyFontWeight;
  @override
  final int pressedKeyFontColor;
  @override
  final double idleCounterFontSize;
  @override
  final int idleCounterFontWeight;
  @override
  final int idleCounterFontColor;
  @override
  final double pressedCounterFontSize;
  @override
  final int pressedCounterFontWeight;
  @override
  final int pressedCounterFontColor;

  /// Create a copy of KeyTileStyleModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$KeyTileStyleModelCopyWith<_KeyTileStyleModel> get copyWith =>
      __$KeyTileStyleModelCopyWithImpl<_KeyTileStyleModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$KeyTileStyleModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _KeyTileStyleModel &&
            (identical(other.idleBorderRadius, idleBorderRadius) ||
                other.idleBorderRadius == idleBorderRadius) &&
            (identical(other.idleBorderWidth, idleBorderWidth) ||
                other.idleBorderWidth == idleBorderWidth) &&
            (identical(other.idleBorderColor, idleBorderColor) ||
                other.idleBorderColor == idleBorderColor) &&
            (identical(other.idleBackgroundColor, idleBackgroundColor) ||
                other.idleBackgroundColor == idleBackgroundColor) &&
            (identical(other.pressedBorderRadius, pressedBorderRadius) ||
                other.pressedBorderRadius == pressedBorderRadius) &&
            (identical(other.pressedBorderWidth, pressedBorderWidth) ||
                other.pressedBorderWidth == pressedBorderWidth) &&
            (identical(other.pressedBorderColor, pressedBorderColor) ||
                other.pressedBorderColor == pressedBorderColor) &&
            (identical(other.pressedBackgroundColor, pressedBackgroundColor) ||
                other.pressedBackgroundColor == pressedBackgroundColor) &&
            (identical(other.idleKeyFontSize, idleKeyFontSize) ||
                other.idleKeyFontSize == idleKeyFontSize) &&
            (identical(other.idleKeyFontWeight, idleKeyFontWeight) ||
                other.idleKeyFontWeight == idleKeyFontWeight) &&
            (identical(other.idleKeyFontColor, idleKeyFontColor) ||
                other.idleKeyFontColor == idleKeyFontColor) &&
            (identical(other.pressedKeyFontSize, pressedKeyFontSize) ||
                other.pressedKeyFontSize == pressedKeyFontSize) &&
            (identical(other.pressedKeyFontWeight, pressedKeyFontWeight) ||
                other.pressedKeyFontWeight == pressedKeyFontWeight) &&
            (identical(other.pressedKeyFontColor, pressedKeyFontColor) ||
                other.pressedKeyFontColor == pressedKeyFontColor) &&
            (identical(other.idleCounterFontSize, idleCounterFontSize) ||
                other.idleCounterFontSize == idleCounterFontSize) &&
            (identical(other.idleCounterFontWeight, idleCounterFontWeight) ||
                other.idleCounterFontWeight == idleCounterFontWeight) &&
            (identical(other.idleCounterFontColor, idleCounterFontColor) ||
                other.idleCounterFontColor == idleCounterFontColor) &&
            (identical(other.pressedCounterFontSize, pressedCounterFontSize) ||
                other.pressedCounterFontSize == pressedCounterFontSize) &&
            (identical(
                    other.pressedCounterFontWeight, pressedCounterFontWeight) ||
                other.pressedCounterFontWeight == pressedCounterFontWeight) &&
            (identical(
                    other.pressedCounterFontColor, pressedCounterFontColor) ||
                other.pressedCounterFontColor == pressedCounterFontColor));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        idleBorderRadius,
        idleBorderWidth,
        idleBorderColor,
        idleBackgroundColor,
        pressedBorderRadius,
        pressedBorderWidth,
        pressedBorderColor,
        pressedBackgroundColor,
        idleKeyFontSize,
        idleKeyFontWeight,
        idleKeyFontColor,
        pressedKeyFontSize,
        pressedKeyFontWeight,
        pressedKeyFontColor,
        idleCounterFontSize,
        idleCounterFontWeight,
        idleCounterFontColor,
        pressedCounterFontSize,
        pressedCounterFontWeight,
        pressedCounterFontColor
      ]);

  @override
  String toString() {
    return 'KeyTileStyleModel(idleBorderRadius: $idleBorderRadius, idleBorderWidth: $idleBorderWidth, idleBorderColor: $idleBorderColor, idleBackgroundColor: $idleBackgroundColor, pressedBorderRadius: $pressedBorderRadius, pressedBorderWidth: $pressedBorderWidth, pressedBorderColor: $pressedBorderColor, pressedBackgroundColor: $pressedBackgroundColor, idleKeyFontSize: $idleKeyFontSize, idleKeyFontWeight: $idleKeyFontWeight, idleKeyFontColor: $idleKeyFontColor, pressedKeyFontSize: $pressedKeyFontSize, pressedKeyFontWeight: $pressedKeyFontWeight, pressedKeyFontColor: $pressedKeyFontColor, idleCounterFontSize: $idleCounterFontSize, idleCounterFontWeight: $idleCounterFontWeight, idleCounterFontColor: $idleCounterFontColor, pressedCounterFontSize: $pressedCounterFontSize, pressedCounterFontWeight: $pressedCounterFontWeight, pressedCounterFontColor: $pressedCounterFontColor)';
  }
}

/// @nodoc
abstract mixin class _$KeyTileStyleModelCopyWith<$Res>
    implements $KeyTileStyleModelCopyWith<$Res> {
  factory _$KeyTileStyleModelCopyWith(
          _KeyTileStyleModel value, $Res Function(_KeyTileStyleModel) _then) =
      __$KeyTileStyleModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {double idleBorderRadius,
      double idleBorderWidth,
      int idleBorderColor,
      int idleBackgroundColor,
      double pressedBorderRadius,
      double pressedBorderWidth,
      int pressedBorderColor,
      int pressedBackgroundColor,
      double idleKeyFontSize,
      int idleKeyFontWeight,
      int idleKeyFontColor,
      double pressedKeyFontSize,
      int pressedKeyFontWeight,
      int pressedKeyFontColor,
      double idleCounterFontSize,
      int idleCounterFontWeight,
      int idleCounterFontColor,
      double pressedCounterFontSize,
      int pressedCounterFontWeight,
      int pressedCounterFontColor});
}

/// @nodoc
class __$KeyTileStyleModelCopyWithImpl<$Res>
    implements _$KeyTileStyleModelCopyWith<$Res> {
  __$KeyTileStyleModelCopyWithImpl(this._self, this._then);

  final _KeyTileStyleModel _self;
  final $Res Function(_KeyTileStyleModel) _then;

  /// Create a copy of KeyTileStyleModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? idleBorderRadius = null,
    Object? idleBorderWidth = null,
    Object? idleBorderColor = null,
    Object? idleBackgroundColor = null,
    Object? pressedBorderRadius = null,
    Object? pressedBorderWidth = null,
    Object? pressedBorderColor = null,
    Object? pressedBackgroundColor = null,
    Object? idleKeyFontSize = null,
    Object? idleKeyFontWeight = null,
    Object? idleKeyFontColor = null,
    Object? pressedKeyFontSize = null,
    Object? pressedKeyFontWeight = null,
    Object? pressedKeyFontColor = null,
    Object? idleCounterFontSize = null,
    Object? idleCounterFontWeight = null,
    Object? idleCounterFontColor = null,
    Object? pressedCounterFontSize = null,
    Object? pressedCounterFontWeight = null,
    Object? pressedCounterFontColor = null,
  }) {
    return _then(_KeyTileStyleModel(
      idleBorderRadius: null == idleBorderRadius
          ? _self.idleBorderRadius
          : idleBorderRadius // ignore: cast_nullable_to_non_nullable
              as double,
      idleBorderWidth: null == idleBorderWidth
          ? _self.idleBorderWidth
          : idleBorderWidth // ignore: cast_nullable_to_non_nullable
              as double,
      idleBorderColor: null == idleBorderColor
          ? _self.idleBorderColor
          : idleBorderColor // ignore: cast_nullable_to_non_nullable
              as int,
      idleBackgroundColor: null == idleBackgroundColor
          ? _self.idleBackgroundColor
          : idleBackgroundColor // ignore: cast_nullable_to_non_nullable
              as int,
      pressedBorderRadius: null == pressedBorderRadius
          ? _self.pressedBorderRadius
          : pressedBorderRadius // ignore: cast_nullable_to_non_nullable
              as double,
      pressedBorderWidth: null == pressedBorderWidth
          ? _self.pressedBorderWidth
          : pressedBorderWidth // ignore: cast_nullable_to_non_nullable
              as double,
      pressedBorderColor: null == pressedBorderColor
          ? _self.pressedBorderColor
          : pressedBorderColor // ignore: cast_nullable_to_non_nullable
              as int,
      pressedBackgroundColor: null == pressedBackgroundColor
          ? _self.pressedBackgroundColor
          : pressedBackgroundColor // ignore: cast_nullable_to_non_nullable
              as int,
      idleKeyFontSize: null == idleKeyFontSize
          ? _self.idleKeyFontSize
          : idleKeyFontSize // ignore: cast_nullable_to_non_nullable
              as double,
      idleKeyFontWeight: null == idleKeyFontWeight
          ? _self.idleKeyFontWeight
          : idleKeyFontWeight // ignore: cast_nullable_to_non_nullable
              as int,
      idleKeyFontColor: null == idleKeyFontColor
          ? _self.idleKeyFontColor
          : idleKeyFontColor // ignore: cast_nullable_to_non_nullable
              as int,
      pressedKeyFontSize: null == pressedKeyFontSize
          ? _self.pressedKeyFontSize
          : pressedKeyFontSize // ignore: cast_nullable_to_non_nullable
              as double,
      pressedKeyFontWeight: null == pressedKeyFontWeight
          ? _self.pressedKeyFontWeight
          : pressedKeyFontWeight // ignore: cast_nullable_to_non_nullable
              as int,
      pressedKeyFontColor: null == pressedKeyFontColor
          ? _self.pressedKeyFontColor
          : pressedKeyFontColor // ignore: cast_nullable_to_non_nullable
              as int,
      idleCounterFontSize: null == idleCounterFontSize
          ? _self.idleCounterFontSize
          : idleCounterFontSize // ignore: cast_nullable_to_non_nullable
              as double,
      idleCounterFontWeight: null == idleCounterFontWeight
          ? _self.idleCounterFontWeight
          : idleCounterFontWeight // ignore: cast_nullable_to_non_nullable
              as int,
      idleCounterFontColor: null == idleCounterFontColor
          ? _self.idleCounterFontColor
          : idleCounterFontColor // ignore: cast_nullable_to_non_nullable
              as int,
      pressedCounterFontSize: null == pressedCounterFontSize
          ? _self.pressedCounterFontSize
          : pressedCounterFontSize // ignore: cast_nullable_to_non_nullable
              as double,
      pressedCounterFontWeight: null == pressedCounterFontWeight
          ? _self.pressedCounterFontWeight
          : pressedCounterFontWeight // ignore: cast_nullable_to_non_nullable
              as int,
      pressedCounterFontColor: null == pressedCounterFontColor
          ? _self.pressedCounterFontColor
          : pressedCounterFontColor // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
