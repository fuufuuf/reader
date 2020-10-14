// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'ReadingSettings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
ReadingSettings _$ReadingSettingsFromJson(Map<String, dynamic> json) {
  return _ReadingSettings.fromJson(json);
}

/// @nodoc
class _$ReadingSettingsTearOff {
  const _$ReadingSettingsTearOff();

// ignore: unused_element
  _ReadingSettings call(
      {double readingTextScaleFactor = 1.0,
      double readingLineSpaceScaleFactor = 1.0,
      @nullable int lightContentForegroundColorIndex,
      @nullable int darkContentForegroundColorIndex}) {
    return _ReadingSettings(
      readingTextScaleFactor: readingTextScaleFactor,
      readingLineSpaceScaleFactor: readingLineSpaceScaleFactor,
      lightContentForegroundColorIndex: lightContentForegroundColorIndex,
      darkContentForegroundColorIndex: darkContentForegroundColorIndex,
    );
  }

// ignore: unused_element
  ReadingSettings fromJson(Map<String, Object> json) {
    return ReadingSettings.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $ReadingSettings = _$ReadingSettingsTearOff();

/// @nodoc
mixin _$ReadingSettings {
  double get readingTextScaleFactor;
  double get readingLineSpaceScaleFactor;
  @nullable
  int get lightContentForegroundColorIndex;
  @nullable
  int get darkContentForegroundColorIndex;

  Map<String, dynamic> toJson();
  $ReadingSettingsCopyWith<ReadingSettings> get copyWith;
}

/// @nodoc
abstract class $ReadingSettingsCopyWith<$Res> {
  factory $ReadingSettingsCopyWith(
          ReadingSettings value, $Res Function(ReadingSettings) then) =
      _$ReadingSettingsCopyWithImpl<$Res>;
  $Res call(
      {double readingTextScaleFactor,
      double readingLineSpaceScaleFactor,
      @nullable int lightContentForegroundColorIndex,
      @nullable int darkContentForegroundColorIndex});
}

/// @nodoc
class _$ReadingSettingsCopyWithImpl<$Res>
    implements $ReadingSettingsCopyWith<$Res> {
  _$ReadingSettingsCopyWithImpl(this._value, this._then);

  final ReadingSettings _value;
  // ignore: unused_field
  final $Res Function(ReadingSettings) _then;

  @override
  $Res call({
    Object readingTextScaleFactor = freezed,
    Object readingLineSpaceScaleFactor = freezed,
    Object lightContentForegroundColorIndex = freezed,
    Object darkContentForegroundColorIndex = freezed,
  }) {
    return _then(_value.copyWith(
      readingTextScaleFactor: readingTextScaleFactor == freezed
          ? _value.readingTextScaleFactor
          : readingTextScaleFactor as double,
      readingLineSpaceScaleFactor: readingLineSpaceScaleFactor == freezed
          ? _value.readingLineSpaceScaleFactor
          : readingLineSpaceScaleFactor as double,
      lightContentForegroundColorIndex:
          lightContentForegroundColorIndex == freezed
              ? _value.lightContentForegroundColorIndex
              : lightContentForegroundColorIndex as int,
      darkContentForegroundColorIndex:
          darkContentForegroundColorIndex == freezed
              ? _value.darkContentForegroundColorIndex
              : darkContentForegroundColorIndex as int,
    ));
  }
}

/// @nodoc
abstract class _$ReadingSettingsCopyWith<$Res>
    implements $ReadingSettingsCopyWith<$Res> {
  factory _$ReadingSettingsCopyWith(
          _ReadingSettings value, $Res Function(_ReadingSettings) then) =
      __$ReadingSettingsCopyWithImpl<$Res>;
  @override
  $Res call(
      {double readingTextScaleFactor,
      double readingLineSpaceScaleFactor,
      @nullable int lightContentForegroundColorIndex,
      @nullable int darkContentForegroundColorIndex});
}

/// @nodoc
class __$ReadingSettingsCopyWithImpl<$Res>
    extends _$ReadingSettingsCopyWithImpl<$Res>
    implements _$ReadingSettingsCopyWith<$Res> {
  __$ReadingSettingsCopyWithImpl(
      _ReadingSettings _value, $Res Function(_ReadingSettings) _then)
      : super(_value, (v) => _then(v as _ReadingSettings));

  @override
  _ReadingSettings get _value => super._value as _ReadingSettings;

  @override
  $Res call({
    Object readingTextScaleFactor = freezed,
    Object readingLineSpaceScaleFactor = freezed,
    Object lightContentForegroundColorIndex = freezed,
    Object darkContentForegroundColorIndex = freezed,
  }) {
    return _then(_ReadingSettings(
      readingTextScaleFactor: readingTextScaleFactor == freezed
          ? _value.readingTextScaleFactor
          : readingTextScaleFactor as double,
      readingLineSpaceScaleFactor: readingLineSpaceScaleFactor == freezed
          ? _value.readingLineSpaceScaleFactor
          : readingLineSpaceScaleFactor as double,
      lightContentForegroundColorIndex:
          lightContentForegroundColorIndex == freezed
              ? _value.lightContentForegroundColorIndex
              : lightContentForegroundColorIndex as int,
      darkContentForegroundColorIndex:
          darkContentForegroundColorIndex == freezed
              ? _value.darkContentForegroundColorIndex
              : darkContentForegroundColorIndex as int,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_ReadingSettings implements _ReadingSettings {
  _$_ReadingSettings(
      {this.readingTextScaleFactor = 1.0,
      this.readingLineSpaceScaleFactor = 1.0,
      @nullable this.lightContentForegroundColorIndex,
      @nullable this.darkContentForegroundColorIndex})
      : assert(readingTextScaleFactor != null),
        assert(readingLineSpaceScaleFactor != null);

  factory _$_ReadingSettings.fromJson(Map<String, dynamic> json) =>
      _$_$_ReadingSettingsFromJson(json);

  @JsonKey(defaultValue: 1.0)
  @override
  final double readingTextScaleFactor;
  @JsonKey(defaultValue: 1.0)
  @override
  final double readingLineSpaceScaleFactor;
  @override
  @nullable
  final int lightContentForegroundColorIndex;
  @override
  @nullable
  final int darkContentForegroundColorIndex;

  @override
  String toString() {
    return 'ReadingSettings(readingTextScaleFactor: $readingTextScaleFactor, readingLineSpaceScaleFactor: $readingLineSpaceScaleFactor, lightContentForegroundColorIndex: $lightContentForegroundColorIndex, darkContentForegroundColorIndex: $darkContentForegroundColorIndex)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ReadingSettings &&
            (identical(other.readingTextScaleFactor, readingTextScaleFactor) ||
                const DeepCollectionEquality().equals(
                    other.readingTextScaleFactor, readingTextScaleFactor)) &&
            (identical(other.readingLineSpaceScaleFactor,
                    readingLineSpaceScaleFactor) ||
                const DeepCollectionEquality().equals(
                    other.readingLineSpaceScaleFactor,
                    readingLineSpaceScaleFactor)) &&
            (identical(other.lightContentForegroundColorIndex,
                    lightContentForegroundColorIndex) ||
                const DeepCollectionEquality().equals(
                    other.lightContentForegroundColorIndex,
                    lightContentForegroundColorIndex)) &&
            (identical(other.darkContentForegroundColorIndex,
                    darkContentForegroundColorIndex) ||
                const DeepCollectionEquality().equals(
                    other.darkContentForegroundColorIndex,
                    darkContentForegroundColorIndex)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(readingTextScaleFactor) ^
      const DeepCollectionEquality().hash(readingLineSpaceScaleFactor) ^
      const DeepCollectionEquality().hash(lightContentForegroundColorIndex) ^
      const DeepCollectionEquality().hash(darkContentForegroundColorIndex);

  @override
  _$ReadingSettingsCopyWith<_ReadingSettings> get copyWith =>
      __$ReadingSettingsCopyWithImpl<_ReadingSettings>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_ReadingSettingsToJson(this);
  }
}

abstract class _ReadingSettings implements ReadingSettings {
  factory _ReadingSettings(
      {double readingTextScaleFactor,
      double readingLineSpaceScaleFactor,
      @nullable int lightContentForegroundColorIndex,
      @nullable int darkContentForegroundColorIndex}) = _$_ReadingSettings;

  factory _ReadingSettings.fromJson(Map<String, dynamic> json) =
      _$_ReadingSettings.fromJson;

  @override
  double get readingTextScaleFactor;
  @override
  double get readingLineSpaceScaleFactor;
  @override
  @nullable
  int get lightContentForegroundColorIndex;
  @override
  @nullable
  int get darkContentForegroundColorIndex;
  @override
  _$ReadingSettingsCopyWith<_ReadingSettings> get copyWith;
}
