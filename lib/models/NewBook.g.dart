// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'NewBook.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$NewBook extends NewBook {
  @override
  final BookIndex book;
  @override
  final Uri currentChapterUrl;

  factory _$NewBook([void Function(NewBookBuilder) updates]) =>
      (new NewBookBuilder()..update(updates)).build();

  _$NewBook._({this.book, this.currentChapterUrl}) : super._() {
    if (book == null) {
      throw new BuiltValueNullFieldError('NewBook', 'book');
    }
  }

  @override
  NewBook rebuild(void Function(NewBookBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  NewBookBuilder toBuilder() => new NewBookBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NewBook &&
        book == other.book &&
        currentChapterUrl == other.currentChapterUrl;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, book.hashCode), currentChapterUrl.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('NewBook')
          ..add('book', book)
          ..add('currentChapterUrl', currentChapterUrl))
        .toString();
  }
}

class NewBookBuilder implements Builder<NewBook, NewBookBuilder> {
  _$NewBook _$v;

  BookIndexBuilder _book;
  BookIndexBuilder get book => _$this._book ??= new BookIndexBuilder();
  set book(BookIndexBuilder book) => _$this._book = book;

  Uri _currentChapterUrl;
  Uri get currentChapterUrl => _$this._currentChapterUrl;
  set currentChapterUrl(Uri currentChapterUrl) =>
      _$this._currentChapterUrl = currentChapterUrl;

  NewBookBuilder();

  NewBookBuilder get _$this {
    if (_$v != null) {
      _book = _$v.book?.toBuilder();
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
  void update(void Function(NewBookBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$NewBook build() {
    _$NewBook _$result;
    try {
      _$result = _$v ??
          new _$NewBook._(
              book: book.build(), currentChapterUrl: currentChapterUrl);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'book';
        book.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'NewBook', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
