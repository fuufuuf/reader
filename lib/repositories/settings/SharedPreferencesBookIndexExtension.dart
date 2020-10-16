import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:timnew_reader/models/BookIndex.dart';

extension SharedPreferencesBookIndexExtension on SharedPreferences {
  static const String _bookIdsKey = 'bookIds';

  List<String> loadBookIds() => getStringList(_bookIdsKey) ?? List.empty(growable: false);

  Future saveBookIds(Iterable<String> ids) => setStringList(_bookIdsKey, ids.toList());

  static String _bookIndexKey(String bookId) => "$bookId.bookIndex";

  Iterable<BookIndex> loadBookIndexList(Iterable<String> ids) => ids.map((e) => loadBookIndex(e));

  BookIndex loadBookIndex(String bookId) {
    final key = _bookIndexKey(bookId);

    final entryJson = getString(key);
    final entryData = jsonDecode(entryJson);

    return BookIndex.fromJson(entryData);
  }

  Future<BookIndex> saveBookIndex(BookIndex index) async {
    final key = _bookIndexKey(index.bookId);

    final rawData = index.toJson();
    final json = jsonEncode(rawData);

    await setString(key, json);

    return index;
  }

  Future<bool> removeBookIndex(String bookId) async {
    return await remove(_bookIndexKey(bookId));
  }

  static String _currentChapterUrlKey(String bookId) => "$bookId.currentChapter";

  Uri loadCurrentChapterUrl(String bookId) {
    final urlString = getString(_currentChapterUrlKey(bookId));
    return urlString == null ? null : Uri.parse(urlString);
  }

  Future<void> saveCurrentChapterUrl(String bookId, Uri url) async {
    await setString(_currentChapterUrlKey(bookId), url.toString());
  }

  bool hasCurrentChapterUrl(String bookId) => getString(_currentChapterUrlKey(bookId)) != null;

  Future removeBookCurrentChapterUrl(String bookId) async {
    await remove(_currentChapterUrlKey(bookId));
  }

  static String _currentParagraphIndex(String bookId) => "$bookId.currentParagraph";

  int loadCurrentParagraphIndex(String bookId) => getInt(_currentParagraphIndex(bookId)) ?? 0;

  Future<void> saveCurrentParagraphIndex(String bookId, int index) async {
    await setInt(_currentParagraphIndex(bookId), index);
  }

  Future removeBookCurrentParagraphIndex(String bookId) async {
    await remove(_currentParagraphIndex(bookId));
  }
}
