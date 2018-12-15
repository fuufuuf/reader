// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BookEntry.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<BookEntry> _$bookEntrySerializer = new _$BookEntrySerializer();

class _$BookEntrySerializer implements StructuredSerializer<BookEntry> {
  @override
  final Iterable<Type> types = const [BookEntry, _$BookEntry];
  @override
  final String wireName = 'BookEntry';

  @override
  Iterable serialize(Serializers serializers, BookEntry object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'bookName',
      serializers.serialize(object.bookName,
          specifiedType: const FullType(String)),
      'chapterListUrl',
      serializers.serialize(object.chapterListUrl,
          specifiedType: const FullType(Uri)),
      'bookInfoUrl',
      serializers.serialize(object.bookInfoUrl,
          specifiedType: const FullType(Uri)),
    ];
    if (object.currentChapterUrl != null) {
      result
        ..add('currentChapterUrl')
        ..add(serializers.serialize(object.currentChapterUrl,
            specifiedType: const FullType(Uri)));
    }

    return result;
  }

  @override
  BookEntry deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new BookEntryBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'bookName':
          result.bookName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'chapterListUrl':
          result.chapterListUrl = serializers.deserialize(value,
              specifiedType: const FullType(Uri)) as Uri;
          break;
        case 'bookInfoUrl':
          result.bookInfoUrl = serializers.deserialize(value,
              specifiedType: const FullType(Uri)) as Uri;
          break;
        case 'currentChapterUrl':
          result.currentChapterUrl = serializers.deserialize(value,
              specifiedType: const FullType(Uri)) as Uri;
          break;
      }
    }

    return result.build();
  }
}

class _$BookEntry extends BookEntry {
  @override
  final String id;
  @override
  final String bookName;
  @override
  final Uri chapterListUrl;
  @override
  final Uri bookInfoUrl;
  @override
  final Uri currentChapterUrl;

  factory _$BookEntry([void updates(BookEntryBuilder b)]) =>
      (new BookEntryBuilder()..update(updates)).build();

  _$BookEntry._(
      {this.id,
      this.bookName,
      this.chapterListUrl,
      this.bookInfoUrl,
      this.currentChapterUrl})
      : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('BookEntry', 'id');
    }
    if (bookName == null) {
      throw new BuiltValueNullFieldError('BookEntry', 'bookName');
    }
    if (chapterListUrl == null) {
      throw new BuiltValueNullFieldError('BookEntry', 'chapterListUrl');
    }
    if (bookInfoUrl == null) {
      throw new BuiltValueNullFieldError('BookEntry', 'bookInfoUrl');
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
        chapterListUrl == other.chapterListUrl &&
        bookInfoUrl == other.bookInfoUrl &&
        currentChapterUrl == other.currentChapterUrl;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc(0, id.hashCode), bookName.hashCode),
                chapterListUrl.hashCode),
            bookInfoUrl.hashCode),
        currentChapterUrl.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('BookEntry')
          ..add('id', id)
          ..add('bookName', bookName)
          ..add('chapterListUrl', chapterListUrl)
          ..add('bookInfoUrl', bookInfoUrl)
          ..add('currentChapterUrl', currentChapterUrl))
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

  Uri _chapterListUrl;
  Uri get chapterListUrl => _$this._chapterListUrl;
  set chapterListUrl(Uri chapterListUrl) =>
      _$this._chapterListUrl = chapterListUrl;

  Uri _bookInfoUrl;
  Uri get bookInfoUrl => _$this._bookInfoUrl;
  set bookInfoUrl(Uri bookInfoUrl) => _$this._bookInfoUrl = bookInfoUrl;

  Uri _currentChapterUrl;
  Uri get currentChapterUrl => _$this._currentChapterUrl;
  set currentChapterUrl(Uri currentChapterUrl) =>
      _$this._currentChapterUrl = currentChapterUrl;

  BookEntryBuilder();

  BookEntryBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _bookName = _$v.bookName;
      _chapterListUrl = _$v.chapterListUrl;
      _bookInfoUrl = _$v.bookInfoUrl;
      _currentChapterUrl = _$v.currentChapterUrl;
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
            chapterListUrl: chapterListUrl,
            bookInfoUrl: bookInfoUrl,
            currentChapterUrl: currentChapterUrl);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
