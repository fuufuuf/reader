import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:timnew_reader/models/BookIndex.dart';
import 'package:timnew_reader/models/serializers.dart';

extension SharedPreferencesBookIndexExtension on SharedPreferences {
  static const String _bookIdsKey = 'bookIds';

  static String _bookIndexKey(String bookId) => "$bookId.bookIndex";

  static String _currentChapterKey(String bookId) => "$bookId.currentChapter";

  Iterable<BookIndex> loadBookIndexList(Iterable<String> ids) => ids.map((e) => loadBookIndex(e));

  BookIndex loadBookIndex(String bookId) {
    final key = _bookIndexKey(bookId);

    final entryJson = getString(key);
    final entryData = jsonDecode(entryJson);

    return serializers.deserializeWith(BookIndex.serializer, entryData);
  }

  Future<BookIndex> saveBookIndex(BookIndex index) async {
    final key = _bookIndexKey(index.bookId);

    final rawData = serializers.serializeWith(BookIndex.serializer, index);
    final json = jsonEncode(rawData);

    await setString(key, json);

    return index;
  }

  Future<bool> removeBookIndex(String bookId) async {
    return await remove(_bookIndexKey(bookId));
  }

  Uri loadCurrentChapter(String bookId) {
    final urlString = getString(_currentChapterKey(bookId));
    return urlString == null ? null : Uri.parse(urlString);
  }

  Future<void> saveCurrentChapter(String bookId, Uri url) async {
    await setString(_currentChapterKey(bookId), url.toString());
  }

  bool hasCurrentChapterUrl(String bookId) => getString(_currentChapterKey(bookId)) != null;

  Future removeBookCurrentChapter(String bookId) async {
    await remove(_currentChapterKey(bookId));
  }

  List<String> loadBookIds() => getStringList(_bookIdsKey) ?? List.empty(growable: false);

  Future saveBookIds(Iterable<String> ids) => setStringList(_bookIdsKey, ids);
}
