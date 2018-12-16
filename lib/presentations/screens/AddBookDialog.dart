import 'package:flutter/material.dart';
import 'package:reader/models/BookEntry.dart';
import 'package:reader/presentations/components/ScreenScaffold.dart';
import 'package:reader/repositories/network/BookRepository.dart';

class AddBookDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddBookDialogState();

  static Future<BookEntry> show(BuildContext context) => Navigator.push(
      context,
      MaterialPageRoute(
          builder: (_) => AddBookDialog(), fullscreenDialog: true));
}

class _AddBookDialogState extends State<AddBookDialog> {
  final TextEditingController _urlController = TextEditingController();

  Future<BookEntry> bookEntryFuture;

  VoidCallback submitBookEntry;

  void _loadBookEntry() {
    setState(() {
      submitBookEntry = null;
      bookEntryFuture =
          BookRepository
              .fetchBookEntryByUrlString(_urlController.text)
              .then((entry) {
            setState(() {
              submitBookEntry = () {
                Navigator.pop(context, entry);
              };
            });
            return entry;
          });
    });
  }

  @override
  Widget build(BuildContext context) => ScreenScaffold(
      title: 'Add new book',
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
                labelText: "Book Url",
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
            child: FutureBuilder<BookEntry>(
              future: bookEntryFuture,
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
                      child: Text('refresh'),
                      onPressed: _loadBookEntry,
                    ),
                    RaisedButton(
                        padding: EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        textTheme: ButtonTextTheme.primary,
                        child: Text('Submit'),
                        onPressed: submitBookEntry
                    )
                  ],
                )
            ),
          ),
        ],
      );

  Widget _renderBookEntryFuture(BuildContext context,
      AsyncSnapshot<BookEntry> snapshot) {
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

  Widget _renderBookEntry(BookEntry entry) =>
      ListView(
          children:
          <Widget>[
            _renderEntryItem(Icons.vpn_key, entry.id),
            _renderEntryItem(Icons.title, entry.bookName),
            _renderEntryItem(Icons.book, entry.bookInfoUrl.toString()),
            _renderEntryItem(Icons.list, entry.chapterListUrl.toString())
          ]
      );

  ListTile _renderEntryItem(IconData icon, String value) =>
      ListTile(leading: Icon(icon), title: Text(value));
}
