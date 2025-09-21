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
  List<PresetModel> get presetList;
  set presetList(List<PresetModel> value);
  String? get currentPresetName;
  set currentPresetName(String? value);
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
  dynamic get isWindowSizeLock;
  set isWindowSizeLock(dynamic value);
  bool get showDJMAXPreset;
  set showDJMAXPreset(bool value);
  bool get showCommon4KPreset;
  set showCommon4KPreset(bool value);
  bool get showCommon7KPreset;
  set showCommon7KPreset(bool value);
  bool get showMuseDashPreset;
  set showMuseDashPreset(bool value);
  bool get showSixtaGatePreset;
  set showSixtaGatePreset(bool value);

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
    return 'GlobalConfigModel(presetList: $presetList, currentPresetName: $currentPresetName, windowWidth: $windowWidth, windowHeight: $windowHeight, windowX: $windowX, windowY: $windowY, overlayWith: $overlayWith, overlayHeight: $overlayHeight, overlayX: $overlayX, overlayY: $overlayY, isWindowSizeLock: $isWindowSizeLock, showDJMAXPreset: $showDJMAXPreset, showCommon4KPreset: $showCommon4KPreset, showCommon7KPreset: $showCommon7KPreset, showMuseDashPreset: $showMuseDashPreset, showSixtaGatePreset: $showSixtaGatePreset)';
  }
}

