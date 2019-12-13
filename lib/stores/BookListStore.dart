import 'package:built_collection/built_collection.dart';
import 'package:flutter/widgets.dart';
import 'package:timnew_reader/legacy/models/BookIndex.dart';

class BookListStore extends InheritedWidget {
  final BuiltList<BookIndex> books;

  BookListStore(this.books);

  @override
  bool updateShouldNotify(BookListStore oldWidget) => oldWidget.books != books;
}
