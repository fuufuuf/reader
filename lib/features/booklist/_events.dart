part of 'BookListScreen.dart';

class _AddBookEvent {}

class _RemoveBookEvent {
  final BookIndex bookIndex;

  _RemoveBookEvent(this.bookIndex);
}

class _ShowChapterListEvent {
  final BookIndex bookIndex;

  _ShowChapterListEvent(this.bookIndex);
}

class _OpenBookEvent {
  final BookIndex bookIndex;

  _OpenBookEvent(this.bookIndex);
}
