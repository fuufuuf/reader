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
  _BookInfo fromBookIndex(
      {@required BookIndex bookIndex,
      String author,
      String genre,
      String completeness,
      String lastUpdated,
      String length}) {
    return _BookInfo(
      bookIndex: bookIndex,
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
  BookIndex get bookIndex;
  String get author;
  String get genre;
  String get completeness;
  String get lastUpdated;
  String get length;

  @optionalTypeArgs
  Result when<Result extends Object>({
    @required
        Result fromBookIndex(BookIndex bookIndex, String author, String genre,
            String completeness, String lastUpdated, String length),
  });
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result fromBookIndex(BookIndex bookIndex, String author, String genre,
        String completeness, String lastUpdated, String length),
    @required Result orElse(),
  });
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result fromBookIndex(_BookInfo value),
  });
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result fromBookIndex(_BookInfo value),
    @required Result orElse(),
  });

  $BookInfoCopyWith<BookInfo> get copyWith;
}

/// @nodoc
abstract class $BookInfoCopyWith<$Res> {
  factory $BookInfoCopyWith(BookInfo value, $Res Function(BookInfo) then) =
      _$BookInfoCopyWithImpl<$Res>;
  $Res call(
      {BookIndex bookIndex,
      String author,
      String genre,
      String completeness,
      String lastUpdated,
      String length});

  $BookIndexCopyWith<$Res> get bookIndex;
}

/// @nodoc
class _$BookInfoCopyWithImpl<$Res> implements $BookInfoCopyWith<$Res> {
  _$BookInfoCopyWithImpl(this._value, this._then);

  final BookInfo _value;
  // ignore: unused_field
  final $Res Function(BookInfo) _then;

  @override
  $Res call({
    Object bookIndex = freezed,
    Object author = freezed,
    Object genre = freezed,
    Object completeness = freezed,
    Object lastUpdated = freezed,
    Object length = freezed,
  }) {
    return _then(_value.copyWith(
      bookIndex:
          bookIndex == freezed ? _value.bookIndex : bookIndex as BookIndex,
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

  @override
  $BookIndexCopyWith<$Res> get bookIndex {
    if (_value.bookIndex == null) {
      return null;
    }
    return $BookIndexCopyWith<$Res>(_value.bookIndex, (value) {
      return _then(_value.copyWith(bookIndex: value));
    });
  }
}

/// @nodoc
abstract class _$BookInfoCopyWith<$Res> implements $BookInfoCopyWith<$Res> {
  factory _$BookInfoCopyWith(_BookInfo value, $Res Function(_BookInfo) then) =
      __$BookInfoCopyWithImpl<$Res>;
  @override
  $Res call(
      {BookIndex bookIndex,
      String author,
      String genre,
      String completeness,
      String lastUpdated,
      String length});

  @override
  $BookIndexCopyWith<$Res> get bookIndex;
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
    Object bookIndex = freezed,
    Object author = freezed,
    Object genre = freezed,
    Object completeness = freezed,
    Object lastUpdated = freezed,
    Object length = freezed,
  }) {
    return _then(_BookInfo(
      bookIndex:
          bookIndex == freezed ? _value.bookIndex : bookIndex as BookIndex,
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
      {@required this.bookIndex,
      this.author,
      this.genre,
      this.completeness,
      this.lastUpdated,
      this.length})
      : assert(bookIndex != null),
        super._();

  @override
  final BookIndex bookIndex;
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
    return 'BookInfo.fromBookIndex(bookIndex: $bookIndex, author: $author, genre: $genre, completeness: $completeness, lastUpdated: $lastUpdated, length: $length)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _BookInfo &&
            (identical(other.bookIndex, bookIndex) ||
                const DeepCollectionEquality()
                    .equals(other.bookIndex, bookIndex)) &&
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
      const DeepCollectionEquality().hash(bookIndex) ^
      const DeepCollectionEquality().hash(author) ^
      const DeepCollectionEquality().hash(genre) ^
      const DeepCollectionEquality().hash(completeness) ^
      const DeepCollectionEquality().hash(lastUpdated) ^
      const DeepCollectionEquality().hash(length);

  @override
  _$BookInfoCopyWith<_BookInfo> get copyWith =>
      __$BookInfoCopyWithImpl<_BookInfo>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required
        Result fromBookIndex(BookIndex bookIndex, String author, String genre,
            String completeness, String lastUpdated, String length),
  }) {
    assert(fromBookIndex != null);
    return fromBookIndex(
        bookIndex, author, genre, completeness, lastUpdated, length);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result fromBookIndex(BookIndex bookIndex, String author, String genre,
        String completeness, String lastUpdated, String length),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (fromBookIndex != null) {
      return fromBookIndex(
          bookIndex, author, genre, completeness, lastUpdated, length);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result fromBookIndex(_BookInfo value),
  }) {
    assert(fromBookIndex != null);
    return fromBookIndex(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result fromBookIndex(_BookInfo value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (fromBookIndex != null) {
      return fromBookIndex(this);
    }
    return orElse();
  }
}

abstract class _BookInfo extends BookInfo {
  _BookInfo._() : super._();
  factory _BookInfo(
      {@required BookIndex bookIndex,
      String author,
      String genre,
      String completeness,
      String lastUpdated,
      String length}) = _$_BookInfo;

  @override
  BookIndex get bookIndex;
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
