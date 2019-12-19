part of 'ChapterListScreen.dart';

class _ShowBookInfoEvent {
  final BookIndex bookIndex;

  _ShowBookInfoEvent(this.bookIndex);
}

class _ShowChapterContentEvent{
  final ChapterRef chapterRef;

  _ShowChapterContentEvent(this.chapterRef);
}
