// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'NewBook.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$NewBook extends NewBook {
  @override
  final BookIndex bookIndex;
  @override
  final bool isDuplicated;
  @override
  final Uri currentChapterUrl;

  factory _$NewBook([void Function(NewBookBuilder) updates]) =>
      (new NewBookBuilder()..update(updates)).build();

  _$NewBook._({this.bookIndex, this.isDuplicated, this.currentChapterUrl})
      : super._() {
    if (bookIndex == null) {
      throw new BuiltValueNullFieldError('NewBook', 'bookIndex');
    }
    if (isDuplicated == null) {
      throw new BuiltValueNullFieldError('NewBook', 'isDuplicated');
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
        bookIndex == other.bookIndex &&
        isDuplicated == other.isDuplicated &&
        currentChapterUrl == other.currentChapterUrl;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, bookIndex.hashCode), isDuplicated.hashCode),
        currentChapterUrl.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('NewBook')
          ..add('bookIndex', bookIndex)
          ..add('isDuplicated', isDuplicated)
          ..add('currentChapterUrl', currentChapterUrl))
        .toString();
  }
}

class NewBookBuilder implements Builder<NewBook, NewBookBuilder> {
  _$NewBook _$v;

  BookIndexBuilder _bookIndex;
  BookIndexBuilder get bookIndex =>
      _$this._bookIndex ??= new BookIndexBuilder();
  set bookIndex(BookIndexBuilder bookIndex) => _$this._bookIndex = bookIndex;

  bool _isDuplicated;
  bool get isDuplicated => _$this._isDuplicated;
  set isDuplicated(bool isDuplicated) => _$this._isDuplicated = isDuplicated;

  Uri _currentChapterUrl;
  Uri get currentChapterUrl => _$this._currentChapterUrl;
  set currentChapterUrl(Uri currentChapterUrl) =>
      _$this._currentChapterUrl = currentChapterUrl;

  NewBookBuilder();

  NewBookBuilder get _$this {
    if (_$v != null) {
      _bookIndex = _$v.bookIndex?.toBuilder();
      _isDuplicated = _$v.isDuplicated;
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
              bookIndex: bookIndex.build(),
              isDuplicated: isDuplicated,
              currentChapterUrl: currentChapterUrl);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'bookIndex';
        bookIndex.build();
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
