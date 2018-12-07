import 'package:meta/meta.dart';
import 'package:reader/ng/models/Book.dart';
import 'package:reader/ng/models/Chapter.dart';
import 'package:reader/ng/repositories/BookRepository.dart';

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
