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
      {@required ReadingColorPalette palette,
      @required ReadingSettings settings}) {
    return _AppTheme(
      palette: palette,
      settings: settings,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $AppTheme = _$AppThemeTearOff();

/// @nodoc
mixin _$AppTheme {
  ReadingColorPalette get palette;
  ReadingSettings get settings;

  $AppThemeCopyWith<AppTheme> get copyWith;
}

/// @nodoc
abstract class $AppThemeCopyWith<$Res> {
  factory $AppThemeCopyWith(AppTheme value, $Res Function(AppTheme) then) =
      _$AppThemeCopyWithImpl<$Res>;
  $Res call({ReadingColorPalette palette, ReadingSettings settings});

  $ReadingColorPaletteCopyWith<$Res> get palette;
  $ReadingSettingsCopyWith<$Res> get settings;
}

/// @nodoc
class _$AppThemeCopyWithImpl<$Res> implements $AppThemeCopyWith<$Res> {
  _$AppThemeCopyWithImpl(this._value, this._then);

  final AppTheme _value;
  // ignore: unused_field
  final $Res Function(AppTheme) _then;

  @override
  $Res call({
    Object palette = freezed,
    Object settings = freezed,
  }) {
    return _then(_value.copyWith(
      palette:
          palette == freezed ? _value.palette : palette as ReadingColorPalette,
      settings:
          settings == freezed ? _value.settings : settings as ReadingSettings,
    ));
  }

  @override
  $ReadingColorPaletteCopyWith<$Res> get palette {
    if (_value.palette == null) {
      return null;
    }
    return $ReadingColorPaletteCopyWith<$Res>(_value.palette, (value) {
      return _then(_value.copyWith(palette: value));
    });
  }

  @override
  $ReadingSettingsCopyWith<$Res> get settings {
    if (_value.settings == null) {
      return null;
    }
    return $ReadingSettingsCopyWith<$Res>(_value.settings, (value) {
      return _then(_value.copyWith(settings: value));
    });
  }
}

/// @nodoc
abstract class _$AppThemeCopyWith<$Res> implements $AppThemeCopyWith<$Res> {
  factory _$AppThemeCopyWith(_AppTheme value, $Res Function(_AppTheme) then) =
      __$AppThemeCopyWithImpl<$Res>;
  @override
  $Res call({ReadingColorPalette palette, ReadingSettings settings});

  @override
  $ReadingColorPaletteCopyWith<$Res> get palette;
  @override
  $ReadingSettingsCopyWith<$Res> get settings;
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
    Object palette = freezed,
    Object settings = freezed,
  }) {
    return _then(_AppTheme(
      palette:
          palette == freezed ? _value.palette : palette as ReadingColorPalette,
      settings:
          settings == freezed ? _value.settings : settings as ReadingSettings,
    ));
  }
}

/// @nodoc
class _$_AppTheme extends _AppTheme {
  _$_AppTheme({@required this.palette, @required this.settings})
      : assert(palette != null),
        assert(settings != null),
        super._();

  @override
  final ReadingColorPalette palette;
  @override
  final ReadingSettings settings;

  @override
  String toString() {
    return 'AppTheme(palette: $palette, settings: $settings)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _AppTheme &&
            (identical(other.palette, palette) ||
                const DeepCollectionEquality()
                    .equals(other.palette, palette)) &&
            (identical(other.settings, settings) ||
                const DeepCollectionEquality()
                    .equals(other.settings, settings)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(palette) ^
      const DeepCollectionEquality().hash(settings);

  @override
  _$AppThemeCopyWith<_AppTheme> get copyWith =>
      __$AppThemeCopyWithImpl<_AppTheme>(this, _$identity);
}

abstract class _AppTheme extends AppTheme {
  _AppTheme._() : super._();
  factory _AppTheme(
      {@required ReadingColorPalette palette,
      @required ReadingSettings settings}) = _$_AppTheme;

  @override
  ReadingColorPalette get palette;
  @override
  ReadingSettings get settings;
  @override
  _$AppThemeCopyWith<_AppTheme> get copyWith;
}
