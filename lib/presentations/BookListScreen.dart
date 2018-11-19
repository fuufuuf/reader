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
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: <Widget>[
            Icon(
              Icons.local_library,
              size: 32,
            ),
            Padding(
              padding: EdgeInsets.only(left: 8),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      books[index].title,
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      books[index].author,
                      textAlign: TextAlign.start,
                      style: DefaultTextStyle.of(context)
                          .style
                          .apply(color: Colors.black45),
                    ),
                  ]),
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) => Padding(
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: ListView.builder(
        itemBuilder: _renderItem,
        itemCount: books.length,
      ));
}
