import 'package:meta/meta.dart';
import 'package:reader/ng/models/Chapter.dart';
import 'package:reader/ng/models/Menu.dart';
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

  Future<Chapter> openFirstChapter() =>
      BookRepository.openChapter(firstChapterUrl);

  bool get hasLatestChapter => latestChapterUrl != null;

  Future<Chapter> openLatestChapter() =>
      BookRepository.openChapter(latestChapterUrl);
}
