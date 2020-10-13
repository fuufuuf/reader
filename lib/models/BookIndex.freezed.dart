// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'BookIndex.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
BookIndex _$BookIndexFromJson(Map<String, dynamic> json) {
  return _BookIndex.fromJson(json);
}

/// @nodoc
class _$BookIndexTearOff {
  const _$BookIndexTearOff();

// ignore: unused_element
  _BookIndex call(
      {@required String adapter,
      @required String bookId,
      @required String bookName,
      @required Uri bookInfoUrl,
      @required Uri chapterListUrl}) {
    return _BookIndex(
      adapter: adapter,
      bookId: bookId,
      bookName: bookName,
      bookInfoUrl: bookInfoUrl,
      chapterListUrl: chapterListUrl,
    );
  }

// ignore: unused_element
  BookIndex fromJson(Map<String, Object> json) {
    return BookIndex.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $BookIndex = _$BookIndexTearOff();

/// @nodoc
mixin _$BookIndex {
  String get adapter;
  String get bookId;
  String get bookName;
  Uri get bookInfoUrl;
  Uri get chapterListUrl;

  Map<String, dynamic> toJson();
  $BookIndexCopyWith<BookIndex> get copyWith;
}

/// @nodoc
abstract class $BookIndexCopyWith<$Res> {
  factory $BookIndexCopyWith(BookIndex value, $Res Function(BookIndex) then) =
      _$BookIndexCopyWithImpl<$Res>;
  $Res call(
      {String adapter,
      String bookId,
      String bookName,
      Uri bookInfoUrl,
      Uri chapterListUrl});
}

/// @nodoc
class _$BookIndexCopyWithImpl<$Res> implements $BookIndexCopyWith<$Res> {
  _$BookIndexCopyWithImpl(this._value, this._then);

  final BookIndex _value;
  // ignore: unused_field
  final $Res Function(BookIndex) _then;

  @override
  $Res call({
    Object adapter = freezed,
    Object bookId = freezed,
    Object bookName = freezed,
    Object bookInfoUrl = freezed,
    Object chapterListUrl = freezed,
  }) {
    return _then(_value.copyWith(
      adapter: adapter == freezed ? _value.adapter : adapter as String,
      bookId: bookId == freezed ? _value.bookId : bookId as String,
      bookName: bookName == freezed ? _value.bookName : bookName as String,
      bookInfoUrl:
          bookInfoUrl == freezed ? _value.bookInfoUrl : bookInfoUrl as Uri,
      chapterListUrl: chapterListUrl == freezed
          ? _value.chapterListUrl
          : chapterListUrl as Uri,
    ));
  }
}

/// @nodoc
abstract class _$BookIndexCopyWith<$Res> implements $BookIndexCopyWith<$Res> {
  factory _$BookIndexCopyWith(
          _BookIndex value, $Res Function(_BookIndex) then) =
      __$BookIndexCopyWithImpl<$Res>;
  @override
  $Res call(
      {String adapter,
      String bookId,
      String bookName,
      Uri bookInfoUrl,
      Uri chapterListUrl});
}

/// @nodoc
class __$BookIndexCopyWithImpl<$Res> extends _$BookIndexCopyWithImpl<$Res>
    implements _$BookIndexCopyWith<$Res> {
  __$BookIndexCopyWithImpl(_BookIndex _value, $Res Function(_BookIndex) _then)
      : super(_value, (v) => _then(v as _BookIndex));

  @override
  _BookIndex get _value => super._value as _BookIndex;

  @override
  $Res call({
    Object adapter = freezed,
    Object bookId = freezed,
    Object bookName = freezed,
    Object bookInfoUrl = freezed,
    Object chapterListUrl = freezed,
  }) {
    return _then(_BookIndex(
      adapter: adapter == freezed ? _value.adapter : adapter as String,
      bookId: bookId == freezed ? _value.bookId : bookId as String,
      bookName: bookName == freezed ? _value.bookName : bookName as String,
      bookInfoUrl:
          bookInfoUrl == freezed ? _value.bookInfoUrl : bookInfoUrl as Uri,
      chapterListUrl: chapterListUrl == freezed
          ? _value.chapterListUrl
          : chapterListUrl as Uri,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_BookIndex implements _BookIndex {
  _$_BookIndex(
      {@required this.adapter,
      @required this.bookId,
      @required this.bookName,
      @required this.bookInfoUrl,
      @required this.chapterListUrl})
      : assert(adapter != null),
        assert(bookId != null),
        assert(bookName != null),
        assert(bookInfoUrl != null),
        assert(chapterListUrl != null);

  factory _$_BookIndex.fromJson(Map<String, dynamic> json) =>
      _$_$_BookIndexFromJson(json);

  @override
  final String adapter;
  @override
  final String bookId;
  @override
  final String bookName;
  @override
  final Uri bookInfoUrl;
  @override
  final Uri chapterListUrl;

  @override
  String toString() {
    return 'BookIndex(adapter: $adapter, bookId: $bookId, bookName: $bookName, bookInfoUrl: $bookInfoUrl, chapterListUrl: $chapterListUrl)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _BookIndex &&
            (identical(other.adapter, adapter) ||
                const DeepCollectionEquality()
                    .equals(other.adapter, adapter)) &&
            (identical(other.bookId, bookId) ||
                const DeepCollectionEquality().equals(other.bookId, bookId)) &&
            (identical(other.bookName, bookName) ||
                const DeepCollectionEquality()
                    .equals(other.bookName, bookName)) &&
            (identical(other.bookInfoUrl, bookInfoUrl) ||
                const DeepCollectionEquality()
                    .equals(other.bookInfoUrl, bookInfoUrl)) &&
            (identical(other.chapterListUrl, chapterListUrl) ||
                const DeepCollectionEquality()
                    .equals(other.chapterListUrl, chapterListUrl)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(adapter) ^
      const DeepCollectionEquality().hash(bookId) ^
      const DeepCollectionEquality().hash(bookName) ^
      const DeepCollectionEquality().hash(bookInfoUrl) ^
      const DeepCollectionEquality().hash(chapterListUrl);

  @override
  _$BookIndexCopyWith<_BookIndex> get copyWith =>
      __$BookIndexCopyWithImpl<_BookIndex>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_BookIndexToJson(this);
  }
}

abstract class _BookIndex implements BookIndex {
  factory _BookIndex(
      {@required String adapter,
      @required String bookId,
      @required String bookName,
      @required Uri bookInfoUrl,
      @required Uri chapterListUrl}) = _$_BookIndex;

  factory _BookIndex.fromJson(Map<String, dynamic> json) =
      _$_BookIndex.fromJson;

  @override
  String get adapter;
  @override
  String get bookId;
  @override
  String get bookName;
  @override
  Uri get bookInfoUrl;
  @override
  Uri get chapterListUrl;
  @override
  _$BookIndexCopyWith<_BookIndex> get copyWith;
}
