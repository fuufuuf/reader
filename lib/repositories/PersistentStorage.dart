import 'package:built_collection/built_collection.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timnew_reader/models/BookIndex.dart';
import 'package:timnew_reader/repositories/settings/SharedPreferencesBookIndexExtension.dart';

class PersistentStorage {
  final SharedPreferences prefs;

  PersistentStorage(this.prefs);

  BuiltList<BookIndex> loadBookIndexList() => prefs.loadBookIndexList(prefs.loadBookIds()).toBuiltList();

  Future saveCurrentChapter(String bookId, Uri url) async {
    await prefs.saveCurrentChapter(bookId, url);
  }

  Future saveBookIndex(BookIndex bookIndex) async {
    await prefs.saveBookIndex(bookIndex);
  }

  Future saveBookList(List<String> bookIds) async {
    await prefs.saveBookIds(bookIds);
  }
}
