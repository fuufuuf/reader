part of 'BookListScreen.dart';

class _BookListInteractorWidget extends ProxyInteractorWidget {
  final BuiltList<BookIndex> books;

  _BookListInteractorWidget({@required this.books, @required Widget child})
      : super(key: _BookListInteractor.key, child: child);

  @override
  State<StatefulWidget> createState() => _BookListInteractor(books);
}

class _BookListInteractor extends ProxyInteractor {
  static final GlobalKey<_BookListInteractor> key =
  GlobalObjectKey<_BookListInteractor>(_BookListInteractor);

  BuiltList<BookIndex> books;

  _BookListInteractor(this.books);

  @override
  Widget buildWrapper(BuildContext context, Widget child) =>
      BookListStore(books, child);

  @override
  Subscription subscribeEvents(EventBus eventBus) =>
      eventBus
          .respond<_AddBookEvent>(_respondToAddBook)
          .respond<_RemoveBookEvent>(_respondToRemoveBook)
          .respond<_ShowBookInfoEvent>(_respondToShowBookInfo)
          .respond<_OpenBookEvent>(_respondToOpenBook);

  void _respondToAddBook(_AddBookEvent event) async {
    final newBook = await AddBookDialog.showDialog(context);

    if (newBook == null) {
      return;
    }

    final updated = books.rebuild((b) => b.add(newBook.book));

    await BookIndexRepository.addBook(updated, newBook.book);

    if (newBook.currentChapter != null) {
      await BookIndexRepository.updateProgress(newBook.book, newBook.currentChapter);
    }

    setState(() {
      books = updated;
    });
  }

  void _respondToRemoveBook(_RemoveBookEvent event) async {
    final updated = books.rebuild((b) => b.remove(event.book));

    await BookIndexRepository.removeBook(updated, event.book.id);

    setState(() {
      books = updated;
    });
  }

  void _respondToShowBookInfo(_ShowBookInfoEvent event) {
    print("Show book info");
  }

  void _respondToOpenBook(_OpenBookEvent event) {
    print("Open book");
  }
}
