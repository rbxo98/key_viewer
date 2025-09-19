// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'preset_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PresetModel {
  double get windowWidth;
  double get windowHeight;
  List<KeyTileDataModel> get keyTileData;

  /// Create a copy of PresetModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PresetModelCopyWith<PresetModel> get copyWith =>
      _$PresetModelCopyWithImpl<PresetModel>(this as PresetModel, _$identity);

  /// Serializes this PresetModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PresetModel &&
            (identical(other.windowWidth, windowWidth) ||
                other.windowWidth == windowWidth) &&
            (identical(other.windowHeight, windowHeight) ||
                other.windowHeight == windowHeight) &&
            const DeepCollectionEquality()
                .equals(other.keyTileData, keyTileData));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, windowWidth, windowHeight,
      const DeepCollectionEquality().hash(keyTileData));

  @override
  String toString() {
    return 'PresetModel(windowWidth: $windowWidth, windowHeight: $windowHeight, keyTileData: $keyTileData)';
  }
}

/// @nodoc
abstract mixin class $PresetModelCopyWith<$Res> {
  factory $PresetModelCopyWith(
          PresetModel value, $Res Function(PresetModel) _then) =
      _$PresetModelCopyWithImpl;
  @useResult
  $Res call(
      {double windowWidth,
      double windowHeight,
      List<KeyTileDataModel> keyTileData});
}

/// @nodoc
class _$PresetModelCopyWithImpl<$Res> implements $PresetModelCopyWith<$Res> {
  _$PresetModelCopyWithImpl(this._self, this._then);

  final PresetModel _self;
  final $Res Function(PresetModel) _then;

  /// Create a copy of PresetModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? windowWidth = null,
    Object? windowHeight = null,
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
      keyTileData: null == keyTileData
          ? _self.keyTileData
          : keyTileData // ignore: cast_nullable_to_non_nullable
              as List<KeyTileDataModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _PresetModel implements PresetModel {
  _PresetModel(
      {required this.windowWidth,
      required this.windowHeight,
      final List<KeyTileDataModel> keyTileData = const []})
      : _keyTileData = keyTileData;
  factory _PresetModel.fromJson(Map<String, dynamic> json) =>
      _$PresetModelFromJson(json);

  @override
  final double windowWidth;
  @override
  final double windowHeight;
  final List<KeyTileDataModel> _keyTileData;
  @override
  @JsonKey()
  List<KeyTileDataModel> get keyTileData {
    if (_keyTileData is EqualUnmodifiableListView) return _keyTileData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_keyTileData);
  }

  /// Create a copy of PresetModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PresetModelCopyWith<_PresetModel> get copyWith =>
      __$PresetModelCopyWithImpl<_PresetModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PresetModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PresetModel &&
            (identical(other.windowWidth, windowWidth) ||
                other.windowWidth == windowWidth) &&
            (identical(other.windowHeight, windowHeight) ||
                other.windowHeight == windowHeight) &&
            const DeepCollectionEquality()
                .equals(other._keyTileData, _keyTileData));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, windowWidth, windowHeight,
      const DeepCollectionEquality().hash(_keyTileData));

  @override
  String toString() {
    return 'PresetModel(windowWidth: $windowWidth, windowHeight: $windowHeight, keyTileData: $keyTileData)';
  }
}

/// @nodoc
abstract mixin class _$PresetModelCopyWith<$Res>
    implements $PresetModelCopyWith<$Res> {
  factory _$PresetModelCopyWith(
          _PresetModel value, $Res Function(_PresetModel) _then) =
      __$PresetModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {double windowWidth,
      double windowHeight,
      List<KeyTileDataModel> keyTileData});
}

/// @nodoc
class __$PresetModelCopyWithImpl<$Res> implements _$PresetModelCopyWith<$Res> {
  __$PresetModelCopyWithImpl(this._self, this._then);

  final _PresetModel _self;
  final $Res Function(_PresetModel) _then;

  /// Create a copy of PresetModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? windowWidth = null,
    Object? windowHeight = null,
    Object? keyTileData = null,
  }) {
    return _then(_PresetModel(
      windowWidth: null == windowWidth
          ? _self.windowWidth
          : windowWidth // ignore: cast_nullable_to_non_nullable
              as double,
      windowHeight: null == windowHeight
          ? _self.windowHeight
          : windowHeight // ignore: cast_nullable_to_non_nullable
              as double,
      keyTileData: null == keyTileData
          ? _self._keyTileData
          : keyTileData // ignore: cast_nullable_to_non_nullable
              as List<KeyTileDataModel>,
    ));
  }
}

// dart format on
