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
  @override
  final bool isLocked;

  factory _$ChapterRef([void Function(ChapterRefBuilder) updates]) =>
      (new ChapterRefBuilder()..update(updates)).build();

  _$ChapterRef._({this.url, this.title, this.isLocked}) : super._() {
    if (url == null) {
      throw new BuiltValueNullFieldError('ChapterRef', 'url');
    }
    if (title == null) {
      throw new BuiltValueNullFieldError('ChapterRef', 'title');
    }
    if (isLocked == null) {
      throw new BuiltValueNullFieldError('ChapterRef', 'isLocked');
    }
  }

  @override
  ChapterRef rebuild(void Function(ChapterRefBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ChapterRefBuilder toBuilder() => new ChapterRefBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ChapterRef &&
        url == other.url &&
        title == other.title &&
        isLocked == other.isLocked;
  }

  @override
  int get hashCode {
    return $jf(
        $jc($jc($jc(0, url.hashCode), title.hashCode), isLocked.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ChapterRef')
          ..add('url', url)
          ..add('title', title)
          ..add('isLocked', isLocked))
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

  bool _isLocked;
  bool get isLocked => _$this._isLocked;
  set isLocked(bool isLocked) => _$this._isLocked = isLocked;

  ChapterRefBuilder();

  ChapterRefBuilder get _$this {
    if (_$v != null) {
      _url = _$v.url;
      _title = _$v.title;
      _isLocked = _$v.isLocked;
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
  void update(void Function(ChapterRefBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ChapterRef build() {
    final _$result =
        _$v ?? new _$ChapterRef._(url: url, title: title, isLocked: isLocked);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