/// @nodoc
abstract mixin class $GlobalConfigModelCopyWith<$Res> {
  factory $GlobalConfigModelCopyWith(
          GlobalConfigModel value, $Res Function(GlobalConfigModel) _then) =
      _$GlobalConfigModelCopyWithImpl;
  @useResult
  $Res call(
      {List<PresetModel> presetList,
      String? currentPresetName,
      double windowWidth,
      double windowHeight,
      double windowX,
      double windowY,
      double overlayWith,
      double overlayHeight,
      double overlayX,
      double overlayY,
      dynamic isWindowSizeLock,
      bool showDJMAXPreset,
      bool showCommon4KPreset,
      bool showCommon7KPreset,
      bool showMuseDashPreset,
      bool showSixtaGatePreset});
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
    Object? presetList = null,
    Object? currentPresetName = freezed,
    Object? windowWidth = null,
    Object? windowHeight = null,
    Object? windowX = null,
    Object? windowY = null,
    Object? overlayWith = null,
    Object? overlayHeight = null,
    Object? overlayX = null,
    Object? overlayY = null,
    Object? isWindowSizeLock = freezed,
    Object? showDJMAXPreset = null,
    Object? showCommon4KPreset = null,
    Object? showCommon7KPreset = null,
    Object? showMuseDashPreset = null,
    Object? showSixtaGatePreset = null,
  }) {
    return _then(_self.copyWith(
      presetList: null == presetList
          ? _self.presetList
          : presetList // ignore: cast_nullable_to_non_nullable
              as List<PresetModel>,
      currentPresetName: freezed == currentPresetName
          ? _self.currentPresetName
          : currentPresetName // ignore: cast_nullable_to_non_nullable
              as String?,
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
      isWindowSizeLock: freezed == isWindowSizeLock
          ? _self.isWindowSizeLock
          : isWindowSizeLock // ignore: cast_nullable_to_non_nullable
              as dynamic,
      showDJMAXPreset: null == showDJMAXPreset
          ? _self.showDJMAXPreset
          : showDJMAXPreset // ignore: cast_nullable_to_non_nullable
              as bool,
      showCommon4KPreset: null == showCommon4KPreset
          ? _self.showCommon4KPreset
          : showCommon4KPreset // ignore: cast_nullable_to_non_nullable
              as bool,
      showCommon7KPreset: null == showCommon7KPreset
          ? _self.showCommon7KPreset
          : showCommon7KPreset // ignore: cast_nullable_to_non_nullable
              as bool,
      showMuseDashPreset: null == showMuseDashPreset
          ? _self.showMuseDashPreset
          : showMuseDashPreset // ignore: cast_nullable_to_non_nullable
              as bool,
      showSixtaGatePreset: null == showSixtaGatePreset
          ? _self.showSixtaGatePreset
          : showSixtaGatePreset // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _GlobalConfigModel implements GlobalConfigModel {
  _GlobalConfigModel(
      {this.presetList = const [],
      this.currentPresetName,
      this.windowWidth = 600,
      this.windowHeight = 600,
      this.windowX = 0,
      this.windowY = 0,
      this.overlayWith = 600,
      this.overlayHeight = 600,
      this.overlayX = 0,
      this.overlayY = 0,
      this.isWindowSizeLock = 0,
      this.showDJMAXPreset = true,
      this.showCommon4KPreset = true,
      this.showCommon7KPreset = true,
      this.showMuseDashPreset = true,
      this.showSixtaGatePreset = true});
  factory _GlobalConfigModel.fromJson(Map<String, dynamic> json) =>
      _$GlobalConfigModelFromJson(json);

  @override
  @JsonKey()
  List<PresetModel> presetList;
  @override
  String? currentPresetName;
  @override
  @JsonKey()
  double windowWidth;
  @override
  @JsonKey()
  double windowHeight;
  @override
  @JsonKey()
  double windowX;
  @override
  @JsonKey()
  double windowY;
  @override
  @JsonKey()
  double overlayWith;
  @override
  @JsonKey()
  double overlayHeight;
  @override
  @JsonKey()
  double overlayX;
  @override
  @JsonKey()
  double overlayY;
  @override
  @JsonKey()
  dynamic isWindowSizeLock;
  @override
  @JsonKey()
  bool showDJMAXPreset;
  @override
  @JsonKey()
  bool showCommon4KPreset;
  @override
  @JsonKey()
  bool showCommon7KPreset;
  @override
  @JsonKey()
  bool showMuseDashPreset;
  @override
  @JsonKey()
  bool showSixtaGatePreset;

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
    return 'GlobalConfigModel(presetList: $presetList, currentPresetName: $currentPresetName, windowWidth: $windowWidth, windowHeight: $windowHeight, windowX: $windowX, windowY: $windowY, overlayWith: $overlayWith, overlayHeight: $overlayHeight, overlayX: $overlayX, overlayY: $overlayY, isWindowSizeLock: $isWindowSizeLock, showDJMAXPreset: $showDJMAXPreset, showCommon4KPreset: $showCommon4KPreset, showCommon7KPreset: $showCommon7KPreset, showMuseDashPreset: $showMuseDashPreset, showSixtaGatePreset: $showSixtaGatePreset)';
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
      {List<PresetModel> presetList,
      String? currentPresetName,
      double windowWidth,
      double windowHeight,
      double windowX,
      double windowY,
      double overlayWith,
      double overlayHeight,
      double overlayX,
      double overlayY,
      dynamic isWindowSizeLock,
      bool showDJMAXPreset,
      bool showCommon4KPreset,
      bool showCommon7KPreset,
      bool showMuseDashPreset,
      bool showSixtaGatePreset});
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
    Object? presetList = null,
    Object? currentPresetName = freezed,
    Object? windowWidth = null,
    Object? windowHeight = null,
    Object? windowX = null,
    Object? windowY = null,
    Object? overlayWith = null,
    Object? overlayHeight = null,
    Object? overlayX = null,
    Object? overlayY = null,
    Object? isWindowSizeLock = freezed,
    Object? showDJMAXPreset = null,
    Object? showCommon4KPreset = null,
    Object? showCommon7KPreset = null,
    Object? showMuseDashPreset = null,
    Object? showSixtaGatePreset = null,
  }) {
    return _then(_GlobalConfigModel(
      presetList: null == presetList
          ? _self.presetList
          : presetList // ignore: cast_nullable_to_non_nullable
              as List<PresetModel>,
      currentPresetName: freezed == currentPresetName
          ? _self.currentPresetName
          : currentPresetName // ignore: cast_nullable_to_non_nullable
              as String?,
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
      isWindowSizeLock: freezed == isWindowSizeLock
          ? _self.isWindowSizeLock
          : isWindowSizeLock // ignore: cast_nullable_to_non_nullable
              as dynamic,
      showDJMAXPreset: null == showDJMAXPreset
          ? _self.showDJMAXPreset
          : showDJMAXPreset // ignore: cast_nullable_to_non_nullable
              as bool,
      showCommon4KPreset: null == showCommon4KPreset
          ? _self.showCommon4KPreset
          : showCommon4KPreset // ignore: cast_nullable_to_non_nullable
              as bool,
      showCommon7KPreset: null == showCommon7KPreset
          ? _self.showCommon7KPreset
          : showCommon7KPreset // ignore: cast_nullable_to_non_nullable
              as bool,
      showMuseDashPreset: null == showMuseDashPreset
          ? _self.showMuseDashPreset
          : showMuseDashPreset // ignore: cast_nullable_to_non_nullable
              as bool,
      showSixtaGatePreset: null == showSixtaGatePreset
          ? _self.showSixtaGatePreset
          : showSixtaGatePreset // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
