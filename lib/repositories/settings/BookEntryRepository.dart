import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:reader/models/BookEntry.dart';
import 'package:reader/models/serializers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookEntryRepository {
  static const listKey = 'bookEntryIds';
  static const bookEntryPrefix = 'bookEntry';

  static Future<BuiltList<BookEntry>> fetchAll() async {
    final prefs = await SharedPreferences.getInstance();

    return _parseAllEntries(prefs);
  }

  static Future<BuiltList<BookEntry>> addBookEntry(
      BuiltList<BookEntry> entries, BookEntry entry) async {
    final prefs = await SharedPreferences.getInstance();

    await _saveEntry(prefs, entry);

    final builder = entries.toBuilder()..add(entry);

    return _saveList(prefs, builder.build());
  }

  static Future<BuiltList<BookEntry>> updateBookEntry(
          BuiltList<BookEntry> entries,
          BookEntry entry,
          void updates(BookEntryBuilder b)) =>
      updateBookEntryByIndex(entries, entries.indexOf(entry), updates);

  static Future<BuiltList<BookEntry>> updateBookEntryByCondition(
          BuiltList<BookEntry> entries,
          bool criteria(BookEntry e),
          void updates(BookEntryBuilder b)) =>
      updateBookEntryByIndex(entries, entries.indexWhere(criteria), updates);

  static Future<BuiltList<BookEntry>> updateBookEntryByIndex(
      BuiltList<BookEntry> entries,
      int index,
      void updates(BookEntryBuilder b)) async {
    final prefs = await SharedPreferences.getInstance();

    final builder = entries.toBuilder();

    final entryBuilder = builder[index].toBuilder()..update(updates);
    builder[index] = await _saveEntry(prefs, entryBuilder.build());

    return builder.build();
  }

  static Future<BuiltList<BookEntry>> removeBookEntryByIndex(
      BuiltList<BookEntry> entries, int index) async {
    final prefs = await SharedPreferences.getInstance();

    await _removeEntry(prefs, entries[index].id);

    final builder = entries.toBuilder()..removeAt(index);

    return _saveList(prefs, builder.build());
  }

  static BuiltList<BookEntry> _parseAllEntries(SharedPreferences prefs) {
    final ids = prefs.getStringList(listKey) ?? [];

    return BuiltList<BookEntry>.of(ids.map((id) => _parseBookEntry(prefs, id)));
  }

  static BookEntry _parseBookEntry(SharedPreferences prefs, String id) {
    final key = _entryKey(id);

    final entryJson = prefs.get(key);
    final entryData = jsonDecode(entryJson);

    return serializers.deserializeWith(BookEntry.serializer, entryData);
  }

  static String _entryKey(String id) => "$bookEntryPrefix-$id";

  static Future<BookEntry> _saveEntry(
      SharedPreferences prefs, BookEntry entry) async {
    final key = _entryKey(entry.id);

    final entryData = serializers.serializeWith(BookEntry.serializer, entry);
    final entryJson = jsonEncode(entryData);

    await prefs.setString(key, entryJson);

    return entry;
  }

  static Future<bool> _removeEntry(SharedPreferences prefs, String id) =>
      prefs.remove(_entryKey(id));

  static Future<BuiltList<BookEntry>> _saveList(
      SharedPreferences prefs, BuiltList<BookEntry> entries) async {
    final List<String> ids =
        entries.map((entry) => entry.id).toList(growable: false);
    await prefs.setStringList(listKey, ids);
    return entries;
  }
}
