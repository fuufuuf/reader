import 'package:flutter/material.dart';
import 'package:reader/models/models.dart';
import 'package:reader/presentations/ChapterListScreen.dart';

class BookListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text("Books"),
      ),
      body: FutureBuilder<List<Book>>(
          initialData: [],
          future: BookList.loadAll(),
          builder: (BuildContext context, AsyncSnapshot<List<Book>> snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return Center(
                child: const Text("Loading"),
              );
            }

            if (snapshot.hasError) {
              throw snapshot.error;
            }

            return _BookListView(
                key: Key("BookListView"), books: snapshot.data);
          }));
}

class _BookListView extends StatelessWidget {
  _BookListView({Key key, this.books}) : super(key: key);

  final List<Book> books;

  Widget _renderItem(BuildContext context, int index) {
    final book = books[index];
    return FutureBuilder<Book>(
      future: book.isMetaLoaded ? Future.value(book) : book.load(),
      builder: _renderBookLoader,
    );
  }

  Widget _renderBookLoader(BuildContext context, AsyncSnapshot<Book> snapshot) {
    if (snapshot.connectionState != ConnectionState.done) {
      return const ListTile(
          leading: Icon(
            Icons.cloud_download,
            size: 32,
          ),
          title: Text("Loading...."));
    }

    if (snapshot.hasError) {
      throw snapshot.error;
    }
    return ListTile(
      leading: const Icon(
        Icons.local_library,
        size: 32,
      ),
      title: Text(snapshot.data.title),
      subtitle: Text(
        snapshot.data.author,
        style: DefaultTextStyle.of(context).style.apply(color: Colors.black45),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ChapterListScreen(snapshot.data)),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) => Padding(
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: ListView.builder(
        itemBuilder: _renderItem,
        itemCount: books.length,
      ));
}
