// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CurrentBook.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CurrentBook extends CurrentBook {
  @override
  final BookIndex bookIndex;
  @override
  final BookInfo bookInfo;
  @override
  final BuiltList<ChapterRef> chapterList;
  @override
  final ChapterRef chapter;
  @override
  final ChapterContent chapterContent;

  factory _$CurrentBook([void Function(CurrentBookBuilder) updates]) =>
      (new CurrentBookBuilder()..update(updates)).build();

  _$CurrentBook._(
      {this.bookIndex,
      this.bookInfo,
      this.chapterList,
      this.chapter,
      this.chapterContent})
      : super._();

  @override
  CurrentBook rebuild(void Function(CurrentBookBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CurrentBookBuilder toBuilder() => new CurrentBookBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CurrentBook &&
        bookIndex == other.bookIndex &&
        bookInfo == other.bookInfo &&
        chapterList == other.chapterList &&
        chapter == other.chapter &&
        chapterContent == other.chapterContent;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc(0, bookIndex.hashCode), bookInfo.hashCode),
                chapterList.hashCode),
            chapter.hashCode),
        chapterContent.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('CurrentBook')
          ..add('bookIndex', bookIndex)
          ..add('bookInfo', bookInfo)
          ..add('chapterList', chapterList)
          ..add('chapter', chapter)
          ..add('chapterContent', chapterContent))
        .toString();
  }
}

class CurrentBookBuilder implements Builder<CurrentBook, CurrentBookBuilder> {
  _$CurrentBook _$v;

  BookIndexBuilder _bookIndex;
  BookIndexBuilder get bookIndex =>
      _$this._bookIndex ??= new BookIndexBuilder();
  set bookIndex(BookIndexBuilder bookIndex) => _$this._bookIndex = bookIndex;

  BookInfoBuilder _bookInfo;
  BookInfoBuilder get bookInfo => _$this._bookInfo ??= new BookInfoBuilder();
  set bookInfo(BookInfoBuilder bookInfo) => _$this._bookInfo = bookInfo;

  ListBuilder<ChapterRef> _chapterList;
  ListBuilder<ChapterRef> get chapterList =>
      _$this._chapterList ??= new ListBuilder<ChapterRef>();
  set chapterList(ListBuilder<ChapterRef> chapterList) =>
      _$this._chapterList = chapterList;

  ChapterRefBuilder _chapter;
  ChapterRefBuilder get chapter => _$this._chapter ??= new ChapterRefBuilder();
  set chapter(ChapterRefBuilder chapter) => _$this._chapter = chapter;

  ChapterContentBuilder _chapterContent;
  ChapterContentBuilder get chapterContent =>
      _$this._chapterContent ??= new ChapterContentBuilder();
  set chapterContent(ChapterContentBuilder chapterContent) =>
      _$this._chapterContent = chapterContent;

  CurrentBookBuilder();

  CurrentBookBuilder get _$this {
    if (_$v != null) {
      _bookIndex = _$v.bookIndex?.toBuilder();
      _bookInfo = _$v.bookInfo?.toBuilder();
      _chapterList = _$v.chapterList?.toBuilder();
      _chapter = _$v.chapter?.toBuilder();
      _chapterContent = _$v.chapterContent?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CurrentBook other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$CurrentBook;
  }

  @override
  void update(void Function(CurrentBookBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$CurrentBook build() {
    _$CurrentBook _$result;
    try {
      _$result = _$v ??
          new _$CurrentBook._(
              bookIndex: _bookIndex?.build(),
              bookInfo: _bookInfo?.build(),
              chapterList: _chapterList?.build(),
              chapter: _chapter?.build(),
              chapterContent: _chapterContent?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'bookIndex';
        _bookIndex?.build();
        _$failedField = 'bookInfo';
        _bookInfo?.build();
        _$failedField = 'chapterList';
        _chapterList?.build();
        _$failedField = 'chapter';
        _chapter?.build();
        _$failedField = 'chapterContent';
        _chapterContent?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'CurrentBook', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
