import 'package:meta/meta.dart';

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

  bool get hasFirstChapter => firstChapterUrl != null;

  bool get hasLatestChapter => latestChapterUrl != null;
}
