// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'ReadingThemeData.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$ReadingThemeDataTearOff {
  const _$ReadingThemeDataTearOff();

// ignore: unused_element
  _ReadingThemeData call(
      {@required Color textColor,
      @required Color backgroundColor,
      double fontScaleFactor = 1.0,
      @required Color popUpTextColor,
      @required Color popUpBackgroundColor}) {
    return _ReadingThemeData(
      textColor: textColor,
      backgroundColor: backgroundColor,
      fontScaleFactor: fontScaleFactor,
      popUpTextColor: popUpTextColor,
      popUpBackgroundColor: popUpBackgroundColor,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $ReadingThemeData = _$ReadingThemeDataTearOff();

/// @nodoc
mixin _$ReadingThemeData {
  Color get textColor;
  Color get backgroundColor;
  double get fontScaleFactor;
  Color get popUpTextColor;
  Color get popUpBackgroundColor;

  $ReadingThemeDataCopyWith<ReadingThemeData> get copyWith;
}

/// @nodoc
abstract class $ReadingThemeDataCopyWith<$Res> {
  factory $ReadingThemeDataCopyWith(
          ReadingThemeData value, $Res Function(ReadingThemeData) then) =
      _$ReadingThemeDataCopyWithImpl<$Res>;
  $Res call(
      {Color textColor,
      Color backgroundColor,
      double fontScaleFactor,
      Color popUpTextColor,
      Color popUpBackgroundColor});
}

/// @nodoc
class _$ReadingThemeDataCopyWithImpl<$Res>
    implements $ReadingThemeDataCopyWith<$Res> {
  _$ReadingThemeDataCopyWithImpl(this._value, this._then);

  final ReadingThemeData _value;
  // ignore: unused_field
  final $Res Function(ReadingThemeData) _then;

  @override
  $Res call({
    Object textColor = freezed,
    Object backgroundColor = freezed,
    Object fontScaleFactor = freezed,
    Object popUpTextColor = freezed,
    Object popUpBackgroundColor = freezed,
  }) {
    return _then(_value.copyWith(
      textColor: textColor == freezed ? _value.textColor : textColor as Color,
      backgroundColor: backgroundColor == freezed
          ? _value.backgroundColor
          : backgroundColor as Color,
      fontScaleFactor: fontScaleFactor == freezed
          ? _value.fontScaleFactor
          : fontScaleFactor as double,
      popUpTextColor: popUpTextColor == freezed
          ? _value.popUpTextColor
          : popUpTextColor as Color,
      popUpBackgroundColor: popUpBackgroundColor == freezed
          ? _value.popUpBackgroundColor
          : popUpBackgroundColor as Color,
    ));
  }
}

/// @nodoc
abstract class _$ReadingThemeDataCopyWith<$Res>
    implements $ReadingThemeDataCopyWith<$Res> {
  factory _$ReadingThemeDataCopyWith(
          _ReadingThemeData value, $Res Function(_ReadingThemeData) then) =
      __$ReadingThemeDataCopyWithImpl<$Res>;
  @override
  $Res call(
      {Color textColor,
      Color backgroundColor,
      double fontScaleFactor,
      Color popUpTextColor,
      Color popUpBackgroundColor});
}

/// @nodoc
class __$ReadingThemeDataCopyWithImpl<$Res>
    extends _$ReadingThemeDataCopyWithImpl<$Res>
    implements _$ReadingThemeDataCopyWith<$Res> {
  __$ReadingThemeDataCopyWithImpl(
      _ReadingThemeData _value, $Res Function(_ReadingThemeData) _then)
      : super(_value, (v) => _then(v as _ReadingThemeData));

  @override
  _ReadingThemeData get _value => super._value as _ReadingThemeData;

  @override
  $Res call({
    Object textColor = freezed,
    Object backgroundColor = freezed,
    Object fontScaleFactor = freezed,
    Object popUpTextColor = freezed,
    Object popUpBackgroundColor = freezed,
  }) {
    return _then(_ReadingThemeData(
      textColor: textColor == freezed ? _value.textColor : textColor as Color,
      backgroundColor: backgroundColor == freezed
          ? _value.backgroundColor
          : backgroundColor as Color,
      fontScaleFactor: fontScaleFactor == freezed
          ? _value.fontScaleFactor
          : fontScaleFactor as double,
      popUpTextColor: popUpTextColor == freezed
          ? _value.popUpTextColor
          : popUpTextColor as Color,
      popUpBackgroundColor: popUpBackgroundColor == freezed
          ? _value.popUpBackgroundColor
          : popUpBackgroundColor as Color,
    ));
  }
}

/// @nodoc
class _$_ReadingThemeData implements _ReadingThemeData {
  _$_ReadingThemeData(
      {@required this.textColor,
      @required this.backgroundColor,
      this.fontScaleFactor = 1.0,
      @required this.popUpTextColor,
      @required this.popUpBackgroundColor})
      : assert(textColor != null),
        assert(backgroundColor != null),
        assert(fontScaleFactor != null),
        assert(popUpTextColor != null),
        assert(popUpBackgroundColor != null);

  @override
  final Color textColor;
  @override
  final Color backgroundColor;
  @JsonKey(defaultValue: 1.0)
  @override
  final double fontScaleFactor;
  @override
  final Color popUpTextColor;
  @override
  final Color popUpBackgroundColor;

  @override
  String toString() {
    return 'ReadingThemeData(textColor: $textColor, backgroundColor: $backgroundColor, fontScaleFactor: $fontScaleFactor, popUpTextColor: $popUpTextColor, popUpBackgroundColor: $popUpBackgroundColor)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ReadingThemeData &&
            (identical(other.textColor, textColor) ||
                const DeepCollectionEquality()
                    .equals(other.textColor, textColor)) &&
            (identical(other.backgroundColor, backgroundColor) ||
                const DeepCollectionEquality()
                    .equals(other.backgroundColor, backgroundColor)) &&
            (identical(other.fontScaleFactor, fontScaleFactor) ||
                const DeepCollectionEquality()
                    .equals(other.fontScaleFactor, fontScaleFactor)) &&
            (identical(other.popUpTextColor, popUpTextColor) ||
                const DeepCollectionEquality()
                    .equals(other.popUpTextColor, popUpTextColor)) &&
            (identical(other.popUpBackgroundColor, popUpBackgroundColor) ||
                const DeepCollectionEquality()
                    .equals(other.popUpBackgroundColor, popUpBackgroundColor)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(textColor) ^
      const DeepCollectionEquality().hash(backgroundColor) ^
      const DeepCollectionEquality().hash(fontScaleFactor) ^
      const DeepCollectionEquality().hash(popUpTextColor) ^
      const DeepCollectionEquality().hash(popUpBackgroundColor);

  @override
  _$ReadingThemeDataCopyWith<_ReadingThemeData> get copyWith =>
      __$ReadingThemeDataCopyWithImpl<_ReadingThemeData>(this, _$identity);
}

abstract class _ReadingThemeData implements ReadingThemeData {
  factory _ReadingThemeData(
      {@required Color textColor,
      @required Color backgroundColor,
      double fontScaleFactor,
      @required Color popUpTextColor,
      @required Color popUpBackgroundColor}) = _$_ReadingThemeData;

  @override
  Color get textColor;
  @override
  Color get backgroundColor;
  @override
  double get fontScaleFactor;
  @override
  Color get popUpTextColor;
  @override
  Color get popUpBackgroundColor;
  @override
  _$ReadingThemeDataCopyWith<_ReadingThemeData> get copyWith;
}
