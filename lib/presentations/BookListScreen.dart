import 'package:flutter/material.dart';
import 'package:reader/models/models.dart';
import 'package:reader/repositories/BookRepository.dart';

class BookListScreen extends StatelessWidget {
  final BookRepository repository = BookRepository();

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text("Books"),
      ),
      body: FutureBuilder<List<Book>>(
          initialData: [],
          future: repository.sampleData(),
          builder: (BuildContext context, AsyncSnapshot<List<Book>> snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return Center(
                child: const Text("Loading"),
              );
            }

            if (snapshot.hasError) {
              throw snapshot.error;
//              return Center(
//                child: Text("Error: ${snapshot.error}"),
//              );
            }

            return _BookListView(
                key: Key("BookListView"), books: snapshot.data);
          }));
}

class _BookListView extends StatelessWidget {
  _BookListView({Key key, this.books}) : super(key: key);

  final List<Book> books;

  Widget _renderItem(BuildContext context, int index) {
    return Container(
      child: Column(
        children: <Widget>[Text(books[index].title), Text(books[index].author)],
      ),
    );
  }

  @override
  Widget build(BuildContext context) => ListView.builder(
        itemBuilder: _renderItem,
        itemCount: books.length,
      );
}
