import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:timnew_reader/app/InitStorage.dart';
import 'package:timnew_reader/arch/Store.dart';
import 'package:timnew_reader/models/BookIndex.dart';
import 'package:timnew_reader/repositories/PersistentStorage.dart';

class BookList extends ValueStore<BuiltList<BookIndex>> {
  final InitStorage initStorage;

  Future<PersistentStorage> get storage => initStorage.value;

  BookList(this.initStorage);

  @override
  Future<BuiltList<BookIndex>> initialize() async {
    final storage = await initStorage.value;

    return storage.loadBookIndexList();
  }

  Future<bool> isDuplicated(String bookId) async {
    final list = await value;
    return list.any((e) => e.bookId == bookId);
  }

  Future<BuiltList<BookIndex>> add(BookIndex bookIndex) async {
    final list = await value;

    final newList = list.rebuild((builder) => builder.add(bookIndex));

    final storage = await this.storage;

    await storage.saveBookList(newList.map((e) => e.bookId).toList());

    return putValue(newList, quiet: true);
  }
}
