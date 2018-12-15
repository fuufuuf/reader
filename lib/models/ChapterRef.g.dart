// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ChapterRef.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ChapterRef extends ChapterRef {
  @override
  final Uri url;
  @override
  final String title;

  factory _$ChapterRef([void updates(ChapterRefBuilder b)]) =>
      (new ChapterRefBuilder()..update(updates)).build();

  _$ChapterRef._({this.url, this.title}) : super._() {
    if (url == null) {
      throw new BuiltValueNullFieldError('ChapterRef', 'url');
    }
    if (title == null) {
      throw new BuiltValueNullFieldError('ChapterRef', 'title');
    }
  }

  @override
  ChapterRef rebuild(void updates(ChapterRefBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  ChapterRefBuilder toBuilder() => new ChapterRefBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ChapterRef && url == other.url && title == other.title;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, url.hashCode), title.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ChapterRef')
          ..add('url', url)
          ..add('title', title))
        .toString();
  }
}

class ChapterRefBuilder implements Builder<ChapterRef, ChapterRefBuilder> {
  _$ChapterRef _$v;

  Uri _url;
  Uri get url => _$this._url;
  set url(Uri url) => _$this._url = url;

  String _title;
  String get title => _$this._title;
  set title(String title) => _$this._title = title;

  ChapterRefBuilder();

  ChapterRefBuilder get _$this {
    if (_$v != null) {
      _url = _$v.url;
      _title = _$v.title;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ChapterRef other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ChapterRef;
  }

  @override
  void update(void updates(ChapterRefBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$ChapterRef build() {
    final _$result = _$v ?? new _$ChapterRef._(url: url, title: title);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
