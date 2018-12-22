// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'NewBook.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$NewBook extends NewBook {
  @override
  final String bookId;
  @override
  final String bookName;
  @override
  final Uri bookInfoUrl;
  @override
  final Uri chapterListUrl;
  @override
  final Uri currentChapterUrl;

  factory _$NewBook([void updates(NewBookBuilder b)]) =>
      (new NewBookBuilder()..update(updates)).build();

  _$NewBook._(
      {this.bookId,
      this.bookName,
      this.bookInfoUrl,
      this.chapterListUrl,
      this.currentChapterUrl})
      : super._() {
    if (bookId == null) {
      throw new BuiltValueNullFieldError('NewBook', 'bookId');
    }
    if (bookName == null) {
      throw new BuiltValueNullFieldError('NewBook', 'bookName');
    }
    if (bookInfoUrl == null) {
      throw new BuiltValueNullFieldError('NewBook', 'bookInfoUrl');
    }
    if (chapterListUrl == null) {
      throw new BuiltValueNullFieldError('NewBook', 'chapterListUrl');
    }
  }

  @override
  NewBook rebuild(void updates(NewBookBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  NewBookBuilder toBuilder() => new NewBookBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NewBook &&
        bookId == other.bookId &&
        bookName == other.bookName &&
        bookInfoUrl == other.bookInfoUrl &&
        chapterListUrl == other.chapterListUrl &&
        currentChapterUrl == other.currentChapterUrl;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc(0, bookId.hashCode), bookName.hashCode),
                bookInfoUrl.hashCode),
            chapterListUrl.hashCode),
        currentChapterUrl.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('NewBook')
          ..add('bookId', bookId)
          ..add('bookName', bookName)
          ..add('bookInfoUrl', bookInfoUrl)
          ..add('chapterListUrl', chapterListUrl)
          ..add('currentChapterUrl', currentChapterUrl))
        .toString();
  }
}

class NewBookBuilder implements Builder<NewBook, NewBookBuilder> {
  _$NewBook _$v;

  String _bookId;
  String get bookId => _$this._bookId;
  set bookId(String bookId) => _$this._bookId = bookId;

  String _bookName;
  String get bookName => _$this._bookName;
  set bookName(String bookName) => _$this._bookName = bookName;

  Uri _bookInfoUrl;
  Uri get bookInfoUrl => _$this._bookInfoUrl;
  set bookInfoUrl(Uri bookInfoUrl) => _$this._bookInfoUrl = bookInfoUrl;

  Uri _chapterListUrl;
  Uri get chapterListUrl => _$this._chapterListUrl;
  set chapterListUrl(Uri chapterListUrl) =>
      _$this._chapterListUrl = chapterListUrl;

  Uri _currentChapterUrl;
  Uri get currentChapterUrl => _$this._currentChapterUrl;
  set currentChapterUrl(Uri currentChapterUrl) =>
      _$this._currentChapterUrl = currentChapterUrl;

  NewBookBuilder();

  NewBookBuilder get _$this {
    if (_$v != null) {
      _bookId = _$v.bookId;
      _bookName = _$v.bookName;
      _bookInfoUrl = _$v.bookInfoUrl;
      _chapterListUrl = _$v.chapterListUrl;
      _currentChapterUrl = _$v.currentChapterUrl;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(NewBook other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$NewBook;
  }

  @override
  void update(void updates(NewBookBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$NewBook build() {
    final _$result = _$v ??
        new _$NewBook._(
            bookId: bookId,
            bookName: bookName,
            bookInfoUrl: bookInfoUrl,
            chapterListUrl: chapterListUrl,
            currentChapterUrl: currentChapterUrl);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
