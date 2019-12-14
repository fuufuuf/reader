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
  Subscription subscribeEvents(EventBus eventBus) => Subscription.empty();
}
