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
  _ChapterList fromBookIndex(
      {@required BookIndex bookIndex,
      @required BuiltList<ChapterRef> chapters}) {
    return _ChapterList(
      bookIndex: bookIndex,
      chapters: chapters,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $ChapterList = _$ChapterListTearOff();

/// @nodoc
mixin _$ChapterList {
  BookIndex get bookIndex;
  BuiltList<ChapterRef> get chapters;

  @optionalTypeArgs
  Result when<Result extends Object>({
    @required
        Result fromBookIndex(
            BookIndex bookIndex, BuiltList<ChapterRef> chapters),
  });
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result fromBookIndex(BookIndex bookIndex, BuiltList<ChapterRef> chapters),
    @required Result orElse(),
  });
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result fromBookIndex(_ChapterList value),
  });
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result fromBookIndex(_ChapterList value),
    @required Result orElse(),
  });

  $ChapterListCopyWith<ChapterList> get copyWith;
}

/// @nodoc
abstract class $ChapterListCopyWith<$Res> {
  factory $ChapterListCopyWith(
          ChapterList value, $Res Function(ChapterList) then) =
      _$ChapterListCopyWithImpl<$Res>;
  $Res call({BookIndex bookIndex, BuiltList<ChapterRef> chapters});

  $BookIndexCopyWith<$Res> get bookIndex;
}

/// @nodoc
class _$ChapterListCopyWithImpl<$Res> implements $ChapterListCopyWith<$Res> {
  _$ChapterListCopyWithImpl(this._value, this._then);

  final ChapterList _value;
  // ignore: unused_field
  final $Res Function(ChapterList) _then;

  @override
  $Res call({
    Object bookIndex = freezed,
    Object chapters = freezed,
  }) {
    return _then(_value.copyWith(
      bookIndex:
          bookIndex == freezed ? _value.bookIndex : bookIndex as BookIndex,
      chapters: chapters == freezed
          ? _value.chapters
          : chapters as BuiltList<ChapterRef>,
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
abstract class _$ChapterListCopyWith<$Res>
    implements $ChapterListCopyWith<$Res> {
  factory _$ChapterListCopyWith(
          _ChapterList value, $Res Function(_ChapterList) then) =
      __$ChapterListCopyWithImpl<$Res>;
  @override
  $Res call({BookIndex bookIndex, BuiltList<ChapterRef> chapters});

  @override
  $BookIndexCopyWith<$Res> get bookIndex;
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
    Object bookIndex = freezed,
    Object chapters = freezed,
  }) {
    return _then(_ChapterList(
      bookIndex:
          bookIndex == freezed ? _value.bookIndex : bookIndex as BookIndex,
      chapters: chapters == freezed
          ? _value.chapters
          : chapters as BuiltList<ChapterRef>,
    ));
  }
}

/// @nodoc
class _$_ChapterList extends _ChapterList {
  _$_ChapterList({@required this.bookIndex, @required this.chapters})
      : assert(bookIndex != null),
        assert(chapters != null),
        super._();

  @override
  final BookIndex bookIndex;
  @override
  final BuiltList<ChapterRef> chapters;

  @override
  String toString() {
    return 'ChapterList.fromBookIndex(bookIndex: $bookIndex, chapters: $chapters)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ChapterList &&
            (identical(other.bookIndex, bookIndex) ||
                const DeepCollectionEquality()
                    .equals(other.bookIndex, bookIndex)) &&
            (identical(other.chapters, chapters) ||
                const DeepCollectionEquality()
                    .equals(other.chapters, chapters)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(bookIndex) ^
      const DeepCollectionEquality().hash(chapters);

  @override
  _$ChapterListCopyWith<_ChapterList> get copyWith =>
      __$ChapterListCopyWithImpl<_ChapterList>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required
        Result fromBookIndex(
            BookIndex bookIndex, BuiltList<ChapterRef> chapters),
  }) {
    assert(fromBookIndex != null);
    return fromBookIndex(bookIndex, chapters);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result fromBookIndex(BookIndex bookIndex, BuiltList<ChapterRef> chapters),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (fromBookIndex != null) {
      return fromBookIndex(bookIndex, chapters);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result fromBookIndex(_ChapterList value),
  }) {
    assert(fromBookIndex != null);
    return fromBookIndex(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result fromBookIndex(_ChapterList value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (fromBookIndex != null) {
      return fromBookIndex(this);
    }
    return orElse();
  }
}

abstract class _ChapterList extends ChapterList {
  _ChapterList._() : super._();
  factory _ChapterList(
      {@required BookIndex bookIndex,
      @required BuiltList<ChapterRef> chapters}) = _$_ChapterList;

  @override
  BookIndex get bookIndex;
  @override
  BuiltList<ChapterRef> get chapters;
  @override
  _$ChapterListCopyWith<_ChapterList> get copyWith;
}
