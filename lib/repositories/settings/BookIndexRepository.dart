import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:timnew_reader/models/BookIndex.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookIndexRepository {
  static SharedPreferences _prefs;
  static BuiltSet<String> _bookIds;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    _bookIds = _loadBookIds();
  }

  static const String _bookIdsKey = 'bookIds';

  static String _bookIndexKey(String bookId) => "$bookId.bookIndex";

  static String _currentChapterKey(String bookId) => "$bookId.currentChapter";

  static String _currentChapterProgress(String bookId) => "${_currentChapterKey(bookId)}.progress";

  static BookIndex load(String bookId) {
    final key = _bookIndexKey(bookId);

    final entryJson = _prefs.getString(key);
    final entryData = jsonDecode(entryJson);

    return BookIndex.fromJson(entryData);
  }

  static bool isBookExists(String bookId) {
    return _bookIds.contains(bookId);
  }

  static Future<void> save(BookIndex index) async {
    final key = _bookIndexKey(index.bookId);

    final rawData = index.toJson();
    final json = jsonEncode(rawData);

    await _prefs.setString(key, json);
    await _addBookIdIfNotExists(index.bookId);
  }

  static Future<void> remove(String bookId) async {
    await _prefs.remove(_bookIndexKey(bookId));
    await _prefs.remove(_currentChapterKey(bookId));
    await _prefs.remove(_currentChapterProgress(bookId));
    await _removeBookIdIfExists(bookId);
  }

  static Uri loadCurrentChapter(String bookId) {
    final urlString = _prefs.getString(_currentChapterKey(bookId));
    return urlString == null ? null : Uri.parse(urlString);
  }

  static Future<void> saveCurrentChapter(String bookId, Uri url) async {
    await _prefs.setString(_currentChapterKey(bookId), url.toString());
    await saveCurrentChapterProgress(bookId, 0);
  }

  static bool hasCurrentChapterUrl(String bookId) => _prefs.getString(_currentChapterKey(bookId)) != null;

  static double loadCurrentChapterProgress(String bookId) => _prefs.getDouble(_currentChapterProgress(bookId)) ?? 0;

  static Future<bool> saveCurrentChapterProgress(String bookId, double progress) =>
      _prefs.setDouble(_currentChapterProgress(bookId), progress);

  static BuiltList<BookIndex> loadAll() {
    final bookIds = _prefs.getStringList(_bookIdsKey) ?? [];

    return BuiltList.of(bookIds.map((bookId) => load(bookId)));
  }

  static BuiltList<String> exportAllBookUrls() => _loadBookIds()
      .map((id) => hasCurrentChapterUrl(id) ? loadCurrentChapter(id) : load(id).chapterListUrl)
      .map((it) => it.toString());

  static BuiltSet<String> _loadBookIds() {
    final ids = _prefs.getStringList(_bookIdsKey) ?? [];
    return BuiltSet.of(ids);
  }

  static Future<void> _saveBookIds(updates(SetBuilder<String> builder)) async {
    _bookIds = _bookIds.rebuild(updates);
    await _prefs.setStringList(_bookIdsKey, _bookIds.toList(growable: false));
  }

  static Future<void> _addBookIdIfNotExists(String bookId) async {
    if (!_bookIds.contains(bookId)) {
      await _saveBookIds((b) => b.add(bookId));
    }
  }

  static Future<void> _removeBookIdIfExists(String bookId) async {
    if (_bookIds.contains(bookId)) {
      await _saveBookIds((b) => b.remove(bookId));
    }
  }
}
