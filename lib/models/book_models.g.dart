// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_models.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BookIndex extends BookIndex {
  @override
  final String id;
  @override
  final String title;
  @override
  final Uri chapterListUrl;
  @override
  final Uri bookInfoUrl;

  factory _$BookIndex([void Function(BookIndexBuilder) updates]) =>
      (new BookIndexBuilder()..update(updates)).build();

  _$BookIndex._({this.id, this.title, this.chapterListUrl, this.bookInfoUrl})
      : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('BookIndex', 'id');
    }
    if (title == null) {
      throw new BuiltValueNullFieldError('BookIndex', 'title');
    }
    if (chapterListUrl == null) {
      throw new BuiltValueNullFieldError('BookIndex', 'chapterListUrl');
    }
    if (bookInfoUrl == null) {
      throw new BuiltValueNullFieldError('BookIndex', 'bookInfoUrl');
    }
  }

  @override
  BookIndex rebuild(void Function(BookIndexBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BookIndexBuilder toBuilder() => new BookIndexBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BookIndex &&
        id == other.id &&
        title == other.title &&
        chapterListUrl == other.chapterListUrl &&
        bookInfoUrl == other.bookInfoUrl;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, id.hashCode), title.hashCode), chapterListUrl.hashCode),
        bookInfoUrl.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('BookIndex')
          ..add('id', id)
          ..add('title', title)
          ..add('chapterListUrl', chapterListUrl)
          ..add('bookInfoUrl', bookInfoUrl))
        .toString();
  }
}

class BookIndexBuilder implements Builder<BookIndex, BookIndexBuilder> {
  _$BookIndex _$v;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  String _title;
  String get title => _$this._title;
  set title(String title) => _$this._title = title;

  Uri _chapterListUrl;
  Uri get chapterListUrl => _$this._chapterListUrl;
  set chapterListUrl(Uri chapterListUrl) =>
      _$this._chapterListUrl = chapterListUrl;

  Uri _bookInfoUrl;
  Uri get bookInfoUrl => _$this._bookInfoUrl;
  set bookInfoUrl(Uri bookInfoUrl) => _$this._bookInfoUrl = bookInfoUrl;

  BookIndexBuilder();

  BookIndexBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _title = _$v.title;
      _chapterListUrl = _$v.chapterListUrl;
      _bookInfoUrl = _$v.bookInfoUrl;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BookIndex other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$BookIndex;
  }

  @override
  void update(void Function(BookIndexBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$BookIndex build() {
    final _$result = _$v ??
        new _$BookIndex._(
            id: id,
            title: title,
            chapterListUrl: chapterListUrl,
            bookInfoUrl: bookInfoUrl);
    replace(_$result);
    return _$result;
  }
}

class _$BookInfo extends BookInfo {
  @override
  final String title;
  @override
  final String author;
  @override
  final String genre;
  @override
  final String completeness;
  @override
  final String lastUpdated;
  @override
  final String length;

  factory _$BookInfo([void Function(BookInfoBuilder) updates]) =>
      (new BookInfoBuilder()..update(updates)).build();

  _$BookInfo._(
      {this.title,
      this.author,
      this.genre,
      this.completeness,
      this.lastUpdated,
      this.length})
      : super._() {
    if (title == null) {
      throw new BuiltValueNullFieldError('BookInfo', 'title');
    }
  }

  @override
  BookInfo rebuild(void Function(BookInfoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BookInfoBuilder toBuilder() => new BookInfoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BookInfo &&
        title == other.title &&
        author == other.author &&
        genre == other.genre &&
        completeness == other.completeness &&
        lastUpdated == other.lastUpdated &&
        length == other.length;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc($jc($jc(0, title.hashCode), author.hashCode),
                    genre.hashCode),
                completeness.hashCode),
            lastUpdated.hashCode),
        length.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('BookInfo')
          ..add('title', title)
          ..add('author', author)
          ..add('genre', genre)
          ..add('completeness', completeness)
          ..add('lastUpdated', lastUpdated)
          ..add('length', length))
        .toString();
  }
}

class BookInfoBuilder implements Builder<BookInfo, BookInfoBuilder> {
  _$BookInfo _$v;

  String _title;
  String get title => _$this._title;
  set title(String title) => _$this._title = title;

