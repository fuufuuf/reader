// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BookIndex.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<BookIndex> _$bookIndexSerializer = new _$BookIndexSerializer();

class _$BookIndexSerializer implements StructuredSerializer<BookIndex> {
  @override
  final Iterable<Type> types = const [BookIndex, _$BookIndex];
  @override
  final String wireName = 'BookIndex';

  @override
  Iterable serialize(Serializers serializers, BookIndex object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'bookId',
      serializers.serialize(object.bookId,
          specifiedType: const FullType(String)),
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

    return result;
  }

  @override
  BookIndex deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new BookIndexBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'bookId':
          result.bookId = serializers.deserialize(value,
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
      }
    }

    return result.build();
  }
}

class _$BookIndex extends BookIndex {
  @override
  final String bookId;
  @override
  final String bookName;
  @override
  final Uri chapterListUrl;
  @override
  final Uri bookInfoUrl;

  factory _$BookIndex([void updates(BookIndexBuilder b)]) =>
      (new BookIndexBuilder()..update(updates)).build();

  _$BookIndex._(
      {this.bookId, this.bookName, this.chapterListUrl, this.bookInfoUrl})
      : super._() {
    if (bookId == null) {
      throw new BuiltValueNullFieldError('BookIndex', 'bookId');
    }
    if (bookName == null) {
      throw new BuiltValueNullFieldError('BookIndex', 'bookName');
    }
    if (chapterListUrl == null) {
      throw new BuiltValueNullFieldError('BookIndex', 'chapterListUrl');
    }
    if (bookInfoUrl == null) {
      throw new BuiltValueNullFieldError('BookIndex', 'bookInfoUrl');
    }
  }

  @override
  BookIndex rebuild(void updates(BookIndexBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  BookIndexBuilder toBuilder() => new BookIndexBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BookIndex &&
        bookId == other.bookId &&
        bookName == other.bookName &&
        chapterListUrl == other.chapterListUrl &&
        bookInfoUrl == other.bookInfoUrl;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, bookId.hashCode), bookName.hashCode),
            chapterListUrl.hashCode),
        bookInfoUrl.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('BookIndex')
          ..add('bookId', bookId)
          ..add('bookName', bookName)
          ..add('chapterListUrl', chapterListUrl)
          ..add('bookInfoUrl', bookInfoUrl))
        .toString();
  }
}

class BookIndexBuilder implements Builder<BookIndex, BookIndexBuilder> {
  _$BookIndex _$v;

  String _bookId;
  String get bookId => _$this._bookId;
  set bookId(String bookId) => _$this._bookId = bookId;

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

  BookIndexBuilder();

  BookIndexBuilder get _$this {
    if (_$v != null) {
      _bookId = _$v.bookId;
      _bookName = _$v.bookName;
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
  void update(void updates(BookIndexBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$BookIndex build() {
    final _$result = _$v ??
        new _$BookIndex._(
            bookId: bookId,
            bookName: bookName,
            chapterListUrl: chapterListUrl,
            bookInfoUrl: bookInfoUrl);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
