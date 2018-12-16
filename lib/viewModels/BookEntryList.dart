import 'package:built_collection/built_collection.dart';
import 'package:reader/models/BookEntry.dart';
import 'package:reader/repositories/settings/BookEntryRepository.dart';

class BookEntryList {
  static Future<BookEntryList> create() async {
    final repo = await BookEntryRepository.open();
    return BookEntryList._(repo);
  }

  final BookEntryRepository _repository;
  BuiltList<BookEntry> _list;

  BookEntryList._(this._repository) {
    _list = _repository.buildList();
  }

  BuiltList<BookEntry> get entries => _list;

  void add(BookEntry newEntry) {
    final builder = _list.toBuilder()..add(newEntry);

    _list = builder.build();

    _repository.add(_list, newEntry);
  }

  void remove(BookEntry entry) {
    final builder = _list.toBuilder()..remove(entry);
    _list = builder.build();

    _repository.remove(_list, entry);
  }
}
