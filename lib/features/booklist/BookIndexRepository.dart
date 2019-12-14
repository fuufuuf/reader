import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timnew_reader/models/book_models.dart';
import 'package:timnew_reader/models/serializers.dart';

class BookIndexRepository {
  static Future<BuiltList<BookIndex>> loadAllBooks() async {
    final prefs = await SharedPreferences.getInstance();

    final bookIds = _loadBookIdList(prefs);

    return bookIds.map((id) => _load(prefs, id)).toBuiltList();
  }

  static Future<bool> saveBookListOrder(BuiltList<BookIndex> bookList) async {
    final prefs = await SharedPreferences.getInstance();

    return _saveBookIdList(prefs, bookList);
  }

  static Future<void> addBook(
      BuiltList<BookIndex> bookList, BookIndex added) async {
    final prefs = await SharedPreferences.getInstance();

    return await _update(prefs, added) &&
        await _saveBookIdList(prefs, bookList);
  }

  static Future<void> removeBook(
      BuiltList<BookIndex> bookList, String removedId) async {
    final prefs = await SharedPreferences.getInstance();

    return await _remove(prefs, removedId) &&
        await _saveBookIdList(prefs, bookList);
  }

  static const String _bookIdsKey = 'bookIds';

  static String _bookIndexKey(String bookId) => "$bookId.bookIndex";

  static String _currentChapterKey(String bookId) => "$bookId.currentChapter";

  static List<String> _loadBookIdList(SharedPreferences prefs) =>
      prefs.getStringList(_bookIdsKey) ?? [];

  static Future<bool> _saveBookIdList(
      SharedPreferences prefs, Iterable<BookIndex> bookList) {
    final bookIds = bookList.map((book) => book.id).toList(growable: false);

    return prefs.setStringList(_bookIdsKey, bookIds);
  }

  static BookIndex _load(SharedPreferences prefs, String bookId) {
    final key = _bookIndexKey(bookId);

    final entryJson = prefs.getString(key);
    final entryData = jsonDecode(entryJson);

    return serializers.deserializeWith<BookIndex>(
        BookIndex.serializer, entryData);
  }

  static Future<bool> _update(SharedPreferences prefs, BookIndex book) async {
    final key = _bookIndexKey(book.id);

    final rawData = serializers.serializeWith(BookIndex.serializer, book);
    final json = jsonEncode(rawData);

    return prefs.setString(key, json);
  }

  static Future<bool> _remove(SharedPreferences prefs, String bookId) async {
    return await prefs.remove(_bookIndexKey(bookId)) ||
        await prefs.remove(_currentChapterKey(bookId));
  }
}
