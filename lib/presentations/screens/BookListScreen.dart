import 'package:flutter/material.dart';
import 'package:reader/models/BookEntry.dart';
import 'package:reader/presentations/ReaderApp.AppRouter.dart';
import 'package:reader/presentations/components/ScreenScaffold.dart';
import 'package:reader/presentations/screens/AddBookDialog.dart';
import 'package:reader/viewModels/BookEntryList.dart';

class BookListScreen extends StatefulWidget {
  final BookEntryList entryList;

  BookListScreen(this.entryList);

  @override
  State<StatefulWidget> createState() => _BookListScreenState(entryList);
}

class _BookListScreenState extends State<BookListScreen> {
  final BookEntryList entryList;

  _BookListScreenState(this.entryList);

  @override
  Widget build(BuildContext context) => ScreenScaffold(
      title: 'Books',
      body: ListView.builder(
          itemBuilder: (context, index) =>
              _renderBookItem(context, entryList.entries[index]),
          itemCount: entryList.entries.length),
      floatingActionButton: _renderFab(context));

  void _addBookEntry(BookEntry newBookEntry) {
    if (newBookEntry == null) return;

    setState(() {
      entryList.add(newBookEntry);
    });
  }

  void _removeBookEntry(BookEntry entry) {
    setState(() {
      entryList.remove(entry);
    });
  }

  Widget _renderBookItem(BuildContext context, BookEntry entry) => Dismissible(
      key: Key(entry.id),
      background: Container(
        color: Colors.redAccent,
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 16),
        child: Text('Swipe to remove',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (DismissDirection direction) {
        _removeBookEntry(entry);
      },
      dismissThresholds: const {DismissDirection.endToStart: .9},
      child: ListTile(
          leading: Icon(Icons.book),
          title: Text(entry.bookName),
          trailing: IconButton(icon: Icon(Icons.info_outline), onPressed: () {
            AppRouter.openBookInfo(context, entry);
          }),
          onTap: () {
            AppRouter.openBookChapters(context, entry);
          }));

  Widget _renderFab(BuildContext context) => FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () async {
        _addBookEntry(await AddBookDialog.show(context));
      });
}
