import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:timnew_reader/models/BookIndex.dart';
import 'package:timnew_reader/models/NewBook.dart';
import 'package:timnew_reader/presentations/ReaderApp.AppRouter.dart';
import 'package:timnew_reader/presentations/components/ScreenScaffold.dart';
import 'package:timnew_reader/presentations/screens/AddBookDialog.dart';

class BookListScreen extends StatefulWidget {
  BookListScreen();

  @override
  State<StatefulWidget> createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {
  BuiltList<BookIndex> bookIndexes;

  void reload() {
    bookIndexes = BookIndex.loadAll();
  }

  @override
  void initState() {
    super.initState();

    reload();
  }

  @override
  Widget build(BuildContext context) => ScreenScaffold(
      title: '米良追书',
      body: ListView.builder(
          itemBuilder: (context, index) => _renderBookItem(context, bookIndexes[index]), itemCount: bookIndexes.length),
      floatingActionButton: _renderFab(context));

  void _addBookEntry(NewBook newBook) async {
    if (newBook == null) return;

    final bookIndex = await newBook.save();

    setState(() {
      bookIndexes = bookIndexes.rebuild((b) => b.add(bookIndex));
    });
  }

  void _removeBookEntry(BookIndex bookIndex) async {
    await bookIndex.remove();

    setState(() {
      bookIndexes = bookIndexes.rebuild((b) => b.remove(bookIndex));
    });
  }

  Widget _renderBookItem(BuildContext context, BookIndex bookIndex) => Dismissible(
      key: Key(bookIndex.bookId),
      background: Container(
        color: Colors.redAccent,
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 16),
        child: Text('滑动删除', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (DismissDirection direction) {
        _removeBookEntry(bookIndex);
      },
      dismissThresholds: const {DismissDirection.endToStart: .9},
      child: ListTile(
          leading: Icon(Icons.book),
          title: Text(bookIndex.bookName),
          trailing: IconButton(
              icon: Icon(Icons.info_outline),
              onPressed: () {
                AppRouter.openBookInfo(context, bookIndex.bookId);
              }),
          onTap: () async {
            await AppRouter.openBookChapters(context, bookIndex.bookId, openReaderIfPossible: true);
            reload();
          }));

  Widget _renderFab(BuildContext context) => FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () async {
        _addBookEntry(await AddBookDialog.show(context));
      });
}
