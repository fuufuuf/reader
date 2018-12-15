// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ChapterContent.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ChapterContent extends ChapterContent {
  @override
  final Uri url;
  @override
  final String title;
  @override
  final BuiltList<String> paragraphs;
  @override
  final Uri chapterListUrl;
  @override
  final Uri nextChapterUrl;
  @override
  final Uri previousChapterUrl;

  factory _$ChapterContent([void updates(ChapterContentBuilder b)]) =>
      (new ChapterContentBuilder()..update(updates)).build();

  _$ChapterContent._(
      {this.url,
      this.title,
      this.paragraphs,
      this.chapterListUrl,
      this.nextChapterUrl,
      this.previousChapterUrl})
      : super._() {
    if (url == null) {
      throw new BuiltValueNullFieldError('ChapterContent', 'url');
    }
    if (title == null) {
      throw new BuiltValueNullFieldError('ChapterContent', 'title');
    }
    if (paragraphs == null) {
      throw new BuiltValueNullFieldError('ChapterContent', 'paragraphs');
    }
    if (chapterListUrl == null) {
      throw new BuiltValueNullFieldError('ChapterContent', 'chapterListUrl');
    }
  }

  @override
  ChapterContent rebuild(void updates(ChapterContentBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  ChapterContentBuilder toBuilder() =>
      new ChapterContentBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ChapterContent &&
        url == other.url &&
        title == other.title &&
        paragraphs == other.paragraphs &&
        chapterListUrl == other.chapterListUrl &&
        nextChapterUrl == other.nextChapterUrl &&
        previousChapterUrl == other.previousChapterUrl;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc($jc($jc(0, url.hashCode), title.hashCode),
                    paragraphs.hashCode),
                chapterListUrl.hashCode),
            nextChapterUrl.hashCode),
        previousChapterUrl.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ChapterContent')
          ..add('url', url)
          ..add('title', title)
          ..add('paragraphs', paragraphs)
          ..add('chapterListUrl', chapterListUrl)
          ..add('nextChapterUrl', nextChapterUrl)
          ..add('previousChapterUrl', previousChapterUrl))
        .toString();
  }
}

class ChapterContentBuilder
    implements Builder<ChapterContent, ChapterContentBuilder> {
  _$ChapterContent _$v;

  Uri _url;
  Uri get url => _$this._url;
  set url(Uri url) => _$this._url = url;

  String _title;
  String get title => _$this._title;
  set title(String title) => _$this._title = title;

  ListBuilder<String> _paragraphs;
  ListBuilder<String> get paragraphs =>
      _$this._paragraphs ??= new ListBuilder<String>();
  set paragraphs(ListBuilder<String> paragraphs) =>
      _$this._paragraphs = paragraphs;

  Uri _chapterListUrl;
  Uri get chapterListUrl => _$this._chapterListUrl;
  set chapterListUrl(Uri chapterListUrl) =>
      _$this._chapterListUrl = chapterListUrl;

  Uri _nextChapterUrl;
  Uri get nextChapterUrl => _$this._nextChapterUrl;
  set nextChapterUrl(Uri nextChapterUrl) =>
      _$this._nextChapterUrl = nextChapterUrl;

  Uri _previousChapterUrl;
  Uri get previousChapterUrl => _$this._previousChapterUrl;
  set previousChapterUrl(Uri previousChapterUrl) =>
      _$this._previousChapterUrl = previousChapterUrl;

  ChapterContentBuilder();

  ChapterContentBuilder get _$this {
    if (_$v != null) {
      _url = _$v.url;
      _title = _$v.title;
      _paragraphs = _$v.paragraphs?.toBuilder();
      _chapterListUrl = _$v.chapterListUrl;
      _nextChapterUrl = _$v.nextChapterUrl;
      _previousChapterUrl = _$v.previousChapterUrl;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ChapterContent other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ChapterContent;
  }

  @override
  void update(void updates(ChapterContentBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$ChapterContent build() {
    _$ChapterContent _$result;
    try {
      _$result = _$v ??
          new _$ChapterContent._(
              url: url,
              title: title,
              paragraphs: paragraphs.build(),
              chapterListUrl: chapterListUrl,
              nextChapterUrl: nextChapterUrl,
              previousChapterUrl: previousChapterUrl);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'paragraphs';
        paragraphs.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'ChapterContent', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
