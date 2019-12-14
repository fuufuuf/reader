part of 'BookListScreen.dart';

class _AddBookEvent {}

class _RemoveBookEvent {
  final BookIndex book;

  _RemoveBookEvent(this.book);
}

class _ShowBookInfoEvent {
  final BookIndex book;

  _ShowBookInfoEvent(this.book);
}

class _OpenBookEvent {
  final BookIndex book;

  _OpenBookEvent(this.book);
}
