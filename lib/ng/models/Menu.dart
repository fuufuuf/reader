import 'package:meta/meta.dart';

class Menu {
  final Uri url;
  final String title;
  final List<ChapterIndex> chapters;
  final Uri bookUrl;

  Menu({@required this.url, this.title, this.chapters, this.bookUrl});

  bool get hasChapters => chapters.isNotEmpty;

  bool get hasMultipleChapters => chapters.length > 1;

  bool get hasBook => bookUrl != null;

  Uri get firstChapterUrl => chapters.first.url;

  Uri get lastChapterUrl => chapters.last.url;
}

class ChapterIndex {
  final Uri url;
  final String title;

  ChapterIndex({@required this.url, this.title});
}
