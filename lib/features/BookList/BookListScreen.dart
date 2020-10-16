import 'package:flutter/material.dart';
import 'package:built_collection/built_collection.dart';
import 'package:flutter/services.dart';
import 'package:timnew_reader/features/AddNewBooks/AddNewBookDialog.dart';

import 'package:timnew_reader/features/Routing/AppRouter.dart';

import 'package:timnew_reader/arch/RenderMixin.dart';
import 'package:timnew_reader/models/BookIndex.dart';
import 'package:timnew_reader/widgets/Message.dart';

import 'package:timnew_reader/widgets/ScreenScaffold.dart';
import 'package:timnew_reader/widgets/SwipeRemovable.dart';

import 'package:timnew_reader/repositories/PersistentStorage.dart';

import 'BookListBottomSheet.dart';
import 'BookListRequest.dart';

class BookListScreen extends StatelessWidget {
  final BookListRequest request;

  BookListScreen(this.request);

  factory BookListScreen.create() => BookListScreen(BookListRequest(PersistentStorage.instance));

  static const String routeName = "BookList";

  static MaterialPageRoute buildRoute(BookIndex bookIndex) => MaterialPageRoute(
        settings: RouteSettings(name: routeName, arguments: bookIndex),
        builder: (_) => BookListScreen.create(),
      );

  @override
  Widget build(BuildContext context) => ScreenScaffold(
        title: Text('米良追书'),
        appBarActions: [Builder(builder: _buildMenuButton)],
        body: _BookIndexList(request),
      );

  Widget _buildMenuButton(BuildContext context) => IconButton(
        icon: Icon(Icons.more_horiz),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (_) => BookListBottomSheet(
              request: request,
              onAddNewBook: () => _addNewBook(context),
              onExportAllBooks: () => _onExportAllBooks(context),
            ),
            routeSettings: RouteSettings(name: routeName),
          );
        },
      );

  Future _addNewBook(BuildContext context) async {
    final newBooks = await AddNewBookDialog.show(context, request);

    request.addNewBooks(newBooks);
  }

  void _onExportAllBooks(BuildContext context) async {
    final bookUrls = request.exportAllBookUrls();

    await Clipboard.setData(ClipboardData(text: bookUrls));

    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Message("數目 Url 已經複製到剪貼板", type: MessageType.Success),
      ),
    );
  }
}

class _BookIndexList extends StatelessWidget
    with RenderAsyncSnapshot<BuiltList<BookIndex>>, WithEmptyContent<BuiltList<BookIndex>> {
  final BookListRequest request;

  _BookIndexList(this.request);

  @override
  Widget build(BuildContext context) => buildStream(request.valueStream);

  @override
  Widget buildContent(BuildContext context, BuiltList<BookIndex> content) {
    return ReorderableListView(
      children: _buildChildren(content),
      onReorder: _onReorder,
    );
  }

  @override
  Widget buildEmpty(BuildContext context) => Center(child: Text("請先添加圖書"));

  @override
  bool checkEmpty(BuiltList<BookIndex> data) => data.isEmpty;

  List<Widget> _buildChildren(BuiltList<BookIndex> content) =>
      Iterable<int>.generate(content.length).map((index) => _BookIndexEntry(request, index)).toList();

  void _onReorder(int oldIndex, int newIndex) async {
    await request.reorder(oldIndex, newIndex);
  }
}

class _BookIndexEntry extends StatelessWidget {
  final BookListRequest bookList;
  final int index;
  final BookIndex bookIndex;

  factory _BookIndexEntry(BookListRequest bookList, int index) =>
      _BookIndexEntry._(bookList, index, bookList.ensuredCurrentData[index]);

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
