import 'package:meta/meta.dart';

class ChapterContent {
  final Uri url;
  final String title;
  final List<String> paragraphs;
  final Uri bookUrl;
  final Uri menuUrl;
  final Uri nextChapterUrl;
  final Uri previousChapterUrl;

  ChapterContent(
      {@required this.url,
      this.title,
      this.paragraphs,
      this.bookUrl,
      this.menuUrl,
      this.nextChapterUrl,
      this.previousChapterUrl});

  bool get hasBook => bookUrl != null;
  bool get hasMenu => menuUrl != null;

  bool get hasPrevious => previousChapterUrl != null;

  bool get hasNext => nextChapterUrl != null;
}
