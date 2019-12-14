import 'package:built_collection/built_collection.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_event_bus/EventBus.dart';
import 'package:flutter_event_bus/ProxyInteractor.dart';
import 'package:flutter_event_bus/Subscription.dart';
import 'package:timnew_reader/legacy/models/BookIndex.dart';
import 'package:timnew_reader/stores/BookListStore.dart';

class BookListInteractorWidget extends ProxyInteractorWidget {
  final BuiltList<BookIndex> books;

  BookListInteractorWidget({@required this.books, @required Widget child})
      : super(key: BookListInteractor.key, child: child);

  @override
  State<StatefulWidget> createState() => BookListInteractor(books);
}

class BookListInteractor extends ProxyInteractor {
  static final GlobalKey<BookListInteractor> key =
      GlobalObjectKey<BookListInteractor>(BookListInteractor);

  BuiltList<BookIndex> books;

  BookListInteractor(this.books);

  @override
  Widget buildWrapper(BuildContext context, Widget child) =>
      BookListStore(books, child);

  @override
  Subscription subscribeEvents(EventBus eventBus) => Subscription.empty();
}
