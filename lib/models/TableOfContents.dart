import 'package:meta/meta.dart';

class TableOfContents {
  final Uri url;
  final String title;
  final List<ChapterRef> chapters;
  final Uri bookUrl;

  TableOfContents({@required this.url, this.title, this.chapters, this.bookUrl});

  bool get hasChapters => chapters.isNotEmpty;

  bool get hasMultipleChapters => chapters.length > 1;

  bool get hasBook => bookUrl != null;

  Uri get firstChapterUrl => chapters.first.url;

  Uri get lastChapterUrl => chapters.last.url;
}

class ChapterRef {
  final Uri url;
  final String title;

  ChapterRef({@required this.url, this.title});
}
