import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:timnew_reader/arch/Store.dart';
import 'package:timnew_reader/models/BookIndex.dart';
import 'package:timnew_reader/repositories/PersistentStorage.dart';

class BookList extends ValueStore<BuiltList<BookIndex>> {
  final PersistentStorage storage;

  BookList(this.storage) : super(storage.loadBookIndexList());

  bool isDuplicated(String bookId) {
    return value.any((e) => e.bookId == bookId);
  }

  Future<BuiltList<BookIndex>> add(BookIndex bookIndex) async {
    final newList = value.rebuild((builder) => builder.add(bookIndex));

    await storage.saveBookList(newList.map((e) => e.bookId).toList());

    return putValue(newList);
  }
}
