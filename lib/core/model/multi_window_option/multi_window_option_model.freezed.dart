// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'multi_window_option_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MultiWindowOptionModel {
  String get windowName;
  double? get windowWidth;
  double? get windowHeight;
  double? get windowX;
  double? get windowY;
  bool? get isFrameless;
  int? get backgroundColor;

  /// Create a copy of MultiWindowOptionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MultiWindowOptionModelCopyWith<MultiWindowOptionModel> get copyWith =>
      _$MultiWindowOptionModelCopyWithImpl<MultiWindowOptionModel>(
          this as MultiWindowOptionModel, _$identity);

  /// Serializes this MultiWindowOptionModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MultiWindowOptionModel &&
            (identical(other.windowName, windowName) ||
                other.windowName == windowName) &&
            (identical(other.windowWidth, windowWidth) ||
                other.windowWidth == windowWidth) &&
            (identical(other.windowHeight, windowHeight) ||
                other.windowHeight == windowHeight) &&
            (identical(other.windowX, windowX) || other.windowX == windowX) &&
            (identical(other.windowY, windowY) || other.windowY == windowY) &&
            (identical(other.isFrameless, isFrameless) ||
                other.isFrameless == isFrameless) &&
            (identical(other.backgroundColor, backgroundColor) ||
                other.backgroundColor == backgroundColor));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, windowName, windowWidth,
      windowHeight, windowX, windowY, isFrameless, backgroundColor);

  @override
  String toString() {
    return 'MultiWindowOptionModel(windowName: $windowName, windowWidth: $windowWidth, windowHeight: $windowHeight, windowX: $windowX, windowY: $windowY, isFrameless: $isFrameless, backgroundColor: $backgroundColor)';
  }
}

/// @nodoc
abstract mixin class $MultiWindowOptionModelCopyWith<$Res> {
  factory $MultiWindowOptionModelCopyWith(MultiWindowOptionModel value,
          $Res Function(MultiWindowOptionModel) _then) =
      _$MultiWindowOptionModelCopyWithImpl;
  @useResult
  $Res call(
      {String windowName,
      double? windowWidth,
      double? windowHeight,
      double? windowX,
      double? windowY,
      bool? isFrameless,
      int? backgroundColor});
}

