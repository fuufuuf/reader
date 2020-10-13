// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'BookInfo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$BookInfoTearOff {
  const _$BookInfoTearOff();

// ignore: unused_element
  _BookInfo call(
      {@required Uri url,
      @required Uri chapterListUrl,
      @required String bookId,
      @required String title,
      String author,
      String genre,
      String completeness,
      String lastUpdated,
      String length}) {
    return _BookInfo(
      url: url,
      chapterListUrl: chapterListUrl,
      bookId: bookId,
      title: title,
      author: author,
      genre: genre,
      completeness: completeness,
      lastUpdated: lastUpdated,
      length: length,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $BookInfo = _$BookInfoTearOff();

/// @nodoc
mixin _$BookInfo {
  Uri get url;
  Uri get chapterListUrl;
  String get bookId;
  String get title;
  String get author;
  String get genre;
  String get completeness;
  String get lastUpdated;
  String get length;

  $BookInfoCopyWith<BookInfo> get copyWith;
}

/// @nodoc
abstract class $BookInfoCopyWith<$Res> {
  factory $BookInfoCopyWith(BookInfo value, $Res Function(BookInfo) then) =
      _$BookInfoCopyWithImpl<$Res>;
  $Res call(
      {Uri url,
      Uri chapterListUrl,
      String bookId,
      String title,
      String author,
      String genre,
      String completeness,
      String lastUpdated,
      String length});
}

/// @nodoc
class _$BookInfoCopyWithImpl<$Res> implements $BookInfoCopyWith<$Res> {
  _$BookInfoCopyWithImpl(this._value, this._then);

  final BookInfo _value;
  // ignore: unused_field
  final $Res Function(BookInfo) _then;

  @override
  $Res call({
    Object url = freezed,
    Object chapterListUrl = freezed,
    Object bookId = freezed,
    Object title = freezed,
    Object author = freezed,
    Object genre = freezed,
    Object completeness = freezed,
    Object lastUpdated = freezed,
    Object length = freezed,
  }) {
    return _then(_value.copyWith(
      url: url == freezed ? _value.url : url as Uri,
      chapterListUrl: chapterListUrl == freezed
          ? _value.chapterListUrl
          : chapterListUrl as Uri,
      bookId: bookId == freezed ? _value.bookId : bookId as String,
      title: title == freezed ? _value.title : title as String,
      author: author == freezed ? _value.author : author as String,
      genre: genre == freezed ? _value.genre : genre as String,
      completeness: completeness == freezed
          ? _value.completeness
          : completeness as String,
      lastUpdated:
          lastUpdated == freezed ? _value.lastUpdated : lastUpdated as String,
      length: length == freezed ? _value.length : length as String,
    ));
  }
}

/// @nodoc
abstract class _$BookInfoCopyWith<$Res> implements $BookInfoCopyWith<$Res> {
  factory _$BookInfoCopyWith(_BookInfo value, $Res Function(_BookInfo) then) =
      __$BookInfoCopyWithImpl<$Res>;
  @override
  $Res call(
      {Uri url,
      Uri chapterListUrl,
      String bookId,
      String title,
      String author,
      String genre,
      String completeness,
      String lastUpdated,
      String length});
}

/// @nodoc
class __$BookInfoCopyWithImpl<$Res> extends _$BookInfoCopyWithImpl<$Res>
    implements _$BookInfoCopyWith<$Res> {
  __$BookInfoCopyWithImpl(_BookInfo _value, $Res Function(_BookInfo) _then)
      : super(_value, (v) => _then(v as _BookInfo));

  @override
  _BookInfo get _value => super._value as _BookInfo;

  @override
  $Res call({
    Object url = freezed,
    Object chapterListUrl = freezed,
    Object bookId = freezed,
    Object title = freezed,
    Object author = freezed,
    Object genre = freezed,
    Object completeness = freezed,
    Object lastUpdated = freezed,
    Object length = freezed,
  }) {
    return _then(_BookInfo(
      url: url == freezed ? _value.url : url as Uri,
      chapterListUrl: chapterListUrl == freezed
          ? _value.chapterListUrl
          : chapterListUrl as Uri,
      bookId: bookId == freezed ? _value.bookId : bookId as String,
      title: title == freezed ? _value.title : title as String,
      author: author == freezed ? _value.author : author as String,
      genre: genre == freezed ? _value.genre : genre as String,
      completeness: completeness == freezed
          ? _value.completeness
          : completeness as String,
      lastUpdated:
          lastUpdated == freezed ? _value.lastUpdated : lastUpdated as String,
      length: length == freezed ? _value.length : length as String,
    ));
  }
}

/// @nodoc
class _$_BookInfo extends _BookInfo {
  _$_BookInfo(
      {@required this.url,
      @required this.chapterListUrl,
      @required this.bookId,
      @required this.title,
      this.author,
      this.genre,
      this.completeness,
      this.lastUpdated,
      this.length})
      : assert(url != null),
        assert(chapterListUrl != null),
        assert(bookId != null),
        assert(title != null),
        super._();

  @override
  final Uri url;
  @override
  final Uri chapterListUrl;
  @override
  final String bookId;
  @override
  final String title;
  @override
  final String author;
  @override
  final String genre;
  @override
  final String completeness;
  @override
  final String lastUpdated;
  @override
  final String length;

  @override
  String toString() {
    return 'BookInfo(url: $url, chapterListUrl: $chapterListUrl, bookId: $bookId, title: $title, author: $author, genre: $genre, completeness: $completeness, lastUpdated: $lastUpdated, length: $length)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _BookInfo &&
            (identical(other.url, url) ||
                const DeepCollectionEquality().equals(other.url, url)) &&
            (identical(other.chapterListUrl, chapterListUrl) ||
                const DeepCollectionEquality()
                    .equals(other.chapterListUrl, chapterListUrl)) &&
            (identical(other.bookId, bookId) ||
                const DeepCollectionEquality().equals(other.bookId, bookId)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.author, author) ||
                const DeepCollectionEquality().equals(other.author, author)) &&
            (identical(other.genre, genre) ||
                const DeepCollectionEquality().equals(other.genre, genre)) &&
            (identical(other.completeness, completeness) ||
                const DeepCollectionEquality()
                    .equals(other.completeness, completeness)) &&
            (identical(other.lastUpdated, lastUpdated) ||
                const DeepCollectionEquality()
                    .equals(other.lastUpdated, lastUpdated)) &&
            (identical(other.length, length) ||
                const DeepCollectionEquality().equals(other.length, length)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(url) ^
      const DeepCollectionEquality().hash(chapterListUrl) ^
      const DeepCollectionEquality().hash(bookId) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(author) ^
      const DeepCollectionEquality().hash(genre) ^
      const DeepCollectionEquality().hash(completeness) ^
      const DeepCollectionEquality().hash(lastUpdated) ^
      const DeepCollectionEquality().hash(length);

  @override
  _$BookInfoCopyWith<_BookInfo> get copyWith =>
      __$BookInfoCopyWithImpl<_BookInfo>(this, _$identity);
}

abstract class _BookInfo extends BookInfo {
  _BookInfo._() : super._();
  factory _BookInfo(
      {@required Uri url,
      @required Uri chapterListUrl,
      @required String bookId,
      @required String title,
      String author,
      String genre,
      String completeness,
      String lastUpdated,
      String length}) = _$_BookInfo;

  @override
  Uri get url;
  @override
  Uri get chapterListUrl;
  @override
  String get bookId;
  @override
  String get title;
  @override
  String get author;
  @override
  String get genre;
  @override
  String get completeness;
  @override
  String get lastUpdated;
  @override
  String get length;
  @override
  _$BookInfoCopyWith<_BookInfo> get copyWith;
}
