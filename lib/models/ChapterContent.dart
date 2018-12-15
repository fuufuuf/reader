import 'package:meta/meta.dart';

class ChapterContent {
  final Uri url;
  final String title;
  final List<String> paragraphs;
  final Uri menuUrl;
  final Uri nextChapterUrl;
  final Uri previousChapterUrl;

  ChapterContent(
      {@required this.url,
      this.title,
      this.paragraphs,
      this.menuUrl,
      this.nextChapterUrl,
      this.previousChapterUrl});

  bool get hasMenu => menuUrl != null;

  bool get hasPrevious => previousChapterUrl != null;

  bool get hasNext => nextChapterUrl != null;
}
