import 'package:flutter/material.dart';
import 'package:flutter_event_bus/flutter_event_bus.dart';
import 'package:timnew_reader/models/book_models.dart';
import 'package:timnew_reader/stores/BookListStore.dart';

import 'events.dart';

class BookListScreenView extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      Scaffold(
        appBar: AppBar(
          title: Text("米良读书"),
        ),
        body: BookList(),
        floatingActionButton: AddBookButton(),
      );
}

class AddBookButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            EventBus.publishTo(context, AddBookEvent());
          }
      );
}

class BookList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final books = BookListStore
        .of(context)
        .books;

    return Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
            itemBuilder: (context, index) => BookIndexItem(books[index]),
            itemCount: books.length)
    );
  }
}

class BookIndexItem extends StatelessWidget {
  final BookIndex book;

  BookIndexItem(this.book);

  @override
  Widget build(BuildContext context) =>
      Dismissible(
          key: Key(book.id),
          background: Container(
            color: Colors.redAccent,
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 16),
            child: Text('滑动删除', style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold)),
          ),
          direction: DismissDirection.endToStart,
          onDismissed: (DismissDirection direction) {
            EventBus.publishTo(context, RemoveBookEvent(book));
          },
          dismissThresholds: const {DismissDirection.endToStart: .9},
          child: ListTile(
              leading: Icon(Icons.book),
              title: Text(book.title),
              trailing: IconButton(
                  icon: Icon(Icons.info_outline),
                  onPressed: () {
                    EventBus.publishTo(context, ShowBookInfoEvent(book));
                  }),
              onTap: () {
                EventBus.publishTo(context, ShowChapterListEvent(book));
              }
          ));

}
