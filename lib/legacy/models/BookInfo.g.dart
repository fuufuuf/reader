// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BookInfo.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BookInfo extends BookInfo {
  @override
  final Uri url;
  @override
  final Uri chapterListUrl;
  @override
  final String bookId;
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

  factory _$BookInfo([void updates(BookInfoBuilder b)]) =>
      (new BookInfoBuilder()..update(updates)).build();

  _$BookInfo._(
      {this.url,
      this.chapterListUrl,
      this.bookId,
      this.title,
      this.author,
      this.genre,
      this.completeness,
      this.lastUpdated,
      this.length})
      : super._() {
    if (url == null) {
      throw new BuiltValueNullFieldError('BookInfo', 'url');
    }
    if (chapterListUrl == null) {
      throw new BuiltValueNullFieldError('BookInfo', 'chapterListUrl');
    }
    if (bookId == null) {
      throw new BuiltValueNullFieldError('BookInfo', 'bookId');
    }
    if (title == null) {
      throw new BuiltValueNullFieldError('BookInfo', 'title');
    }
  }

  @override
  BookInfo rebuild(void updates(BookInfoBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  BookInfoBuilder toBuilder() => new BookInfoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BookInfo &&
        url == other.url &&
        chapterListUrl == other.chapterListUrl &&
        bookId == other.bookId &&
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
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc($jc(0, url.hashCode),
                                    chapterListUrl.hashCode),
                                bookId.hashCode),
                            title.hashCode),
                        author.hashCode),
                    genre.hashCode),
                completeness.hashCode),
            lastUpdated.hashCode),
        length.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('BookInfo')
          ..add('url', url)
          ..add('chapterListUrl', chapterListUrl)
          ..add('bookId', bookId)
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

  Uri _url;
  Uri get url => _$this._url;
  set url(Uri url) => _$this._url = url;

  Uri _chapterListUrl;
  Uri get chapterListUrl => _$this._chapterListUrl;
  set chapterListUrl(Uri chapterListUrl) =>
      _$this._chapterListUrl = chapterListUrl;

  String _bookId;
  String get bookId => _$this._bookId;
  set bookId(String bookId) => _$this._bookId = bookId;

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
      _url = _$v.url;
      _chapterListUrl = _$v.chapterListUrl;
      _bookId = _$v.bookId;
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
  void update(void updates(BookInfoBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$BookInfo build() {
    final _$result = _$v ??
        new _$BookInfo._(
            url: url,
            chapterListUrl: chapterListUrl,
            bookId: bookId,
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

// ignore_for_file: always_put_control_body_on_new_line,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
