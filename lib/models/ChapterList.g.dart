// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ChapterList.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ChapterList extends ChapterList {
  @override
  final Uri url;
  @override
  final String title;
  @override
  final BuiltList<ChapterRef> chapters;
  @override
  final Uri bookUrl;

  factory _$ChapterList([void updates(ChapterListBuilder b)]) =>
      (new ChapterListBuilder()..update(updates)).build();

  _$ChapterList._({this.url, this.title, this.chapters, this.bookUrl})
      : super._() {
    if (url == null) {
      throw new BuiltValueNullFieldError('ChapterList', 'url');
    }
    if (title == null) {
      throw new BuiltValueNullFieldError('ChapterList', 'title');
    }
    if (chapters == null) {
      throw new BuiltValueNullFieldError('ChapterList', 'chapters');
    }
    if (bookUrl == null) {
      throw new BuiltValueNullFieldError('ChapterList', 'bookUrl');
    }
  }

  @override
  ChapterList rebuild(void updates(ChapterListBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  ChapterListBuilder toBuilder() => new ChapterListBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ChapterList &&
        url == other.url &&
        title == other.title &&
        chapters == other.chapters &&
        bookUrl == other.bookUrl;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, url.hashCode), title.hashCode), chapters.hashCode),
        bookUrl.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ChapterList')
          ..add('url', url)
          ..add('title', title)
          ..add('chapters', chapters)
          ..add('bookUrl', bookUrl))
        .toString();
  }
}

class ChapterListBuilder implements Builder<ChapterList, ChapterListBuilder> {
  _$ChapterList _$v;

  Uri _url;
  Uri get url => _$this._url;
  set url(Uri url) => _$this._url = url;

  String _title;
  String get title => _$this._title;
  set title(String title) => _$this._title = title;

  ListBuilder<ChapterRef> _chapters;
  ListBuilder<ChapterRef> get chapters =>
      _$this._chapters ??= new ListBuilder<ChapterRef>();
  set chapters(ListBuilder<ChapterRef> chapters) => _$this._chapters = chapters;

  Uri _bookUrl;
  Uri get bookUrl => _$this._bookUrl;
  set bookUrl(Uri bookUrl) => _$this._bookUrl = bookUrl;

  ChapterListBuilder();

  ChapterListBuilder get _$this {
    if (_$v != null) {
      _url = _$v.url;
      _title = _$v.title;
      _chapters = _$v.chapters?.toBuilder();
      _bookUrl = _$v.bookUrl;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ChapterList other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ChapterList;
  }

  @override
  void update(void updates(ChapterListBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$ChapterList build() {
    _$ChapterList _$result;
    try {
      _$result = _$v ??
          new _$ChapterList._(
              url: url,
              title: title,
              chapters: chapters.build(),
              bookUrl: bookUrl);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'chapters';
        chapters.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'ChapterList', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
