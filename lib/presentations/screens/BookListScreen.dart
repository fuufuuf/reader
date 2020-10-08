import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timnew_reader/app/AddNewBooks/AddNewBookDialog.dart';
import 'package:timnew_reader/app/BookList/BookList.dart';
import 'package:timnew_reader/models/BookIndex.dart';
import 'package:timnew_reader/presentations/ReaderApp.AppRouter.dart';
import 'package:timnew_reader/presentations/components/ScreenScaffold.dart';
import 'package:timnew_reader/presentations/components/SwipeRemovable.dart';
import 'package:timnew_reader/repositories/PersistentStorage.dart';

class BookListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ProxyProvider<PersistentStorage, BookList>(
        update: (_, storage, __) => BookList(storage),
        child: Builder(builder: _buildScreen),
      );

  Widget _buildScreen(BuildContext context) {
    final bookList = context.watch<BookList>();

    print("bookList: $bookList");

    return ScreenScaffold(
        title: '米良追书', body: _buildList(bookList), floatingActionButton: _renderFab(context, bookList));
  }

  ListView _buildList(BookList bookList) {
    return ListView.builder(
      itemBuilder: (context, index) => _BookIndexEntry(bookList, index),
      itemCount: bookList.value.length,
    );
  }

  Widget _renderFab(BuildContext context, BookList bookList) => FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
        AddNewBookDialog.show(context, bookList);
      });
}

class _BookIndexEntry extends StatelessWidget {
  final BookList bookList;
  final int index;
  final BookIndex bookIndex;

  factory _BookIndexEntry(BookList bookList, int index) => _BookIndexEntry._(bookList, index, bookList.value[index]);

  _BookIndexEntry._(this.bookList, this.index, this.bookIndex)
      : assert(bookList != null),
        assert(index != null),
        assert(bookIndex != null),
        super(key: Key(bookIndex.bookId));

  @override
  Widget build(BuildContext context) {
    return SwipeRemovable(
      key: Key(bookIndex.bookId),
      onRemoved: () {
        bookList.removeAtIndex(index);
      },
      child: ListTile(
        leading: Icon(Icons.book),
        title: Text(bookIndex.bookName),
        trailing: IconButton(
          icon: Icon(Icons.info_outline),
          onPressed: () {
            return AppRouter.openBookInfo(context, bookIndex.bookId);
          },
        ),
        onTap: () {
          AppRouter.openBookChapters(context, bookIndex.bookId, openReaderIfPossible: true);
          // reload();
        },
      ),
    );
  }
}
