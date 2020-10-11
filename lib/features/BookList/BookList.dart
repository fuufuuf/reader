import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:timnew_reader/arch/Store.dart';
import 'package:timnew_reader/models/BookIndex.dart';
import 'package:timnew_reader/models/NewBook.dart';
import 'package:timnew_reader/repositories/PersistentStorage.dart';

class BookList extends ValueStore<BuiltList<BookIndex>> {
  final PersistentStorage storage;

  BookList(this.storage) : super(storage.loadBookIndexList());

  BuiltList<BookIndex> reload() {
    return putValue(storage.loadBookIndexList());
  }

  bool isDuplicated(String bookId) {
    return value.any((e) => e.bookId == bookId);
  }

  Future<BuiltList<BookIndex>> _updateBookList(Function(ListBuilder<BookIndex>) updates) async {
    final newList = value.rebuild(updates);

    putValue(newList);

    await storage.saveBookList(newList);

    return newList;
  }

  Future<BuiltList<BookIndex>> removeAtIndex(int index) async {
    return await _updateBookList((b) => b.removeAt(index));
  }

  Future<BuiltList<BookIndex>> addNewBooks(Iterable<NewBook> newBooks) async {
    final newBookIndexes = await Future.wait(newBooks.map((b) => _saveNewBook(b)));

    return _updateBookList((b) => b.addAll(newBookIndexes));
  }

  Future<BookIndex> _saveNewBook(NewBook newBook) async {
    await storage.saveNewBook(newBook);
    return newBook.bookIndex;
  }

  Future<BuiltList<BookIndex>> reorder(int oldIndex, int newIndex) async {
    return _updateBookList((b) {
      final amendedIndex = newIndex > oldIndex ? newIndex - 1 : newIndex; // remove old item would shift index for 1
      b.insert(amendedIndex, b.removeAt(oldIndex));
    });
  }
}
