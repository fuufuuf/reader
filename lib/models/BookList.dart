import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'BookIndex.dart';

part 'BookList.g.dart';

abstract class BookList implements Built<BookList, BookListBuilder> {
  BookList._();

  SharedPreferences get sharedPrefs;

  BuiltSet<String> get bookIds;

  BuiltList<BookIndex> get books;

  factory BookList([updates(BookListBuilder b)]) = _$BookList;
}
