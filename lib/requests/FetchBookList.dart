import 'package:shared_preferences/shared_preferences.dart';
import 'package:timnew_reader/models/BookList.dart';

import 'package:timnew_reader/repositories/settings/SharedPreferencesBookIndexExtension.dart';

import '../arch/Store.dart';

class FetchBookList extends Store<BookList> {
  final SharedPreferences shardPrefs;

  FetchBookList(this.shardPrefs);

  @override
  BookList initialize() {
    final bookIds = shardPrefs.loadBookIds();

    return BookList((b) => b
      ..sharedPrefs = shardPrefs
      ..bookIds.addAll(bookIds)
      ..books.addAll(shardPrefs.loadBookIndexList(bookIds)));
  }
}
