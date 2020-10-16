import 'package:built_collection/built_collection.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timnew_reader/arch/SIngletonRegistry.dart';
import 'package:timnew_reader/features/ChapterContent/ScrollTarget.dart';
import 'package:timnew_reader/models/BookIndex.dart';
import 'package:timnew_reader/models/NewBook.dart';
import 'package:timnew_reader/repositories/settings/SharedPreferencesBookIndexExtension.dart';

class PersistentStorage {
  static PersistentStorage get instance => SingletonRegistry.get();

  static Future<PersistentStorage> initialize() async {
    final prefs = await SharedPreferences.getInstance();
    return SingletonRegistry.register(PersistentStorage(prefs));
  }

  final SharedPreferences prefs;

  PersistentStorage(this.prefs);

  BuiltList<BookIndex> loadBookIndexList() {
    try {
      final bookIds = prefs.loadBookIds();

      final bookIndexList = prefs.loadBookIndexList(bookIds);

      return bookIndexList.toBuiltList();
    } catch (ex, stackTrace) {
      print(ex);
      print(stackTrace);
      rethrow;
    }
  }

  bool hasCurrentChapter(BookIndex bookIndex) => prefs.hasCurrentChapterUrl(bookIndex.bookId);

  Uri getCurrentChapterUrl(BookIndex bookIndex) => prefs.loadCurrentChapterUrl(bookIndex.bookId);

  ScrollTarget getCurrentParagraphIndex(BookIndex bookIndex) =>
      ScrollTarget.paragraph(prefs.loadCurrentParagraphIndex(bookIndex.bookId));

  Future saveCurrentChapter(BookIndex bookIndex, Uri url) async {
    await prefs.saveCurrentChapterUrl(bookIndex.bookId, url);
    await prefs.removeBookCurrentParagraphIndex(bookIndex.bookId);
  }

  Future saveCurrentParagraph(BookIndex bookIndex, int paragraphIndex) async {
    await prefs.saveCurrentParagraphIndex(bookIndex.bookId, paragraphIndex);
  }

  Future saveBookIndex(BookIndex bookIndex) async {
    await prefs.saveBookIndex(bookIndex);
  }

  Future<NewBook> saveNewBook(NewBook newBook) async {
    await saveBookIndex(newBook.bookIndex);

    if (newBook.hasCurrentChapterUrl) {
      await saveCurrentChapter(newBook.bookIndex, newBook.currentChapterUrl);
    }

    return newBook;
  }

  Future<bool> saveBookList(Iterable<BookIndex> bookIndexes) async {
    return await prefs.saveBookIds(bookIndexes.map((e) => e.bookId));
  }
}

extension BookIndexStorageExtension on BookIndex {
  bool get hasCurrentChapter => PersistentStorage.instance.hasCurrentChapter(this);

  Uri get currentChapterUrl => PersistentStorage.instance.getCurrentChapterUrl(this);

  ScrollTarget get currentParagraph => PersistentStorage.instance.getCurrentParagraphIndex(this);

  Future saveCurrentChapter(Uri currentChapterUrl) =>
      PersistentStorage.instance.saveCurrentChapter(this, currentChapterUrl);

  Future saveCurrentParagraph(int currentParagraphIndex) =>
      PersistentStorage.instance.saveCurrentParagraph(this, currentParagraphIndex);
}
