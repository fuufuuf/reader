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
  _ChapterContent fromBookIndex(
      {@required BookIndex bookIndex,
      @required Uri url,
      @required String title,
      @nullable Uri previousChapterUrl,
      @nullable Uri nextChapterUrl,
      bool isLocked = false,
      @required BuiltList<String> paragraphs}) {
    return _ChapterContent(
      bookIndex: bookIndex,
      url: url,
      title: title,
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
  BookIndex get bookIndex;
  Uri get url;
  String get title;
  @nullable
  Uri get previousChapterUrl;
  @nullable
  Uri get nextChapterUrl;
  bool get isLocked;
  BuiltList<String> get paragraphs;

  @optionalTypeArgs
  Result when<Result extends Object>({
    @required
        Result fromBookIndex(
            BookIndex bookIndex,
            Uri url,
            String title,
            @nullable Uri previousChapterUrl,
            @nullable Uri nextChapterUrl,
            bool isLocked,
            BuiltList<String> paragraphs),
  });
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result fromBookIndex(
        BookIndex bookIndex,
        Uri url,
        String title,
        @nullable Uri previousChapterUrl,
        @nullable Uri nextChapterUrl,
        bool isLocked,
        BuiltList<String> paragraphs),
    @required Result orElse(),
  });
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result fromBookIndex(_ChapterContent value),
  });
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result fromBookIndex(_ChapterContent value),
    @required Result orElse(),
  });

  $ChapterContentCopyWith<ChapterContent> get copyWith;
}

/// @nodoc
abstract class $ChapterContentCopyWith<$Res> {
  factory $ChapterContentCopyWith(
          ChapterContent value, $Res Function(ChapterContent) then) =
      _$ChapterContentCopyWithImpl<$Res>;
  $Res call(
      {BookIndex bookIndex,
      Uri url,
      String title,
      @nullable Uri previousChapterUrl,
      @nullable Uri nextChapterUrl,
      bool isLocked,
      BuiltList<String> paragraphs});

  $BookIndexCopyWith<$Res> get bookIndex;
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
    Object bookIndex = freezed,
    Object url = freezed,
    Object title = freezed,
    Object previousChapterUrl = freezed,
    Object nextChapterUrl = freezed,
    Object isLocked = freezed,
    Object paragraphs = freezed,
  }) {
    return _then(_value.copyWith(
      bookIndex:
          bookIndex == freezed ? _value.bookIndex : bookIndex as BookIndex,
      url: url == freezed ? _value.url : url as Uri,
      title: title == freezed ? _value.title : title as String,
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
abstract class _$ChapterContentCopyWith<$Res>
    implements $ChapterContentCopyWith<$Res> {
  factory _$ChapterContentCopyWith(
          _ChapterContent value, $Res Function(_ChapterContent) then) =
      __$ChapterContentCopyWithImpl<$Res>;
  @override
  $Res call(
      {BookIndex bookIndex,
      Uri url,
      String title,
      @nullable Uri previousChapterUrl,
      @nullable Uri nextChapterUrl,
      bool isLocked,
      BuiltList<String> paragraphs});

  @override
  $BookIndexCopyWith<$Res> get bookIndex;
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
    Object bookIndex = freezed,
    Object url = freezed,
    Object title = freezed,
    Object previousChapterUrl = freezed,
    Object nextChapterUrl = freezed,
    Object isLocked = freezed,
    Object paragraphs = freezed,
  }) {
    return _then(_ChapterContent(
      bookIndex:
          bookIndex == freezed ? _value.bookIndex : bookIndex as BookIndex,
      url: url == freezed ? _value.url : url as Uri,
      title: title == freezed ? _value.title : title as String,
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
      {@required this.bookIndex,
      @required this.url,
      @required this.title,
      @nullable this.previousChapterUrl,
      @nullable this.nextChapterUrl,
      this.isLocked = false,
      @required this.paragraphs})
      : assert(bookIndex != null),
        assert(url != null),
        assert(title != null),
        assert(isLocked != null),
        assert(paragraphs != null),
        super._();

  @override
  final BookIndex bookIndex;
  @override
  final Uri url;
  @override
  final String title;
  @override
  @nullable
  final Uri previousChapterUrl;
  @override
  @nullable
  final Uri nextChapterUrl;
  @JsonKey(defaultValue: false)
  @override
  final bool isLocked;
  @override
  final BuiltList<String> paragraphs;

  @override
  String toString() {
    return 'ChapterContent.fromBookIndex(bookIndex: $bookIndex, url: $url, title: $title, previousChapterUrl: $previousChapterUrl, nextChapterUrl: $nextChapterUrl, isLocked: $isLocked, paragraphs: $paragraphs)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ChapterContent &&
            (identical(other.bookIndex, bookIndex) ||
                const DeepCollectionEquality()
                    .equals(other.bookIndex, bookIndex)) &&
            (identical(other.url, url) ||
                const DeepCollectionEquality().equals(other.url, url)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
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
      const DeepCollectionEquality().hash(bookIndex) ^
      const DeepCollectionEquality().hash(url) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(previousChapterUrl) ^
      const DeepCollectionEquality().hash(nextChapterUrl) ^
      const DeepCollectionEquality().hash(isLocked) ^
      const DeepCollectionEquality().hash(paragraphs);

  @override
  _$ChapterContentCopyWith<_ChapterContent> get copyWith =>
      __$ChapterContentCopyWithImpl<_ChapterContent>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required
        Result fromBookIndex(
            BookIndex bookIndex,
            Uri url,
            String title,
            @nullable Uri previousChapterUrl,
            @nullable Uri nextChapterUrl,
            bool isLocked,
            BuiltList<String> paragraphs),
  }) {
    assert(fromBookIndex != null);
    return fromBookIndex(bookIndex, url, title, previousChapterUrl,
        nextChapterUrl, isLocked, paragraphs);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result fromBookIndex(
        BookIndex bookIndex,
        Uri url,
        String title,
        @nullable Uri previousChapterUrl,
        @nullable Uri nextChapterUrl,
        bool isLocked,
        BuiltList<String> paragraphs),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (fromBookIndex != null) {
      return fromBookIndex(bookIndex, url, title, previousChapterUrl,
          nextChapterUrl, isLocked, paragraphs);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result fromBookIndex(_ChapterContent value),
  }) {
    assert(fromBookIndex != null);
    return fromBookIndex(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result fromBookIndex(_ChapterContent value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (fromBookIndex != null) {
      return fromBookIndex(this);
    }
    return orElse();
  }
}

abstract class _ChapterContent extends ChapterContent {
  _ChapterContent._() : super._();
  factory _ChapterContent(
      {@required BookIndex bookIndex,
      @required Uri url,
      @required String title,
      @nullable Uri previousChapterUrl,
      @nullable Uri nextChapterUrl,
      bool isLocked,
      @required BuiltList<String> paragraphs}) = _$_ChapterContent;

  @override
  BookIndex get bookIndex;
  @override
  Uri get url;
  @override
  String get title;
  @override
  @nullable
  Uri get previousChapterUrl;
  @override
  @nullable
  Uri get nextChapterUrl;
  @override
  bool get isLocked;
  @override
  BuiltList<String> get paragraphs;
  @override
  _$ChapterContentCopyWith<_ChapterContent> get copyWith;
}
