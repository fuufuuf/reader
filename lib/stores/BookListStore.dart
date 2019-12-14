import 'package:built_collection/built_collection.dart';
import 'package:flutter/widgets.dart';
import 'package:timnew_reader/models/book_models.dart';

class BookListStore extends InheritedWidget {
  final BuiltList<BookIndex> books;

  BookListStore(this.books, Widget child) : super(
      key: const ObjectKey(BookListStore),
      child: child
  );

  @override
  bool updateShouldNotify(BookListStore oldWidget) => oldWidget.books != books;

  static BookListStore of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<BookListStore>();
}
