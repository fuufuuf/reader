// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BookList.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BookList extends BookList {
  @override
  final SharedPreferences sharedPrefs;
  @override
  final BuiltSet<String> bookIds;
  @override
  final BuiltList<BookIndex> books;

  factory _$BookList([void Function(BookListBuilder) updates]) =>
      (new BookListBuilder()..update(updates)).build();

  _$BookList._({this.sharedPrefs, this.bookIds, this.books}) : super._() {
    if (sharedPrefs == null) {
      throw new BuiltValueNullFieldError('BookList', 'sharedPrefs');
    }
    if (bookIds == null) {
      throw new BuiltValueNullFieldError('BookList', 'bookIds');
    }
    if (books == null) {
      throw new BuiltValueNullFieldError('BookList', 'books');
    }
  }

  @override
  BookList rebuild(void Function(BookListBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BookListBuilder toBuilder() => new BookListBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BookList &&
        sharedPrefs == other.sharedPrefs &&
        bookIds == other.bookIds &&
        books == other.books;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc(0, sharedPrefs.hashCode), bookIds.hashCode), books.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('BookList')
          ..add('sharedPrefs', sharedPrefs)
          ..add('bookIds', bookIds)
          ..add('books', books))
        .toString();
  }
}

class BookListBuilder implements Builder<BookList, BookListBuilder> {
  _$BookList _$v;

  SharedPreferences _sharedPrefs;
  SharedPreferences get sharedPrefs => _$this._sharedPrefs;
  set sharedPrefs(SharedPreferences sharedPrefs) =>
      _$this._sharedPrefs = sharedPrefs;

  SetBuilder<String> _bookIds;
  SetBuilder<String> get bookIds =>
      _$this._bookIds ??= new SetBuilder<String>();
  set bookIds(SetBuilder<String> bookIds) => _$this._bookIds = bookIds;

  ListBuilder<BookIndex> _books;
  ListBuilder<BookIndex> get books =>
      _$this._books ??= new ListBuilder<BookIndex>();
  set books(ListBuilder<BookIndex> books) => _$this._books = books;

  BookListBuilder();

  BookListBuilder get _$this {
    if (_$v != null) {
      _sharedPrefs = _$v.sharedPrefs;
      _bookIds = _$v.bookIds?.toBuilder();
      _books = _$v.books?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BookList other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$BookList;
  }

  @override
  void update(void Function(BookListBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$BookList build() {
    _$BookList _$result;
    try {
      _$result = _$v ??
          new _$BookList._(
              sharedPrefs: sharedPrefs,
              bookIds: bookIds.build(),
              books: books.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'bookIds';
        bookIds.build();
        _$failedField = 'books';
        books.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'BookList', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
