import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:reader/models/BookEntry.dart';
import 'package:reader/models/serializers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookEntryRepository {
  static const listKey = 'bookEntryIds';
  static const bookEntryPrefix = 'bookEntry';

  static SharedPreferences _prefs;

  static bool get isInitialized => _prefs != null;

  static Future<SharedPreferences> init() async {
    return _prefs = await SharedPreferences.getInstance();
  }

  static String _entryKey(String id) => "$bookEntryPrefix-$id";

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

  static Future<bool> removeEntry(String id) =>
      _prefs.remove(_entryKey(id));

  static BuiltList<BookEntry> buildList() {
    final ids = _prefs.getStringList(listKey) ?? [];

    return BuiltList.of(ids.map((id) => fetchEntry(id)));
  }

  static Future<bool> saveList(Iterable<BookEntry> entries) {
    final List<String> ids =
    entries.map((entry) => entry.id).toList(growable: false);
    return _prefs.setStringList(listKey, ids);
  }
}
