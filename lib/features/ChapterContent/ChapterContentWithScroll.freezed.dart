// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'ChapterContentWithScroll.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$ChapterContentWithScrollTearOff {
  const _$ChapterContentWithScrollTearOff();

// ignore: unused_element
  _ChapterContentWithScroll call(
      {@required ChapterContent chapter, @required ScrollTarget scrollTarget}) {
    return _ChapterContentWithScroll(
      chapter: chapter,
      scrollTarget: scrollTarget,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $ChapterContentWithScroll = _$ChapterContentWithScrollTearOff();

/// @nodoc
mixin _$ChapterContentWithScroll {
  ChapterContent get chapter;
  ScrollTarget get scrollTarget;

  $ChapterContentWithScrollCopyWith<ChapterContentWithScroll> get copyWith;
}

/// @nodoc
abstract class $ChapterContentWithScrollCopyWith<$Res> {
  factory $ChapterContentWithScrollCopyWith(ChapterContentWithScroll value,
          $Res Function(ChapterContentWithScroll) then) =
      _$ChapterContentWithScrollCopyWithImpl<$Res>;
  $Res call({ChapterContent chapter, ScrollTarget scrollTarget});

  $ChapterContentCopyWith<$Res> get chapter;
  $ScrollTargetCopyWith<$Res> get scrollTarget;
}

/// @nodoc
class _$ChapterContentWithScrollCopyWithImpl<$Res>
    implements $ChapterContentWithScrollCopyWith<$Res> {
  _$ChapterContentWithScrollCopyWithImpl(this._value, this._then);

  final ChapterContentWithScroll _value;
  // ignore: unused_field
  final $Res Function(ChapterContentWithScroll) _then;

  @override
  $Res call({
    Object chapter = freezed,
    Object scrollTarget = freezed,
  }) {
    return _then(_value.copyWith(
      chapter: chapter == freezed ? _value.chapter : chapter as ChapterContent,
      scrollTarget: scrollTarget == freezed
          ? _value.scrollTarget
          : scrollTarget as ScrollTarget,
    ));
  }

  @override
  $ChapterContentCopyWith<$Res> get chapter {
    if (_value.chapter == null) {
      return null;
    }
    return $ChapterContentCopyWith<$Res>(_value.chapter, (value) {
      return _then(_value.copyWith(chapter: value));
    });
  }

  @override
  $ScrollTargetCopyWith<$Res> get scrollTarget {
    if (_value.scrollTarget == null) {
      return null;
    }
    return $ScrollTargetCopyWith<$Res>(_value.scrollTarget, (value) {
      return _then(_value.copyWith(scrollTarget: value));
    });
  }
}

/// @nodoc
abstract class _$ChapterContentWithScrollCopyWith<$Res>
    implements $ChapterContentWithScrollCopyWith<$Res> {
  factory _$ChapterContentWithScrollCopyWith(_ChapterContentWithScroll value,
          $Res Function(_ChapterContentWithScroll) then) =
      __$ChapterContentWithScrollCopyWithImpl<$Res>;
  @override
  $Res call({ChapterContent chapter, ScrollTarget scrollTarget});

  @override
  $ChapterContentCopyWith<$Res> get chapter;
  @override
  $ScrollTargetCopyWith<$Res> get scrollTarget;
}

/// @nodoc
class __$ChapterContentWithScrollCopyWithImpl<$Res>
    extends _$ChapterContentWithScrollCopyWithImpl<$Res>
    implements _$ChapterContentWithScrollCopyWith<$Res> {
  __$ChapterContentWithScrollCopyWithImpl(_ChapterContentWithScroll _value,
      $Res Function(_ChapterContentWithScroll) _then)
      : super(_value, (v) => _then(v as _ChapterContentWithScroll));

  @override
  _ChapterContentWithScroll get _value =>
      super._value as _ChapterContentWithScroll;

  @override
  $Res call({
    Object chapter = freezed,
    Object scrollTarget = freezed,
  }) {
    return _then(_ChapterContentWithScroll(
      chapter: chapter == freezed ? _value.chapter : chapter as ChapterContent,
      scrollTarget: scrollTarget == freezed
          ? _value.scrollTarget
          : scrollTarget as ScrollTarget,
    ));
  }
}

/// @nodoc
class _$_ChapterContentWithScroll extends _ChapterContentWithScroll {
  _$_ChapterContentWithScroll(
      {@required this.chapter, @required this.scrollTarget})
      : assert(chapter != null),
        assert(scrollTarget != null),
        super._();

  @override
  final ChapterContent chapter;
  @override
  final ScrollTarget scrollTarget;

  @override
  String toString() {
    return 'ChapterContentWithScroll(chapter: $chapter, scrollTarget: $scrollTarget)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ChapterContentWithScroll &&
            (identical(other.chapter, chapter) ||
                const DeepCollectionEquality()
                    .equals(other.chapter, chapter)) &&
            (identical(other.scrollTarget, scrollTarget) ||
                const DeepCollectionEquality()
                    .equals(other.scrollTarget, scrollTarget)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(chapter) ^
      const DeepCollectionEquality().hash(scrollTarget);

  @override
  _$ChapterContentWithScrollCopyWith<_ChapterContentWithScroll> get copyWith =>
      __$ChapterContentWithScrollCopyWithImpl<_ChapterContentWithScroll>(
          this, _$identity);
}

abstract class _ChapterContentWithScroll extends ChapterContentWithScroll {
  _ChapterContentWithScroll._() : super._();
  factory _ChapterContentWithScroll(
      {@required ChapterContent chapter,
      @required ScrollTarget scrollTarget}) = _$_ChapterContentWithScroll;

  @override
  ChapterContent get chapter;
  @override
  ScrollTarget get scrollTarget;
  @override
  _$ChapterContentWithScrollCopyWith<_ChapterContentWithScroll> get copyWith;
}
