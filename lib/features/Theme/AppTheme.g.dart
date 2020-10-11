// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AppTheme.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AppTheme extends AppTheme {
  @override
  final ReadingThemeData readingThemeData;
  @override
  final Brightness brightness;

  factory _$AppTheme([void Function(AppThemeBuilder) updates]) =>
      (new AppThemeBuilder()..update(updates)).build();

  _$AppTheme._({this.readingThemeData, this.brightness}) : super._() {
    if (readingThemeData == null) {
      throw new BuiltValueNullFieldError('AppTheme', 'readingThemeData');
    }
    if (brightness == null) {
      throw new BuiltValueNullFieldError('AppTheme', 'brightness');
    }
  }

  @override
  AppTheme rebuild(void Function(AppThemeBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AppThemeBuilder toBuilder() => new AppThemeBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AppTheme &&
        readingThemeData == other.readingThemeData &&
        brightness == other.brightness;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, readingThemeData.hashCode), brightness.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('AppTheme')
          ..add('readingThemeData', readingThemeData)
          ..add('brightness', brightness))
        .toString();
  }
}

class AppThemeBuilder implements Builder<AppTheme, AppThemeBuilder> {
  _$AppTheme _$v;

  ReadingThemeDataBuilder _readingThemeData;
  ReadingThemeDataBuilder get readingThemeData =>
      _$this._readingThemeData ??= new ReadingThemeDataBuilder();
  set readingThemeData(ReadingThemeDataBuilder readingThemeData) =>
      _$this._readingThemeData = readingThemeData;

  Brightness _brightness;
  Brightness get brightness => _$this._brightness;
  set brightness(Brightness brightness) => _$this._brightness = brightness;

  AppThemeBuilder();

  AppThemeBuilder get _$this {
    if (_$v != null) {
      _readingThemeData = _$v.readingThemeData?.toBuilder();
      _brightness = _$v.brightness;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AppTheme other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$AppTheme;
  }

  @override
  void update(void Function(AppThemeBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$AppTheme build() {
    _$AppTheme _$result;
    try {
      _$result = _$v ??
          new _$AppTheme._(
              readingThemeData: readingThemeData.build(),
              brightness: brightness);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'readingThemeData';
        readingThemeData.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'AppTheme', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