/// @nodoc
class _$MultiWindowOptionModelCopyWithImpl<$Res>
    implements $MultiWindowOptionModelCopyWith<$Res> {
  _$MultiWindowOptionModelCopyWithImpl(this._self, this._then);

  final MultiWindowOptionModel _self;
  final $Res Function(MultiWindowOptionModel) _then;

  /// Create a copy of MultiWindowOptionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? windowName = null,
    Object? windowWidth = freezed,
    Object? windowHeight = freezed,
    Object? windowX = freezed,
    Object? windowY = freezed,
    Object? isFrameless = freezed,
    Object? backgroundColor = freezed,
  }) {
    return _then(_self.copyWith(
      windowName: null == windowName
          ? _self.windowName
          : windowName // ignore: cast_nullable_to_non_nullable
              as String,
      windowWidth: freezed == windowWidth
          ? _self.windowWidth
          : windowWidth // ignore: cast_nullable_to_non_nullable
              as double?,
      windowHeight: freezed == windowHeight
          ? _self.windowHeight
          : windowHeight // ignore: cast_nullable_to_non_nullable
              as double?,
      windowX: freezed == windowX
          ? _self.windowX
          : windowX // ignore: cast_nullable_to_non_nullable
              as double?,
      windowY: freezed == windowY
          ? _self.windowY
          : windowY // ignore: cast_nullable_to_non_nullable
              as double?,
      isFrameless: freezed == isFrameless
          ? _self.isFrameless
          : isFrameless // ignore: cast_nullable_to_non_nullable
              as bool?,
      backgroundColor: freezed == backgroundColor
          ? _self.backgroundColor
          : backgroundColor // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _MultiWindowOptionModel implements MultiWindowOptionModel {
  const _MultiWindowOptionModel(
      {required this.windowName,
      this.windowWidth,
      this.windowHeight,
      this.windowX,
      this.windowY,
      this.isFrameless,
      this.backgroundColor});
  factory _MultiWindowOptionModel.fromJson(Map<String, dynamic> json) =>
      _$MultiWindowOptionModelFromJson(json);

  @override
  final String windowName;
  @override
  final double? windowWidth;
  @override
  final double? windowHeight;
  @override
  final double? windowX;
  @override
  final double? windowY;
  @override
  final bool? isFrameless;
  @override
  final int? backgroundColor;

  /// Create a copy of MultiWindowOptionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MultiWindowOptionModelCopyWith<_MultiWindowOptionModel> get copyWith =>
      __$MultiWindowOptionModelCopyWithImpl<_MultiWindowOptionModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$MultiWindowOptionModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MultiWindowOptionModel &&
            (identical(other.windowName, windowName) ||
                other.windowName == windowName) &&
            (identical(other.windowWidth, windowWidth) ||
                other.windowWidth == windowWidth) &&
            (identical(other.windowHeight, windowHeight) ||
                other.windowHeight == windowHeight) &&
            (identical(other.windowX, windowX) || other.windowX == windowX) &&
            (identical(other.windowY, windowY) || other.windowY == windowY) &&
            (identical(other.isFrameless, isFrameless) ||
                other.isFrameless == isFrameless) &&
            (identical(other.backgroundColor, backgroundColor) ||
                other.backgroundColor == backgroundColor));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, windowName, windowWidth,
      windowHeight, windowX, windowY, isFrameless, backgroundColor);

  @override
  String toString() {
    return 'MultiWindowOptionModel(windowName: $windowName, windowWidth: $windowWidth, windowHeight: $windowHeight, windowX: $windowX, windowY: $windowY, isFrameless: $isFrameless, backgroundColor: $backgroundColor)';
  }
}

/// @nodoc
abstract mixin class _$MultiWindowOptionModelCopyWith<$Res>
    implements $MultiWindowOptionModelCopyWith<$Res> {
  factory _$MultiWindowOptionModelCopyWith(_MultiWindowOptionModel value,
          $Res Function(_MultiWindowOptionModel) _then) =
      __$MultiWindowOptionModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String windowName,
      double? windowWidth,
      double? windowHeight,
      double? windowX,
      double? windowY,
      bool? isFrameless,
      int? backgroundColor});
}

/// @nodoc
class __$MultiWindowOptionModelCopyWithImpl<$Res>
    implements _$MultiWindowOptionModelCopyWith<$Res> {
  __$MultiWindowOptionModelCopyWithImpl(this._self, this._then);

  final _MultiWindowOptionModel _self;
  final $Res Function(_MultiWindowOptionModel) _then;

  /// Create a copy of MultiWindowOptionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? windowName = null,
    Object? windowWidth = freezed,
    Object? windowHeight = freezed,
    Object? windowX = freezed,
    Object? windowY = freezed,
    Object? isFrameless = freezed,
    Object? backgroundColor = freezed,
  }) {
    return _then(_MultiWindowOptionModel(
      windowName: null == windowName
          ? _self.windowName
          : windowName // ignore: cast_nullable_to_non_nullable
              as String,
      windowWidth: freezed == windowWidth
          ? _self.windowWidth
          : windowWidth // ignore: cast_nullable_to_non_nullable
              as double?,
      windowHeight: freezed == windowHeight
          ? _self.windowHeight
          : windowHeight // ignore: cast_nullable_to_non_nullable
              as double?,
      windowX: freezed == windowX
          ? _self.windowX
          : windowX // ignore: cast_nullable_to_non_nullable
              as double?,
      windowY: freezed == windowY
          ? _self.windowY
          : windowY // ignore: cast_nullable_to_non_nullable
              as double?,
      isFrameless: freezed == isFrameless
          ? _self.isFrameless
          : isFrameless // ignore: cast_nullable_to_non_nullable
              as bool?,
      backgroundColor: freezed == backgroundColor
          ? _self.backgroundColor
          : backgroundColor // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

// dart format on
