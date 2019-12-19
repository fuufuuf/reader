import 'package:flutter/material.dart';
import 'package:flutter_event_bus/flutter_event_bus.dart';
import 'package:timnew_reader/models/CurrentBook.dart';
import 'package:timnew_reader/models/book_models.dart';
import 'package:timnew_reader/stores/CurrentBookStore.dart';

part '_events.dart';

part '_view.dart';

class ChapterListScreen extends StatefulWidget {
  final CurrentBook currentBook;

  const ChapterListScreen({Key key, this.currentBook}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ChapterListInteractor(currentBook);

  static Route<CurrentBook> route(BookIndex bookIndex) =>
      MaterialPageRoute(
          maintainState: true,
          builder: (_) => ChapterListScreen()
      );
}

class _ChapterListInteractor extends Interactor<ChapterListScreen> {
  CurrentBook _currentBook;

  _ChapterListInteractor(this._currentBook);

  @override
  Widget build(BuildContext context) =>
      CurrentBookStore(
          currentBook: _currentBook,
          child: _ChapterListScreenView()
      );

  @override
  Subscription subscribeEvents(EventBus eventBus) =>
      eventBus
          .respond<_ShowBookInfoEvent>(_showBookInfo)
          .respond<_ShowChapterContentEvent>(_showChapterContent);

  void _showBookInfo(_ShowBookInfoEvent event) {
    Navigator.push(context, ChapterListScreen.route(event.bookIndex));
  }

  void _showChapterContent(_ShowChapterContentEvent event) {
  }
}

