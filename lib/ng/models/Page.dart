import 'package:meta/meta.dart';
import 'package:reader/ng/repositories/BookRepository.dart';

class Book {
  final Uri url;
  final String title;
  final String author;
  final Uri menuUrl;
  final Uri firstChapterUrl;
  final Uri latestChapterUrl;

  Book(
      {@required this.url,
      this.title,
      this.author,
      this.menuUrl,
      this.firstChapterUrl,
      this.latestChapterUrl});

  bool get hasMenu => menuUrl != null;

  Future<Menu> openMenu() => BookRepository.openMenu(menuUrl);

  bool get hasFirstChapter => firstChapterUrl != null;

  Future<Chapter> openFirstChapter() => BookRepository.openChapter(firstChapterUrl);

  bool get hasLatestChapter => latestChapterUrl != null;

  Future<Chapter> openLatestChapter() =>
      BookRepository.openChapter(latestChapterUrl);
}

class Menu {
  final Uri url;
  final String title;
  final List<ChapterIndex> chapters;
  final Uri bookUrl;

  Menu({@required this.url, this.title, this.chapters, this.bookUrl});

  Future<Book> openBook() => BookRepository.openBook(bookUrl);

  bool get hasChapters => chapters.isNotEmpty;

  Future<Chapter> openFirstChapter() => chapters.first.open();

  Future<Chapter> openLastChapter() => chapters.last.open();
}

class ChapterIndex {
  final Uri url;
  final String title;

  ChapterIndex({@required this.url, this.title});

  Future<Chapter> open() => BookRepository.openChapter(url, title);
}

class Chapter {
  final Uri url;
  final String title;
  final List<String> paragraphs;
  final Uri bookUrl;
  final Uri menuUrl;
  final Uri nextChapterUrl;
  final Uri previousChapterUrl;

  Chapter(
      {@required this.url,
      this.title,
      this.paragraphs,
      this.bookUrl,
      this.menuUrl,
      this.nextChapterUrl,
      this.previousChapterUrl});

  bool get hasBook => bookUrl != null;

  Future<Book> openBook() => BookRepository.openBook(bookUrl);

  bool get hasMenu => menuUrl != null;

  Future<Menu> openMenu() => BookRepository.openMenu(menuUrl);

  Future<Chapter> openPreviousChapter() =>
      BookRepository.openChapter(previousChapterUrl);

  Future<Chapter> openNextChapter() => BookRepository.openChapter(nextChapterUrl);
}
