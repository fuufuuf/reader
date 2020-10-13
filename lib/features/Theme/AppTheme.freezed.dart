// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'AppTheme.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$AppThemeTearOff {
  const _$AppThemeTearOff();

// ignore: unused_element
  _AppTheme call(
      {@required Brightness brightness,
      @required Duration transitionDuration,
      @required ReadingThemeData readingThemeData}) {
    return _AppTheme(
      brightness: brightness,
      transitionDuration: transitionDuration,
      readingThemeData: readingThemeData,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $AppTheme = _$AppThemeTearOff();

/// @nodoc
mixin _$AppTheme {
  Brightness get brightness;
  Duration get transitionDuration;
  ReadingThemeData get readingThemeData;

  $AppThemeCopyWith<AppTheme> get copyWith;
}

/// @nodoc
abstract class $AppThemeCopyWith<$Res> {
  factory $AppThemeCopyWith(AppTheme value, $Res Function(AppTheme) then) =
      _$AppThemeCopyWithImpl<$Res>;
  $Res call(
      {Brightness brightness,
      Duration transitionDuration,
      ReadingThemeData readingThemeData});

  $ReadingThemeDataCopyWith<$Res> get readingThemeData;
}

/// @nodoc
class _$AppThemeCopyWithImpl<$Res> implements $AppThemeCopyWith<$Res> {
  _$AppThemeCopyWithImpl(this._value, this._then);

  final AppTheme _value;
  // ignore: unused_field
  final $Res Function(AppTheme) _then;

  @override
  $Res call({
    Object brightness = freezed,
    Object transitionDuration = freezed,
    Object readingThemeData = freezed,
  }) {
    return _then(_value.copyWith(
      brightness:
          brightness == freezed ? _value.brightness : brightness as Brightness,
      transitionDuration: transitionDuration == freezed
          ? _value.transitionDuration
          : transitionDuration as Duration,
      readingThemeData: readingThemeData == freezed
          ? _value.readingThemeData
          : readingThemeData as ReadingThemeData,
    ));
  }

  @override
  $ReadingThemeDataCopyWith<$Res> get readingThemeData {
    if (_value.readingThemeData == null) {
      return null;
    }
    return $ReadingThemeDataCopyWith<$Res>(_value.readingThemeData, (value) {
      return _then(_value.copyWith(readingThemeData: value));
    });
  }
}

/// @nodoc
abstract class _$AppThemeCopyWith<$Res> implements $AppThemeCopyWith<$Res> {
  factory _$AppThemeCopyWith(_AppTheme value, $Res Function(_AppTheme) then) =
      __$AppThemeCopyWithImpl<$Res>;
  @override
  $Res call(
      {Brightness brightness,
      Duration transitionDuration,
      ReadingThemeData readingThemeData});

  @override
  $ReadingThemeDataCopyWith<$Res> get readingThemeData;
}

/// @nodoc
class __$AppThemeCopyWithImpl<$Res> extends _$AppThemeCopyWithImpl<$Res>
    implements _$AppThemeCopyWith<$Res> {
  __$AppThemeCopyWithImpl(_AppTheme _value, $Res Function(_AppTheme) _then)
      : super(_value, (v) => _then(v as _AppTheme));

  @override
  _AppTheme get _value => super._value as _AppTheme;

  @override
  $Res call({
    Object brightness = freezed,
    Object transitionDuration = freezed,
    Object readingThemeData = freezed,
  }) {
    return _then(_AppTheme(
      brightness:
          brightness == freezed ? _value.brightness : brightness as Brightness,
      transitionDuration: transitionDuration == freezed
          ? _value.transitionDuration
          : transitionDuration as Duration,
      readingThemeData: readingThemeData == freezed
          ? _value.readingThemeData
          : readingThemeData as ReadingThemeData,
    ));
  }
}

/// @nodoc
class _$_AppTheme implements _AppTheme {
  _$_AppTheme(
      {@required this.brightness,
      @required this.transitionDuration,
      @required this.readingThemeData})
      : assert(brightness != null),
        assert(transitionDuration != null),
        assert(readingThemeData != null);

  @override
  final Brightness brightness;
  @override
  final Duration transitionDuration;
  @override
  final ReadingThemeData readingThemeData;

  @override
  String toString() {
    return 'AppTheme(brightness: $brightness, transitionDuration: $transitionDuration, readingThemeData: $readingThemeData)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _AppTheme &&
            (identical(other.brightness, brightness) ||
                const DeepCollectionEquality()
                    .equals(other.brightness, brightness)) &&
            (identical(other.transitionDuration, transitionDuration) ||
                const DeepCollectionEquality()
                    .equals(other.transitionDuration, transitionDuration)) &&
            (identical(other.readingThemeData, readingThemeData) ||
                const DeepCollectionEquality()
                    .equals(other.readingThemeData, readingThemeData)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(brightness) ^
      const DeepCollectionEquality().hash(transitionDuration) ^
      const DeepCollectionEquality().hash(readingThemeData);

  @override
  _$AppThemeCopyWith<_AppTheme> get copyWith =>
      __$AppThemeCopyWithImpl<_AppTheme>(this, _$identity);
}

abstract class _AppTheme implements AppTheme {
  factory _AppTheme(
      {@required Brightness brightness,
      @required Duration transitionDuration,
      @required ReadingThemeData readingThemeData}) = _$_AppTheme;

  @override
  Brightness get brightness;
  @override
  Duration get transitionDuration;
  @override
  ReadingThemeData get readingThemeData;
  @override
  _$AppThemeCopyWith<_AppTheme> get copyWith;
}
