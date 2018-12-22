import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:reader/models/BookEntry.dart';
import 'package:reader/models/BookIndex.dart';
import 'package:reader/models/serializers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookEntryRepository {
  static const _listKey = 'bookEntryIds';
  static const _bookEntryPrefix = 'bookEntry';
  static const _bookChapterUrlPrefix = 'bookChapter';
  static const _bookChapterProgressPrefix = 'bookChapterProgress';

  static SharedPreferences _prefs;

  static bool get isInitialized => _prefs != null;

  static Future<SharedPreferences> init() async {
    _prefs = await SharedPreferences.getInstance();

//    await _migrate(); // TODO: Clean up

    return _prefs;
  }

  static Future<void> initAndMigrate(SharedPreferences prefs) async {
    _prefs = prefs;

    await _migrate();
  }

  static Future<void> _migrate() async {
    // TODO: Clean up
    final list = buildList();

    final allChanges = list
        .where((entry) => entry.hasCurrentChapter)
        .map((entry) async {
      final bookIndex = BookIndex((b) =>
      b
        ..bookId = entry.id
        ..bookName = entry.bookName
        ..chapterListUrl = entry.chapterListUrl
        ..bookInfoUrl = entry.bookInfoUrl
      );

      await bookIndex.save();
      if (entry.hasCurrentChapter) {
        await bookIndex.setCurrentChapter(entry.currentChapterUrl);
      }

      await removeEntry(entry.id);
    });

    await Future.wait(allChanges);

    await _prefs.remove(_listKey);
  }

  static String _entryKey(String id) =>
      "$_bookEntryPrefix-$id";

  static String _chapterProgressKey(String id) =>
      "$_bookChapterProgressPrefix-$id";

  static String _chapterKey(String id) =>
      "$_bookChapterUrlPrefix-$id";

  static BookEntry fetchEntry(String id) {
    final key = _entryKey(id);

    final entryJson = _prefs.getString(key);
    final entryData = jsonDecode(entryJson);

    return serializers.deserializeWith(BookEntry.serializer, entryData);
  }

  static Future<bool> saveEntry(BookEntry entry) {
    final key = _entryKey(entry.id);

    final entryData = serializers.serializeWith(BookEntry.serializer, entry);
    final entryJson = jsonEncode(entryData);

    return _prefs.setString(key, entryJson);
  }

  static Future<bool> removeEntry(String id) async {
    return await _prefs.remove(_entryKey(id)) &&
        await _prefs.remove(_chapterKey(id)) &&
        await _prefs.remove(_chapterProgressKey(id));
  }

  static Uri fetchCurrentChapterUrl(String id) {
    final urlString = _prefs.getString(_chapterKey(id));
    return urlString == null ? null : Uri.parse(urlString);
  }

  static Future<bool> saveCurrentChapterUrl(String id, Uri url) =>
      _prefs.setString(_chapterKey(id), url.toString());

  static bool hasCurrentChapterUrl(String id) =>
      _prefs.getString(_chapterKey(id)) != null;

  static double fetchChapterProgress(String id) =>
      _prefs.getDouble(_chapterProgressKey(id)) ?? 0;

  static Future<bool> saveChapterProgress(String id, double progress) =>
      _prefs.setDouble(_chapterProgressKey(id), progress);

  static BuiltList<BookEntry> buildList() {
    final ids = _prefs.getStringList(_listKey) ?? [];

    return BuiltList.of(ids.map((id) => fetchEntry(id)));
  }

  static Future<bool> saveList(Iterable<BookEntry> entries) {
    final List<String> ids =
    entries.map((entry) => entry.id).toList(growable: false);
    return _prefs.setStringList(_listKey, ids);
  }
}
