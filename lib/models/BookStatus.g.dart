// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BookStatus.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BookStatus extends BookStatus {
  @override
  final String id;
  @override
  final String bookName;
  @override
  final String menuUrl;
  @override
  final String bookurl;
  @override
  final String currentUrl;

  factory _$BookStatus([void updates(BookStatusBuilder b)]) =>
      (new BookStatusBuilder()..update(updates)).build();

  _$BookStatus._(
      {this.id, this.bookName, this.menuUrl, this.bookurl, this.currentUrl})
      : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('BookStatus', 'id');
    }
    if (bookName == null) {
      throw new BuiltValueNullFieldError('BookStatus', 'bookName');
    }
    if (menuUrl == null) {
      throw new BuiltValueNullFieldError('BookStatus', 'menuUrl');
    }
    if (bookurl == null) {
      throw new BuiltValueNullFieldError('BookStatus', 'bookurl');
    }
  }

  @override
  BookStatus rebuild(void updates(BookStatusBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  BookStatusBuilder toBuilder() => new BookStatusBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BookStatus &&
        id == other.id &&
        bookName == other.bookName &&
        menuUrl == other.menuUrl &&
        bookurl == other.bookurl &&
        currentUrl == other.currentUrl;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc($jc(0, id.hashCode), bookName.hashCode), menuUrl.hashCode),
            bookurl.hashCode),
        currentUrl.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('BookStatus')
          ..add('id', id)
          ..add('bookName', bookName)
          ..add('menuUrl', menuUrl)
          ..add('bookurl', bookurl)
          ..add('currentUrl', currentUrl))
        .toString();
  }
}

class BookStatusBuilder implements Builder<BookStatus, BookStatusBuilder> {
  _$BookStatus _$v;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  String _bookName;
  String get bookName => _$this._bookName;
  set bookName(String bookName) => _$this._bookName = bookName;

  String _menuUrl;
  String get menuUrl => _$this._menuUrl;
  set menuUrl(String menuUrl) => _$this._menuUrl = menuUrl;

  String _bookurl;
  String get bookurl => _$this._bookurl;
  set bookurl(String bookurl) => _$this._bookurl = bookurl;

  String _currentUrl;
  String get currentUrl => _$this._currentUrl;
  set currentUrl(String currentUrl) => _$this._currentUrl = currentUrl;

  BookStatusBuilder();

  BookStatusBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _bookName = _$v.bookName;
      _menuUrl = _$v.menuUrl;
      _bookurl = _$v.bookurl;
      _currentUrl = _$v.currentUrl;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BookStatus other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$BookStatus;
  }

  @override
  void update(void updates(BookStatusBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$BookStatus build() {
    final _$result = _$v ??
        new _$BookStatus._(
            id: id,
            bookName: bookName,
            menuUrl: menuUrl,
            bookurl: bookurl,
            currentUrl: currentUrl);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
