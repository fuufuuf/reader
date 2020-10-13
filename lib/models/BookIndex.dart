import 'dart:core';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:flutter/foundation.dart';

part 'BookIndex.g.dart';

abstract class BookIndex implements Built<BookIndex, BookIndexBuilder> {
  BookIndex._();

  String get bookId;

  String get bookName;

  Uri get chapterListUrl;

  Uri get bookInfoUrl;

  factory BookIndex({
    @required String bookId,
    @required String bookName,
    @required Uri bookInfoUrl,
    @required Uri chapterListUrl,
  }) =>
      _$BookIndex((b) => b
        ..bookId = bookId
        ..bookName = bookName
        ..bookInfoUrl = bookInfoUrl
        ..chapterListUrl = chapterListUrl);

  static Serializer<BookIndex> get serializer => _$bookIndexSerializer;
}
