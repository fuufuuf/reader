import 'package:meta/meta.dart';
import 'package:reader/ng/models/Book.dart';
import 'package:reader/ng/models/Menu.dart';
import 'package:reader/ng/repositories/BookRepository.dart';

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
