// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BookEntry.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BookEntry extends BookEntry {
  @override
  final String id;
  @override
  final String bookName;
  @override
  final String menuUrl;
  @override
  final String bookUrl;
  @override
  final String currentUrl;

  factory _$BookEntry([void updates(BookEntryBuilder b)]) =>
      (new BookEntryBuilder()..update(updates)).build();

  _$BookEntry._(
      {this.id, this.bookName, this.menuUrl, this.bookUrl, this.currentUrl})
      : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('BookEntry', 'id');
    }
    if (bookName == null) {
      throw new BuiltValueNullFieldError('BookEntry', 'bookName');
    }
    if (menuUrl == null) {
      throw new BuiltValueNullFieldError('BookEntry', 'menuUrl');
    }
    if (bookUrl == null) {
      throw new BuiltValueNullFieldError('BookEntry', 'bookUrl');
    }
  }

  @override
  BookEntry rebuild(void updates(BookEntryBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  BookEntryBuilder toBuilder() => new BookEntryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BookEntry &&
        id == other.id &&
        bookName == other.bookName &&
        menuUrl == other.menuUrl &&
        bookUrl == other.bookUrl &&
        currentUrl == other.currentUrl;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc($jc(0, id.hashCode), bookName.hashCode), menuUrl.hashCode),
            bookUrl.hashCode),
        currentUrl.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('BookEntry')
          ..add('id', id)
          ..add('bookName', bookName)
          ..add('menuUrl', menuUrl)
          ..add('bookUrl', bookUrl)
          ..add('currentUrl', currentUrl))
        .toString();
  }
}

class BookEntryBuilder implements Builder<BookEntry, BookEntryBuilder> {
  _$BookEntry _$v;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  String _bookName;
  String get bookName => _$this._bookName;
  set bookName(String bookName) => _$this._bookName = bookName;

  String _menuUrl;
  String get menuUrl => _$this._menuUrl;
  set menuUrl(String menuUrl) => _$this._menuUrl = menuUrl;

  String _bookUrl;
  String get bookUrl => _$this._bookUrl;
  set bookUrl(String bookUrl) => _$this._bookUrl = bookUrl;

  String _currentUrl;
  String get currentUrl => _$this._currentUrl;
  set currentUrl(String currentUrl) => _$this._currentUrl = currentUrl;

  BookEntryBuilder();

  BookEntryBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _bookName = _$v.bookName;
      _menuUrl = _$v.menuUrl;
      _bookUrl = _$v.bookUrl;
      _currentUrl = _$v.currentUrl;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BookEntry other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$BookEntry;
  }

  @override
  void update(void updates(BookEntryBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$BookEntry build() {
    final _$result = _$v ??
        new _$BookEntry._(
            id: id,
            bookName: bookName,
            menuUrl: menuUrl,
            bookUrl: bookUrl,
            currentUrl: currentUrl);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
