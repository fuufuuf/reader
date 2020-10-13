// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'ChapterList.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$ChapterListTearOff {
  const _$ChapterListTearOff();

// ignore: unused_element
  _ChapterList call(
      {@required Uri url,
      @required String title,
      @required Uri bookInfoUrl,
      @required BuiltList<ChapterRef> chapters}) {
    return _ChapterList(
      url: url,
      title: title,
      bookInfoUrl: bookInfoUrl,
      chapters: chapters,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $ChapterList = _$ChapterListTearOff();

/// @nodoc
mixin _$ChapterList {
  Uri get url;
  String get title;
  Uri get bookInfoUrl;
  BuiltList<ChapterRef> get chapters;

  $ChapterListCopyWith<ChapterList> get copyWith;
}

/// @nodoc
abstract class $ChapterListCopyWith<$Res> {
  factory $ChapterListCopyWith(
          ChapterList value, $Res Function(ChapterList) then) =
      _$ChapterListCopyWithImpl<$Res>;
  $Res call(
      {Uri url, String title, Uri bookInfoUrl, BuiltList<ChapterRef> chapters});
}

/// @nodoc
class _$ChapterListCopyWithImpl<$Res> implements $ChapterListCopyWith<$Res> {
  _$ChapterListCopyWithImpl(this._value, this._then);

  final ChapterList _value;
  // ignore: unused_field
  final $Res Function(ChapterList) _then;

  @override
  $Res call({
    Object url = freezed,
    Object title = freezed,
    Object bookInfoUrl = freezed,
    Object chapters = freezed,
  }) {
    return _then(_value.copyWith(
      url: url == freezed ? _value.url : url as Uri,
      title: title == freezed ? _value.title : title as String,
      bookInfoUrl:
          bookInfoUrl == freezed ? _value.bookInfoUrl : bookInfoUrl as Uri,
      chapters: chapters == freezed
          ? _value.chapters
          : chapters as BuiltList<ChapterRef>,
    ));
  }
}

/// @nodoc
abstract class _$ChapterListCopyWith<$Res>
    implements $ChapterListCopyWith<$Res> {
  factory _$ChapterListCopyWith(
          _ChapterList value, $Res Function(_ChapterList) then) =
      __$ChapterListCopyWithImpl<$Res>;
  @override
  $Res call(
      {Uri url, String title, Uri bookInfoUrl, BuiltList<ChapterRef> chapters});
}

/// @nodoc
class __$ChapterListCopyWithImpl<$Res> extends _$ChapterListCopyWithImpl<$Res>
    implements _$ChapterListCopyWith<$Res> {
  __$ChapterListCopyWithImpl(
      _ChapterList _value, $Res Function(_ChapterList) _then)
      : super(_value, (v) => _then(v as _ChapterList));

  @override
  _ChapterList get _value => super._value as _ChapterList;

  @override
  $Res call({
    Object url = freezed,
    Object title = freezed,
    Object bookInfoUrl = freezed,
    Object chapters = freezed,
  }) {
    return _then(_ChapterList(
      url: url == freezed ? _value.url : url as Uri,
      title: title == freezed ? _value.title : title as String,
      bookInfoUrl:
          bookInfoUrl == freezed ? _value.bookInfoUrl : bookInfoUrl as Uri,
      chapters: chapters == freezed
          ? _value.chapters
          : chapters as BuiltList<ChapterRef>,
    ));
  }
}

/// @nodoc
class _$_ChapterList implements _ChapterList {
  _$_ChapterList(
      {@required this.url,
      @required this.title,
      @required this.bookInfoUrl,
      @required this.chapters})
      : assert(url != null),
        assert(title != null),
        assert(bookInfoUrl != null),
        assert(chapters != null);

  @override
  final Uri url;
  @override
  final String title;
  @override
  final Uri bookInfoUrl;
  @override
  final BuiltList<ChapterRef> chapters;

  @override
  String toString() {
    return 'ChapterList(url: $url, title: $title, bookInfoUrl: $bookInfoUrl, chapters: $chapters)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ChapterList &&
            (identical(other.url, url) ||
                const DeepCollectionEquality().equals(other.url, url)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.bookInfoUrl, bookInfoUrl) ||
                const DeepCollectionEquality()
                    .equals(other.bookInfoUrl, bookInfoUrl)) &&
            (identical(other.chapters, chapters) ||
                const DeepCollectionEquality()
                    .equals(other.chapters, chapters)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(url) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(bookInfoUrl) ^
      const DeepCollectionEquality().hash(chapters);

  @override
  _$ChapterListCopyWith<_ChapterList> get copyWith =>
      __$ChapterListCopyWithImpl<_ChapterList>(this, _$identity);
}

abstract class _ChapterList implements ChapterList {
  factory _ChapterList(
      {@required Uri url,
      @required String title,
      @required Uri bookInfoUrl,
      @required BuiltList<ChapterRef> chapters}) = _$_ChapterList;

  @override
  Uri get url;
  @override
  String get title;
  @override
  Uri get bookInfoUrl;
  @override
  BuiltList<ChapterRef> get chapters;
  @override
  _$ChapterListCopyWith<_ChapterList> get copyWith;
}
