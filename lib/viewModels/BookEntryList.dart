import 'package:built_collection/built_collection.dart';
import 'package:reader/models/BookEntry.dart';
import 'package:reader/repositories/settings/BookEntryRepository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookEntryList {
  static Future<BookEntryList> create() async {
    return BookEntryList._(await SharedPreferences.getInstance());
  }

  final SharedPreferences _prefs;
  BuiltList<BookEntry> _list;

  BookEntryList._(this._prefs) {
    _list = BookEntryRepository.buildList(_prefs);
  }

  BuiltList<BookEntry> get entries => _list;

  void add(BookEntry newEntry) {
    final builder = _list.toBuilder()..add(newEntry);

    _list = builder.build();

    BookEntryRepository.saveEntry(_prefs, newEntry);
    BookEntryRepository.saveList(_prefs, entries);
  }

  void remove(BookEntry entry) {
    final builder = _list.toBuilder()..remove(entry);
    _list = builder.build();

    BookEntryRepository.saveList(_prefs, entries);
    BookEntryRepository.removeEntry(_prefs, entry.id);
  }
}
