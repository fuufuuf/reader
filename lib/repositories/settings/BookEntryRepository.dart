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

    final entry = _parseBookEntry(prefs, bookId);

    return invoker(entry);
  }

  static Future<BookEntryRepository> open() async {
    final prefs = await SharedPreferences.getInstance();

    return BookEntryRepository._(prefs);
  }

  SharedPreferences _prefs;

  BookEntryRepository._(this._prefs);

  BuiltList<BookEntry> buildList() {
    final ids = _prefs.getStringList(listKey) ?? [];

    return BuiltList.of(ids.map((id) => _parseBookEntry(_prefs, id)));
  }

  Future<void> add(BuiltList<BookEntry> list, BookEntry entry) async {
    await _saveEntry(entry);
    await _saveList(list);
  }

  void remove(BuiltList<BookEntry> list, BookEntry entry) async {
    await _removeEntry(entry.id);
    await _saveList(list);
  }

  static String _entryKey(String id) => "$bookEntryPrefix-$id";

  static BookEntry _parseBookEntry(SharedPreferences prefs, String id) {
    final key = _entryKey(id);

    final entryJson = prefs.get(key);
    final entryData = jsonDecode(entryJson);

    return serializers.deserializeWith(BookEntry.serializer, entryData);
  }

  Future<bool> _saveEntry(BookEntry entry) {
    final key = _entryKey(entry.id);

    final entryData = serializers.serializeWith(BookEntry.serializer, entry);
    final entryJson = jsonEncode(entryData);

    return _prefs.setString(key, entryJson);
  }

  Future<bool> _saveList(BuiltList<BookEntry> entries) {
    final List<String> ids =
        entries.map((entry) => entry.id).toList(growable: false);
    return _prefs.setStringList(listKey, ids);
  }

  Future<bool> _removeEntry(String id) =>
      _prefs.remove(_entryKey(id));
}
