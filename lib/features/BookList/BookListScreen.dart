import 'package:flutter/material.dart';
import 'package:built_collection/built_collection.dart';
import 'package:provider/provider.dart';
import 'package:timnew_reader/features/Routing/AppRouter.dart';

import 'package:timnew_reader/arch/RenderMixin.dart';
import 'package:timnew_reader/features/AddNewBooks/AddNewBookDialog.dart';
import 'package:timnew_reader/models/BookIndex.dart';

import 'package:timnew_reader/widgets/ScreenScaffold.dart';
import 'package:timnew_reader/widgets/SwipeRemovable.dart';

import 'package:timnew_reader/repositories/PersistentStorage.dart';

import 'BookList.dart';

class BookListScreen extends StatelessWidget {
  static const String routeName = "BookList";

  static MaterialPageRoute buildRoute(BookIndex bookIndex) => MaterialPageRoute(
        settings: RouteSettings(name: routeName, arguments: bookIndex),
        builder: (_) => BookListScreen(),
      );

  @override
  Widget build(BuildContext context) => ProxyProvider<PersistentStorage, BookList>(
        update: (_, storage, __) => BookList(storage),
        child: Builder(builder: _buildScreen),
      );

  Widget _buildScreen(BuildContext context) {
    final bookList = context.watch<BookList>();

    return ScreenScaffold(
      title: '米良追书',
      body: _BookIndexList(bookList),
      floatingActionButton: _renderFab(context, bookList),
    );
  }

  Widget _renderFab(BuildContext context, BookList bookList) => FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () async {
        final newBooks = await AddNewBookDialog.show(context, bookList);

        bookList.addNewBooks(newBooks);
      });
}

class _BookIndexList extends StatelessWidget
    with RenderValueListenable<BuiltList<BookIndex>>, WithEmptyContent<BuiltList<BookIndex>> {
  final BookList bookList;

  _BookIndexList(this.bookList);

  @override
  Widget build(BuildContext context) => buildValueStore(bookList);

  @override
  Widget buildContent(BuildContext context, BuiltList<BookIndex> content) {
    return ReorderableListView(
      children: _buildChildren(content.length),
      onReorder: _onReorder,
    );
  }

  @override
  Widget buildEmpty(BuildContext context) => Center(child: Text("請先添加圖書"));

  @override
  bool checkEmpty(BuiltList<BookIndex> data) => data.isEmpty;

  List<Widget> _buildChildren(int length) =>
      Iterable<int>.generate(length).map((index) => _BookIndexEntry(bookList, index)).toList();

  void _onReorder(int oldIndex, int newIndex) async {
    await bookList.reorder(oldIndex, newIndex);
  }
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
            AppRouter.of(context).gotoBookInfo(bookIndex);
          },
        ),
        onTap: () async {
          await Navigator.of(context).goToBookContent(bookIndex);

          bookList.reload();
        },
      ),
    );
  }
}
