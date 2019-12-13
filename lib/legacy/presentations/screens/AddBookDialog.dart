import 'package:flutter/material.dart';
import '../../models/NewBook.dart';
import '../../presentations/components/ScreenScaffold.dart';
import '../../repositories/network/BookRepository.dart';

class AddBookDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddBookDialogState();

  static Future<NewBook> show(BuildContext context) =>
      Navigator.push(
      context,
      MaterialPageRoute(
          builder: (_) => AddBookDialog(), fullscreenDialog: true));
}

class _AddBookDialogState extends State<AddBookDialog> {
  final TextEditingController _urlController = TextEditingController();

  Future<NewBook> future;

  VoidCallback submitBookEntry;

  void _loadBookEntry() {
    setState(() {
      submitBookEntry = null;
      future =
          BookRepository
              .createBookByUrlString(_urlController.text)
              .then((newBook) {
            setState(() {
              submitBookEntry = () {
                Navigator.pop(context, newBook);
              };
            });
            return newBook;
          });
    });
  }

  @override
  Widget build(BuildContext context) => ScreenScaffold(
      title: '添加新书',
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Form(child: _renderForm(context))
      )
  );

  Widget _renderForm(BuildContext context) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
                labelText: "新书 Url",
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    _urlController.clear();
                  },
                )
            ),
            controller: _urlController,
            onFieldSubmitted: (_) {
              _loadBookEntry();
            },
          ),
          Expanded(
            child: FutureBuilder<NewBook>(
              future: future,
              builder: _renderBookEntryFuture,
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: ButtonTheme.bar(
                child: ButtonBar(
                  children: <Widget>[
                    FlatButton(
                      padding: EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      child: Text('加载'),
                      onPressed: _loadBookEntry,
                    ),
                    RaisedButton(
                        padding: EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        textTheme: ButtonTextTheme.primary,
                        child: Text('添加'),
                        onPressed: submitBookEntry
                    )
                  ],
                )
            ),
          ),
        ],
      );

  Widget _renderBookEntryFuture(BuildContext context,
      AsyncSnapshot<NewBook> snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return Align(
        alignment: Alignment.center,
        child: CircularProgressIndicator(value: null),
      );
    }

    if (snapshot.hasError) {
      return
        Align(
            alignment: Alignment.center,
            child: Text(
                snapshot.error.toString(),
                style: TextStyle(color: Theme
                    .of(context)
                    .errorColor)
            )
        );
    }

    if (snapshot.hasData) {
      return _renderBookEntry(snapshot.data);
    }

    return Container();
  }

  Widget _renderBookEntry(NewBook newBook) =>
      ListView(
          children:
          <Widget>[
            _renderEntryItem(Icons.vpn_key, newBook.bookId),
            _renderEntryItem(Icons.title, newBook.bookName),
            _renderEntryItem(Icons.book, newBook.bookInfoUrl.toString()),
            _renderEntryItem(Icons.list, newBook.chapterListUrl.toString()),
            _renderEntryItem(Icons.bookmark_border,
                newBook.currentChapterUrl?.toString() ?? "<未知>")
          ]
      );

  ListTile _renderEntryItem(IconData icon, String value) =>
      ListTile(leading: Icon(icon), title: Text(value));
}
