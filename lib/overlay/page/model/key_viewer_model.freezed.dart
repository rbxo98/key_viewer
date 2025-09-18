// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'key_viewer_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$KeyViewerModel {
  Set<KeyTileDataModel> get keyTileData;
  Set<int> get pressedKeySet;

  /// Create a copy of KeyViewerModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $KeyViewerModelCopyWith<KeyViewerModel> get copyWith =>
      _$KeyViewerModelCopyWithImpl<KeyViewerModel>(
          this as KeyViewerModel, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is KeyViewerModel &&
            const DeepCollectionEquality()
                .equals(other.keyTileData, keyTileData) &&
            const DeepCollectionEquality()
                .equals(other.pressedKeySet, pressedKeySet));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(keyTileData),
      const DeepCollectionEquality().hash(pressedKeySet));

  @override
  String toString() {
    return 'KeyViewerModel(keyTileData: $keyTileData, pressedKeySet: $pressedKeySet)';
  }
}

/// @nodoc
abstract mixin class $KeyViewerModelCopyWith<$Res> {
  factory $KeyViewerModelCopyWith(
          KeyViewerModel value, $Res Function(KeyViewerModel) _then) =
      _$KeyViewerModelCopyWithImpl;
  @useResult
  $Res call({Set<KeyTileDataModel> keyTileData, Set<int> pressedKeySet});
}

/// @nodoc
class _$KeyViewerModelCopyWithImpl<$Res>
    implements $KeyViewerModelCopyWith<$Res> {
  _$KeyViewerModelCopyWithImpl(this._self, this._then);

  final KeyViewerModel _self;
  final $Res Function(KeyViewerModel) _then;

  /// Create a copy of KeyViewerModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? keyTileData = null,
    Object? pressedKeySet = null,
  }) {
    return _then(_self.copyWith(
      keyTileData: null == keyTileData
          ? _self.keyTileData
          : keyTileData // ignore: cast_nullable_to_non_nullable
              as Set<KeyTileDataModel>,
      pressedKeySet: null == pressedKeySet
          ? _self.pressedKeySet
          : pressedKeySet // ignore: cast_nullable_to_non_nullable
              as Set<int>,
    ));
  }
}

/// @nodoc

class _KeyViewerModel implements KeyViewerModel {
  _KeyViewerModel(
      {final Set<KeyTileDataModel> keyTileData = const {},
      final Set<int> pressedKeySet = const {}})
      : _keyTileData = keyTileData,
        _pressedKeySet = pressedKeySet;

  final Set<KeyTileDataModel> _keyTileData;
  @override
  @JsonKey()
  Set<KeyTileDataModel> get keyTileData {
    if (_keyTileData is EqualUnmodifiableSetView) return _keyTileData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_keyTileData);
  }

  final Set<int> _pressedKeySet;
  @override
  @JsonKey()
  Set<int> get pressedKeySet {
    if (_pressedKeySet is EqualUnmodifiableSetView) return _pressedKeySet;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_pressedKeySet);
  }

  /// Create a copy of KeyViewerModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$KeyViewerModelCopyWith<_KeyViewerModel> get copyWith =>
      __$KeyViewerModelCopyWithImpl<_KeyViewerModel>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _KeyViewerModel &&
            const DeepCollectionEquality()
                .equals(other._keyTileData, _keyTileData) &&
            const DeepCollectionEquality()
                .equals(other._pressedKeySet, _pressedKeySet));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_keyTileData),
      const DeepCollectionEquality().hash(_pressedKeySet));

  @override
  String toString() {
    return 'KeyViewerModel(keyTileData: $keyTileData, pressedKeySet: $pressedKeySet)';
  }
}

/// @nodoc
abstract mixin class _$KeyViewerModelCopyWith<$Res>
    implements $KeyViewerModelCopyWith<$Res> {
  factory _$KeyViewerModelCopyWith(
          _KeyViewerModel value, $Res Function(_KeyViewerModel) _then) =
      __$KeyViewerModelCopyWithImpl;
  @override
  @useResult
  $Res call({Set<KeyTileDataModel> keyTileData, Set<int> pressedKeySet});
}

/// @nodoc
class __$KeyViewerModelCopyWithImpl<$Res>
    implements _$KeyViewerModelCopyWith<$Res> {
  __$KeyViewerModelCopyWithImpl(this._self, this._then);

  final _KeyViewerModel _self;
  final $Res Function(_KeyViewerModel) _then;

  /// Create a copy of KeyViewerModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? keyTileData = null,
    Object? pressedKeySet = null,
  }) {
    return _then(_KeyViewerModel(
      keyTileData: null == keyTileData
          ? _self._keyTileData
          : keyTileData // ignore: cast_nullable_to_non_nullable
              as Set<KeyTileDataModel>,
      pressedKeySet: null == pressedKeySet
          ? _self._pressedKeySet
          : pressedKeySet // ignore: cast_nullable_to_non_nullable
              as Set<int>,
    ));
  }
}

// dart format on
