import 'package:timnew_reader/models/book_models.dart';

class AddBookEvent {}

class RemoveBookEvent {
  final BookIndex book;

  RemoveBookEvent(this.book);
}

class ShowBookInfoEvent{
  final BookIndex book;

  ShowBookInfoEvent(this.book);
}

class ShowChapterListEvent {
  final BookIndex book;

  ShowChapterListEvent(this.book);
}
