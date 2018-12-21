import 'package:built_collection/built_collection.dart';
import 'package:reader/models/BookEntry.dart';
import 'package:reader/repositories/settings/BookEntryRepository.dart';

class BookEntryList {
  BuiltList<BookEntry> _list;

  static Future<BookEntryList> create() async {
    await BookEntryRepository.init();

    return BookEntryList(BookEntryRepository.buildList());
  }

  BookEntryList(this._list);

  BuiltList<BookEntry> get entries => _list;

  void add(BookEntry newEntry) {
    final builder = _list.toBuilder()..add(newEntry);

    _list = builder.build();

    BookEntryRepository.saveEntry(newEntry);
    BookEntryRepository.saveList(entries);
  }

  void remove(BookEntry entry) {
    final builder = _list.toBuilder()..remove(entry);
    _list = builder.build();

    BookEntryRepository.saveList(entries);
    BookEntryRepository.removeEntry(entry.id);
  }

  void reload() {
    _list = BookEntryRepository.buildList();
  }
}
