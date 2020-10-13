// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'NewBook.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$NewBookTearOff {
  const _$NewBookTearOff();

// ignore: unused_element
  _NewBook fromBookIndex(
      {@required BookIndex bookIndex,
      @nullable Uri currentChapterUrl,
      bool isDuplicated = false}) {
    return _NewBook(
      bookIndex: bookIndex,
      currentChapterUrl: currentChapterUrl,
      isDuplicated: isDuplicated,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $NewBook = _$NewBookTearOff();

/// @nodoc
mixin _$NewBook {
  BookIndex get bookIndex;
  @nullable
  Uri get currentChapterUrl;
  bool get isDuplicated;

  @optionalTypeArgs
  Result when<Result extends Object>({
    @required
        Result fromBookIndex(BookIndex bookIndex,
            @nullable Uri currentChapterUrl, bool isDuplicated),
  });
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result fromBookIndex(BookIndex bookIndex, @nullable Uri currentChapterUrl,
        bool isDuplicated),
    @required Result orElse(),
  });
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result fromBookIndex(_NewBook value),
  });
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result fromBookIndex(_NewBook value),
    @required Result orElse(),
  });

  $NewBookCopyWith<NewBook> get copyWith;
}

/// @nodoc
abstract class $NewBookCopyWith<$Res> {
  factory $NewBookCopyWith(NewBook value, $Res Function(NewBook) then) =
      _$NewBookCopyWithImpl<$Res>;
  $Res call(
      {BookIndex bookIndex,
      @nullable Uri currentChapterUrl,
      bool isDuplicated});

  $BookIndexCopyWith<$Res> get bookIndex;
}

/// @nodoc
class _$NewBookCopyWithImpl<$Res> implements $NewBookCopyWith<$Res> {
  _$NewBookCopyWithImpl(this._value, this._then);

  final NewBook _value;
  // ignore: unused_field
  final $Res Function(NewBook) _then;

  @override
  $Res call({
    Object bookIndex = freezed,
    Object currentChapterUrl = freezed,
    Object isDuplicated = freezed,
  }) {
    return _then(_value.copyWith(
      bookIndex:
          bookIndex == freezed ? _value.bookIndex : bookIndex as BookIndex,
      currentChapterUrl: currentChapterUrl == freezed
          ? _value.currentChapterUrl
          : currentChapterUrl as Uri,
      isDuplicated:
          isDuplicated == freezed ? _value.isDuplicated : isDuplicated as bool,
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
abstract class _$NewBookCopyWith<$Res> implements $NewBookCopyWith<$Res> {
  factory _$NewBookCopyWith(_NewBook value, $Res Function(_NewBook) then) =
      __$NewBookCopyWithImpl<$Res>;
  @override
  $Res call(
      {BookIndex bookIndex,
      @nullable Uri currentChapterUrl,
      bool isDuplicated});

  @override
  $BookIndexCopyWith<$Res> get bookIndex;
}

/// @nodoc
class __$NewBookCopyWithImpl<$Res> extends _$NewBookCopyWithImpl<$Res>
    implements _$NewBookCopyWith<$Res> {
  __$NewBookCopyWithImpl(_NewBook _value, $Res Function(_NewBook) _then)
      : super(_value, (v) => _then(v as _NewBook));

  @override
  _NewBook get _value => super._value as _NewBook;

  @override
  $Res call({
    Object bookIndex = freezed,
    Object currentChapterUrl = freezed,
    Object isDuplicated = freezed,
  }) {
    return _then(_NewBook(
      bookIndex:
          bookIndex == freezed ? _value.bookIndex : bookIndex as BookIndex,
      currentChapterUrl: currentChapterUrl == freezed
          ? _value.currentChapterUrl
          : currentChapterUrl as Uri,
      isDuplicated:
          isDuplicated == freezed ? _value.isDuplicated : isDuplicated as bool,
    ));
  }
}

/// @nodoc
class _$_NewBook extends _NewBook {
  _$_NewBook(
      {@required this.bookIndex,
      @nullable this.currentChapterUrl,
      this.isDuplicated = false})
      : assert(bookIndex != null),
        assert(isDuplicated != null),
        super._();

  @override
  final BookIndex bookIndex;
  @override
  @nullable
  final Uri currentChapterUrl;
  @JsonKey(defaultValue: false)
  @override
  final bool isDuplicated;

  @override
  String toString() {
    return 'NewBook.fromBookIndex(bookIndex: $bookIndex, currentChapterUrl: $currentChapterUrl, isDuplicated: $isDuplicated)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _NewBook &&
            (identical(other.bookIndex, bookIndex) ||
                const DeepCollectionEquality()
                    .equals(other.bookIndex, bookIndex)) &&
            (identical(other.currentChapterUrl, currentChapterUrl) ||
                const DeepCollectionEquality()
                    .equals(other.currentChapterUrl, currentChapterUrl)) &&
            (identical(other.isDuplicated, isDuplicated) ||
                const DeepCollectionEquality()
                    .equals(other.isDuplicated, isDuplicated)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(bookIndex) ^
      const DeepCollectionEquality().hash(currentChapterUrl) ^
      const DeepCollectionEquality().hash(isDuplicated);

  @override
  _$NewBookCopyWith<_NewBook> get copyWith =>
      __$NewBookCopyWithImpl<_NewBook>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required
        Result fromBookIndex(BookIndex bookIndex,
            @nullable Uri currentChapterUrl, bool isDuplicated),
  }) {
    assert(fromBookIndex != null);
    return fromBookIndex(bookIndex, currentChapterUrl, isDuplicated);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result fromBookIndex(BookIndex bookIndex, @nullable Uri currentChapterUrl,
        bool isDuplicated),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (fromBookIndex != null) {
      return fromBookIndex(bookIndex, currentChapterUrl, isDuplicated);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result fromBookIndex(_NewBook value),
  }) {
    assert(fromBookIndex != null);
    return fromBookIndex(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result fromBookIndex(_NewBook value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (fromBookIndex != null) {
      return fromBookIndex(this);
    }
    return orElse();
  }
}

abstract class _NewBook extends NewBook {
  _NewBook._() : super._();
  factory _NewBook(
      {@required BookIndex bookIndex,
      @nullable Uri currentChapterUrl,
      bool isDuplicated}) = _$_NewBook;

  @override
  BookIndex get bookIndex;
  @override
  @nullable
  Uri get currentChapterUrl;
  @override
  bool get isDuplicated;
  @override
  _$NewBookCopyWith<_NewBook> get copyWith;
}
