// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ReadingThemeData.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ReadingThemeData extends ReadingThemeData {
  @override
  final Color textColor;
  @override
  final Color backgroundColor;
  @override
  final double fontScaleFactor;
  @override
  final Color popUpBackgroundColor;
  @override
  final Color popUpTextColor;

  factory _$ReadingThemeData(
          [void Function(ReadingThemeDataBuilder) updates]) =>
      (new ReadingThemeDataBuilder()..update(updates)).build();

  _$ReadingThemeData._(
      {this.textColor,
      this.backgroundColor,
      this.fontScaleFactor,
      this.popUpBackgroundColor,
      this.popUpTextColor})
      : super._() {
    if (textColor == null) {
      throw new BuiltValueNullFieldError('ReadingThemeData', 'textColor');
    }
    if (backgroundColor == null) {
      throw new BuiltValueNullFieldError('ReadingThemeData', 'backgroundColor');
    }
    if (fontScaleFactor == null) {
      throw new BuiltValueNullFieldError('ReadingThemeData', 'fontScaleFactor');
    }
    if (popUpBackgroundColor == null) {
      throw new BuiltValueNullFieldError(
          'ReadingThemeData', 'popUpBackgroundColor');
    }
    if (popUpTextColor == null) {
      throw new BuiltValueNullFieldError('ReadingThemeData', 'popUpTextColor');
    }
  }

  @override
  ReadingThemeData rebuild(void Function(ReadingThemeDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ReadingThemeDataBuilder toBuilder() =>
      new ReadingThemeDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ReadingThemeData &&
        textColor == other.textColor &&
        backgroundColor == other.backgroundColor &&
        fontScaleFactor == other.fontScaleFactor &&
        popUpBackgroundColor == other.popUpBackgroundColor &&
        popUpTextColor == other.popUpTextColor;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc(0, textColor.hashCode), backgroundColor.hashCode),
                fontScaleFactor.hashCode),
            popUpBackgroundColor.hashCode),
        popUpTextColor.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ReadingThemeData')
          ..add('textColor', textColor)
          ..add('backgroundColor', backgroundColor)
          ..add('fontScaleFactor', fontScaleFactor)
          ..add('popUpBackgroundColor', popUpBackgroundColor)
          ..add('popUpTextColor', popUpTextColor))
        .toString();
  }
}

class ReadingThemeDataBuilder
    implements Builder<ReadingThemeData, ReadingThemeDataBuilder> {
  _$ReadingThemeData _$v;

  Color _textColor;
  Color get textColor => _$this._textColor;
  set textColor(Color textColor) => _$this._textColor = textColor;

  Color _backgroundColor;
  Color get backgroundColor => _$this._backgroundColor;
  set backgroundColor(Color backgroundColor) =>
      _$this._backgroundColor = backgroundColor;

  double _fontScaleFactor;
  double get fontScaleFactor => _$this._fontScaleFactor;
  set fontScaleFactor(double fontScaleFactor) =>
      _$this._fontScaleFactor = fontScaleFactor;

  Color _popUpBackgroundColor;
  Color get popUpBackgroundColor => _$this._popUpBackgroundColor;
  set popUpBackgroundColor(Color popUpBackgroundColor) =>
      _$this._popUpBackgroundColor = popUpBackgroundColor;

  Color _popUpTextColor;
  Color get popUpTextColor => _$this._popUpTextColor;
  set popUpTextColor(Color popUpTextColor) =>
      _$this._popUpTextColor = popUpTextColor;

  ReadingThemeDataBuilder();

  ReadingThemeDataBuilder get _$this {
    if (_$v != null) {
      _textColor = _$v.textColor;
      _backgroundColor = _$v.backgroundColor;
      _fontScaleFactor = _$v.fontScaleFactor;
      _popUpBackgroundColor = _$v.popUpBackgroundColor;
      _popUpTextColor = _$v.popUpTextColor;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ReadingThemeData other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ReadingThemeData;
  }

  @override
  void update(void Function(ReadingThemeDataBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ReadingThemeData build() {
    final _$result = _$v ??
        new _$ReadingThemeData._(
            textColor: textColor,
            backgroundColor: backgroundColor,
            fontScaleFactor: fontScaleFactor,
            popUpBackgroundColor: popUpBackgroundColor,
            popUpTextColor: popUpTextColor);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
