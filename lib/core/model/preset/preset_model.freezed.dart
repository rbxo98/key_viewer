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
  String get presetName;
  int get switchKey;
  List<KeyTileDataGroupModel> get keyTileDataGroup;
  int get currentGroupIdx;

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
            (identical(other.presetName, presetName) ||
                other.presetName == presetName) &&
            (identical(other.switchKey, switchKey) ||
                other.switchKey == switchKey) &&
            const DeepCollectionEquality()
                .equals(other.keyTileDataGroup, keyTileDataGroup) &&
            (identical(other.currentGroupIdx, currentGroupIdx) ||
                other.currentGroupIdx == currentGroupIdx));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, presetName, switchKey,
      const DeepCollectionEquality().hash(keyTileDataGroup), currentGroupIdx);

  @override
  String toString() {
    return 'PresetModel(presetName: $presetName, switchKey: $switchKey, keyTileDataGroup: $keyTileDataGroup, currentGroupIdx: $currentGroupIdx)';
  }
}

/// @nodoc
abstract mixin class $PresetModelCopyWith<$Res> {
  factory $PresetModelCopyWith(
          PresetModel value, $Res Function(PresetModel) _then) =
      _$PresetModelCopyWithImpl;
  @useResult
  $Res call(
      {String presetName,
      int switchKey,
      List<KeyTileDataGroupModel> keyTileDataGroup,
      int currentGroupIdx});
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
    Object? presetName = null,
    Object? switchKey = null,
    Object? keyTileDataGroup = null,
    Object? currentGroupIdx = null,
  }) {
    return _then(_self.copyWith(
      presetName: null == presetName
          ? _self.presetName
          : presetName // ignore: cast_nullable_to_non_nullable
              as String,
      switchKey: null == switchKey
          ? _self.switchKey
          : switchKey // ignore: cast_nullable_to_non_nullable
              as int,
      keyTileDataGroup: null == keyTileDataGroup
          ? _self.keyTileDataGroup
          : keyTileDataGroup // ignore: cast_nullable_to_non_nullable
              as List<KeyTileDataGroupModel>,
      currentGroupIdx: null == currentGroupIdx
          ? _self.currentGroupIdx
          : currentGroupIdx // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _PresetModel extends PresetModel {
  _PresetModel(
      {required this.presetName,
      this.switchKey = VIRTUAL_KEY.VK_TAB,
      final List<KeyTileDataGroupModel> keyTileDataGroup = const [],
      this.currentGroupIdx = 0})
      : _keyTileDataGroup = keyTileDataGroup,
        super._();
  factory _PresetModel.fromJson(Map<String, dynamic> json) =>
      _$PresetModelFromJson(json);

  @override
  final String presetName;
  @override
  @JsonKey()
  final int switchKey;
  final List<KeyTileDataGroupModel> _keyTileDataGroup;
  @override
  @JsonKey()
  List<KeyTileDataGroupModel> get keyTileDataGroup {
    if (_keyTileDataGroup is EqualUnmodifiableListView)
      return _keyTileDataGroup;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_keyTileDataGroup);
  }

  @override
  @JsonKey()
  final int currentGroupIdx;

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
            (identical(other.presetName, presetName) ||
                other.presetName == presetName) &&
            (identical(other.switchKey, switchKey) ||
                other.switchKey == switchKey) &&
            const DeepCollectionEquality()
                .equals(other._keyTileDataGroup, _keyTileDataGroup) &&
            (identical(other.currentGroupIdx, currentGroupIdx) ||
                other.currentGroupIdx == currentGroupIdx));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, presetName, switchKey,
      const DeepCollectionEquality().hash(_keyTileDataGroup), currentGroupIdx);

  @override
  String toString() {
    return 'PresetModel(presetName: $presetName, switchKey: $switchKey, keyTileDataGroup: $keyTileDataGroup, currentGroupIdx: $currentGroupIdx)';
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
      {String presetName,
      int switchKey,
      List<KeyTileDataGroupModel> keyTileDataGroup,
      int currentGroupIdx});
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
    Object? presetName = null,
    Object? switchKey = null,
    Object? keyTileDataGroup = null,
    Object? currentGroupIdx = null,
  }) {
    return _then(_PresetModel(
      presetName: null == presetName
          ? _self.presetName
          : presetName // ignore: cast_nullable_to_non_nullable
              as String,
      switchKey: null == switchKey
          ? _self.switchKey
          : switchKey // ignore: cast_nullable_to_non_nullable
              as int,
      keyTileDataGroup: null == keyTileDataGroup
          ? _self._keyTileDataGroup
          : keyTileDataGroup // ignore: cast_nullable_to_non_nullable
              as List<KeyTileDataGroupModel>,
      currentGroupIdx: null == currentGroupIdx
          ? _self.currentGroupIdx
          : currentGroupIdx // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
mixin _$KeyTileDataGroupModel {
  String get name;
  List<KeyTileDataModel> get keyTileData;

  /// Create a copy of KeyTileDataGroupModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $KeyTileDataGroupModelCopyWith<KeyTileDataGroupModel> get copyWith =>
      _$KeyTileDataGroupModelCopyWithImpl<KeyTileDataGroupModel>(
          this as KeyTileDataGroupModel, _$identity);

  /// Serializes this KeyTileDataGroupModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is KeyTileDataGroupModel &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality()
                .equals(other.keyTileData, keyTileData));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, name, const DeepCollectionEquality().hash(keyTileData));

  @override
  String toString() {
    return 'KeyTileDataGroupModel(name: $name, keyTileData: $keyTileData)';
  }
}

/// @nodoc
abstract mixin class $KeyTileDataGroupModelCopyWith<$Res> {
  factory $KeyTileDataGroupModelCopyWith(KeyTileDataGroupModel value,
          $Res Function(KeyTileDataGroupModel) _then) =
      _$KeyTileDataGroupModelCopyWithImpl;
  @useResult
  $Res call({String name, List<KeyTileDataModel> keyTileData});
}

/// @nodoc
class _$KeyTileDataGroupModelCopyWithImpl<$Res>
    implements $KeyTileDataGroupModelCopyWith<$Res> {
  _$KeyTileDataGroupModelCopyWithImpl(this._self, this._then);

  final KeyTileDataGroupModel _self;
  final $Res Function(KeyTileDataGroupModel) _then;

  /// Create a copy of KeyTileDataGroupModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? keyTileData = null,
  }) {
    return _then(_self.copyWith(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      keyTileData: null == keyTileData
          ? _self.keyTileData
          : keyTileData // ignore: cast_nullable_to_non_nullable
              as List<KeyTileDataModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _KeyTileDataGroupModel extends KeyTileDataGroupModel {
  _KeyTileDataGroupModel(
      {required this.name, final List<KeyTileDataModel> keyTileData = const []})
      : _keyTileData = keyTileData,
        super._();
  factory _KeyTileDataGroupModel.fromJson(Map<String, dynamic> json) =>
      _$KeyTileDataGroupModelFromJson(json);

  @override
  final String name;
  final List<KeyTileDataModel> _keyTileData;
  @override
  @JsonKey()
  List<KeyTileDataModel> get keyTileData {
    if (_keyTileData is EqualUnmodifiableListView) return _keyTileData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_keyTileData);
  }

  /// Create a copy of KeyTileDataGroupModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$KeyTileDataGroupModelCopyWith<_KeyTileDataGroupModel> get copyWith =>
      __$KeyTileDataGroupModelCopyWithImpl<_KeyTileDataGroupModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$KeyTileDataGroupModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _KeyTileDataGroupModel &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality()
                .equals(other._keyTileData, _keyTileData));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, name, const DeepCollectionEquality().hash(_keyTileData));

  @override
  String toString() {
    return 'KeyTileDataGroupModel(name: $name, keyTileData: $keyTileData)';
  }
}

/// @nodoc
abstract mixin class _$KeyTileDataGroupModelCopyWith<$Res>
    implements $KeyTileDataGroupModelCopyWith<$Res> {
  factory _$KeyTileDataGroupModelCopyWith(_KeyTileDataGroupModel value,
          $Res Function(_KeyTileDataGroupModel) _then) =
      __$KeyTileDataGroupModelCopyWithImpl;
  @override
  @useResult
  $Res call({String name, List<KeyTileDataModel> keyTileData});
}

/// @nodoc
class __$KeyTileDataGroupModelCopyWithImpl<$Res>
    implements _$KeyTileDataGroupModelCopyWith<$Res> {
  __$KeyTileDataGroupModelCopyWithImpl(this._self, this._then);

  final _KeyTileDataGroupModel _self;
  final $Res Function(_KeyTileDataGroupModel) _then;

  /// Create a copy of KeyTileDataGroupModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? name = null,
    Object? keyTileData = null,
  }) {
    return _then(_KeyTileDataGroupModel(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      keyTileData: null == keyTileData
          ? _self._keyTileData
          : keyTileData // ignore: cast_nullable_to_non_nullable
              as List<KeyTileDataModel>,
    ));
  }
}

// dart format on
