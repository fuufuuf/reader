import 'package:flutter/material.dart';
import 'package:reader/models/models.dart';
import 'package:reader/presentations/ReaderScreen.dart';
import 'package:reader/repositories/BookRepository.dart';

class ChapterListScreen extends StatelessWidget {
  ChapterListScreen(this.book);

  final Book book;
  final BookRepository repository = BookRepository();

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text(book.title),
      ),
      body: FutureBuilder<List<Chapter>>(
          initialData: [],
          future: repository.loadBook(book).then((book) => book.chapters),
          builder:
              (BuildContext context, AsyncSnapshot<List<Chapter>> snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return Center(
                child: const Text("Loading"),
              );
            }

            if (snapshot.hasError) {
              throw snapshot.error;
            }

            return _ChapterListView(
                key: Key("BookListView"), book: book, chapters: snapshot.data);
          }));
}

class _ChapterListView extends StatelessWidget {
  final Book book;
  final List<Chapter> chapters;

  _ChapterListView({Key key, this.book, this.chapters}) : super(key: key);

  Widget _renderItem(BuildContext context, int index) => ListTile(
        leading: const Icon(
          Icons.note,
          size: 32,
        ),
        title: Text(chapters[index].title),
        subtitle: Text(
          chapters[index].isLoaded ? "Loaded" : "Not loaded",
          style:
              DefaultTextStyle.of(context).style.apply(color: Colors.black45),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ReaderScreen(book, index)),
          );
        },
      );

  @override
  Widget build(BuildContext context) => Padding(
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: ListView.builder(
        itemBuilder: _renderItem,
        itemCount: chapters.length,
      ));
}