  String _author;
  String get author => _$this._author;
  set author(String author) => _$this._author = author;

  String _genre;
  String get genre => _$this._genre;
  set genre(String genre) => _$this._genre = genre;

  String _completeness;
  String get completeness => _$this._completeness;
  set completeness(String completeness) => _$this._completeness = completeness;

  String _lastUpdated;
  String get lastUpdated => _$this._lastUpdated;
  set lastUpdated(String lastUpdated) => _$this._lastUpdated = lastUpdated;

  String _length;
  String get length => _$this._length;
  set length(String length) => _$this._length = length;

  BookInfoBuilder();

  BookInfoBuilder get _$this {
    if (_$v != null) {
      _title = _$v.title;
      _author = _$v.author;
      _genre = _$v.genre;
      _completeness = _$v.completeness;
      _lastUpdated = _$v.lastUpdated;
      _length = _$v.length;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BookInfo other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$BookInfo;
  }

  @override
  void update(void Function(BookInfoBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$BookInfo build() {
    final _$result = _$v ??
        new _$BookInfo._(
            title: title,
            author: author,
            genre: genre,
            completeness: completeness,
            lastUpdated: lastUpdated,
            length: length);
    replace(_$result);
    return _$result;
  }
}

class _$ChapterRef extends ChapterRef {
  factory _$ChapterRef([void Function(ChapterRefBuilder) updates]) =>
      (new ChapterRefBuilder()..update(updates)).build();

  _$ChapterRef._() : super._();

  @override
  ChapterRef rebuild(void Function(ChapterRefBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ChapterRefBuilder toBuilder() => new ChapterRefBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ChapterRef;
  }

  @override
  int get hashCode {
    return 903482317;
  }

  @override
  String toString() {
    return newBuiltValueToStringHelper('ChapterRef').toString();
  }
}

class ChapterRefBuilder implements Builder<ChapterRef, ChapterRefBuilder> {
  _$ChapterRef _$v;

  ChapterRefBuilder();

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
    final _$result = _$v ?? new _$ChapterRef._();
    replace(_$result);
    return _$result;
  }
}

class _$ChapterContent extends ChapterContent {
  @override
  final Uri url;
  @override
  final String title;
  @override
  final BuiltList<String> paragraphs;
  @override
  final Uri previousChapterUrl;
  @override
  final Uri nextChapterUrl;

  factory _$ChapterContent([void Function(ChapterContentBuilder) updates]) =>
      (new ChapterContentBuilder()..update(updates)).build();

  _$ChapterContent._(
      {this.url,
      this.title,
      this.paragraphs,
      this.previousChapterUrl,
      this.nextChapterUrl})
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
  }

  @override
  ChapterContent rebuild(void Function(ChapterContentBuilder) updates) =>
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
        previousChapterUrl == other.previousChapterUrl &&
        nextChapterUrl == other.nextChapterUrl;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc($jc(0, url.hashCode), title.hashCode), paragraphs.hashCode),
            previousChapterUrl.hashCode),
        nextChapterUrl.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ChapterContent')
          ..add('url', url)
          ..add('title', title)
          ..add('paragraphs', paragraphs)
          ..add('previousChapterUrl', previousChapterUrl)
          ..add('nextChapterUrl', nextChapterUrl))
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

  Uri _previousChapterUrl;
  Uri get previousChapterUrl => _$this._previousChapterUrl;
  set previousChapterUrl(Uri previousChapterUrl) =>
      _$this._previousChapterUrl = previousChapterUrl;

  Uri _nextChapterUrl;
  Uri get nextChapterUrl => _$this._nextChapterUrl;
  set nextChapterUrl(Uri nextChapterUrl) =>
      _$this._nextChapterUrl = nextChapterUrl;

  ChapterContentBuilder();

  ChapterContentBuilder get _$this {
    if (_$v != null) {
      _url = _$v.url;
      _title = _$v.title;
      _paragraphs = _$v.paragraphs?.toBuilder();
      _previousChapterUrl = _$v.previousChapterUrl;
      _nextChapterUrl = _$v.nextChapterUrl;
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
  void update(void Function(ChapterContentBuilder) updates) {
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
              previousChapterUrl: previousChapterUrl,
              nextChapterUrl: nextChapterUrl);
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

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
