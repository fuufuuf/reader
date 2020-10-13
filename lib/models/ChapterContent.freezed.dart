// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'ChapterContent.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$ChapterContentTearOff {
  const _$ChapterContentTearOff();

// ignore: unused_element
  _ChapterContent call(
      {@required Uri url,
      @required String title,
      @required Uri chapterListUrl,
      @nullable Uri previousChapterUrl,
      Uri nextChapterUrl,
      bool isLocked = false,
      @required BuiltList<String> paragraphs}) {
    return _ChapterContent(
      url: url,
      title: title,
      chapterListUrl: chapterListUrl,
      previousChapterUrl: previousChapterUrl,
      nextChapterUrl: nextChapterUrl,
      isLocked: isLocked,
      paragraphs: paragraphs,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $ChapterContent = _$ChapterContentTearOff();

/// @nodoc
mixin _$ChapterContent {
  Uri get url;
  String get title;
  Uri get chapterListUrl;
  @nullable
  Uri get previousChapterUrl;
  Uri get nextChapterUrl;
  bool get isLocked;
  BuiltList<String> get paragraphs;

  $ChapterContentCopyWith<ChapterContent> get copyWith;
}

/// @nodoc
abstract class $ChapterContentCopyWith<$Res> {
  factory $ChapterContentCopyWith(
          ChapterContent value, $Res Function(ChapterContent) then) =
      _$ChapterContentCopyWithImpl<$Res>;
  $Res call(
      {Uri url,
      String title,
      Uri chapterListUrl,
      @nullable Uri previousChapterUrl,
      Uri nextChapterUrl,
      bool isLocked,
      BuiltList<String> paragraphs});
}

/// @nodoc
class _$ChapterContentCopyWithImpl<$Res>
    implements $ChapterContentCopyWith<$Res> {
  _$ChapterContentCopyWithImpl(this._value, this._then);

  final ChapterContent _value;
  // ignore: unused_field
  final $Res Function(ChapterContent) _then;

  @override
  $Res call({
    Object url = freezed,
    Object title = freezed,
    Object chapterListUrl = freezed,
    Object previousChapterUrl = freezed,
    Object nextChapterUrl = freezed,
    Object isLocked = freezed,
    Object paragraphs = freezed,
  }) {
    return _then(_value.copyWith(
      url: url == freezed ? _value.url : url as Uri,
      title: title == freezed ? _value.title : title as String,
      chapterListUrl: chapterListUrl == freezed
          ? _value.chapterListUrl
          : chapterListUrl as Uri,
      previousChapterUrl: previousChapterUrl == freezed
          ? _value.previousChapterUrl
          : previousChapterUrl as Uri,
      nextChapterUrl: nextChapterUrl == freezed
          ? _value.nextChapterUrl
          : nextChapterUrl as Uri,
      isLocked: isLocked == freezed ? _value.isLocked : isLocked as bool,
      paragraphs: paragraphs == freezed
          ? _value.paragraphs
          : paragraphs as BuiltList<String>,
    ));
  }
}

/// @nodoc
abstract class _$ChapterContentCopyWith<$Res>
    implements $ChapterContentCopyWith<$Res> {
  factory _$ChapterContentCopyWith(
          _ChapterContent value, $Res Function(_ChapterContent) then) =
      __$ChapterContentCopyWithImpl<$Res>;
  @override
  $Res call(
      {Uri url,
      String title,
      Uri chapterListUrl,
      @nullable Uri previousChapterUrl,
      Uri nextChapterUrl,
      bool isLocked,
      BuiltList<String> paragraphs});
}

/// @nodoc
class __$ChapterContentCopyWithImpl<$Res>
    extends _$ChapterContentCopyWithImpl<$Res>
    implements _$ChapterContentCopyWith<$Res> {
  __$ChapterContentCopyWithImpl(
      _ChapterContent _value, $Res Function(_ChapterContent) _then)
      : super(_value, (v) => _then(v as _ChapterContent));

  @override
  _ChapterContent get _value => super._value as _ChapterContent;

  @override
  $Res call({
    Object url = freezed,
    Object title = freezed,
    Object chapterListUrl = freezed,
    Object previousChapterUrl = freezed,
    Object nextChapterUrl = freezed,
    Object isLocked = freezed,
    Object paragraphs = freezed,
  }) {
    return _then(_ChapterContent(
      url: url == freezed ? _value.url : url as Uri,
      title: title == freezed ? _value.title : title as String,
      chapterListUrl: chapterListUrl == freezed
          ? _value.chapterListUrl
          : chapterListUrl as Uri,
      previousChapterUrl: previousChapterUrl == freezed
          ? _value.previousChapterUrl
          : previousChapterUrl as Uri,
      nextChapterUrl: nextChapterUrl == freezed
          ? _value.nextChapterUrl
          : nextChapterUrl as Uri,
      isLocked: isLocked == freezed ? _value.isLocked : isLocked as bool,
      paragraphs: paragraphs == freezed
          ? _value.paragraphs
          : paragraphs as BuiltList<String>,
    ));
  }
}

/// @nodoc
class _$_ChapterContent extends _ChapterContent {
  _$_ChapterContent(
      {@required this.url,
      @required this.title,
      @required this.chapterListUrl,
      @nullable this.previousChapterUrl,
      this.nextChapterUrl,
      this.isLocked = false,
      @required this.paragraphs})
      : assert(url != null),
        assert(title != null),
        assert(chapterListUrl != null),
        assert(isLocked != null),
        assert(paragraphs != null),
        super._();

  @override
  final Uri url;
  @override
  final String title;
  @override
  final Uri chapterListUrl;
  @override
  @nullable
  final Uri previousChapterUrl;
  @override
  final Uri nextChapterUrl;
  @JsonKey(defaultValue: false)
  @override
  final bool isLocked;
  @override
  final BuiltList<String> paragraphs;

  @override
  String toString() {
    return 'ChapterContent(url: $url, title: $title, chapterListUrl: $chapterListUrl, previousChapterUrl: $previousChapterUrl, nextChapterUrl: $nextChapterUrl, isLocked: $isLocked, paragraphs: $paragraphs)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ChapterContent &&
            (identical(other.url, url) ||
                const DeepCollectionEquality().equals(other.url, url)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.chapterListUrl, chapterListUrl) ||
                const DeepCollectionEquality()
                    .equals(other.chapterListUrl, chapterListUrl)) &&
            (identical(other.previousChapterUrl, previousChapterUrl) ||
                const DeepCollectionEquality()
                    .equals(other.previousChapterUrl, previousChapterUrl)) &&
            (identical(other.nextChapterUrl, nextChapterUrl) ||
                const DeepCollectionEquality()
                    .equals(other.nextChapterUrl, nextChapterUrl)) &&
            (identical(other.isLocked, isLocked) ||
                const DeepCollectionEquality()
                    .equals(other.isLocked, isLocked)) &&
            (identical(other.paragraphs, paragraphs) ||
                const DeepCollectionEquality()
                    .equals(other.paragraphs, paragraphs)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(url) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(chapterListUrl) ^
      const DeepCollectionEquality().hash(previousChapterUrl) ^
      const DeepCollectionEquality().hash(nextChapterUrl) ^
      const DeepCollectionEquality().hash(isLocked) ^
      const DeepCollectionEquality().hash(paragraphs);

  @override
  _$ChapterContentCopyWith<_ChapterContent> get copyWith =>
      __$ChapterContentCopyWithImpl<_ChapterContent>(this, _$identity);
}

abstract class _ChapterContent extends ChapterContent {
  _ChapterContent._() : super._();
  factory _ChapterContent(
      {@required Uri url,
      @required String title,
      @required Uri chapterListUrl,
      @nullable Uri previousChapterUrl,
      Uri nextChapterUrl,
      bool isLocked,
      @required BuiltList<String> paragraphs}) = _$_ChapterContent;

  @override
  Uri get url;
  @override
  String get title;
  @override
  Uri get chapterListUrl;
  @override
  @nullable
  Uri get previousChapterUrl;
  @override
  Uri get nextChapterUrl;
  @override
  bool get isLocked;
  @override
  BuiltList<String> get paragraphs;
  @override
  _$ChapterContentCopyWith<_ChapterContent> get copyWith;
}
