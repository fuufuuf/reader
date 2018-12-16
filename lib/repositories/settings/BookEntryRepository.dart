import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:reader/models/BookEntry.dart';
import 'package:reader/models/serializers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookEntryRepository {
  static const listKey = 'bookEntryIds';
  static const bookEntryPrefix = 'bookEntry';

  static Future<T> invokeEntry<T>(String bookId,
      Future<T> invoker(BookEntry entry)) async {
    final prefs = await SharedPreferences.getInstance();

    final entry = buildEntry(prefs, bookId);

    return invoker(entry);
  }

  static String _entryKey(String id) => "$bookEntryPrefix-$id";

  static BuiltList<BookEntry> buildList(SharedPreferences prefs) {
    final ids = prefs.getStringList(listKey) ?? [];

    return BuiltList.of(ids.map((id) => buildEntry(prefs, id)));
  }

  static Future<bool> saveList(SharedPreferences prefs,
      Iterable<BookEntry> entries) {
    final List<String> ids =
    entries.map((entry) => entry.id).toList(growable: false);
    return prefs.setStringList(listKey, ids);
  }

  static BookEntry buildEntry(SharedPreferences prefs, String id) {
    final key = _entryKey(id);

    final entryJson = prefs.getString(key);
    final entryData = jsonDecode(entryJson);

    return serializers.deserializeWith(BookEntry.serializer, entryData);
  }

  static Future<bool> saveEntry(SharedPreferences prefs, BookEntry entry) {
    final key = _entryKey(entry.id);

    final entryData = serializers.serializeWith(BookEntry.serializer, entry);
    final entryJson = jsonEncode(entryData);

    return prefs.setString(key, entryJson);
  }

  static Future<bool> removeEntry(SharedPreferences prefs, String id) =>
      prefs.remove(_entryKey(id));
}
