part of 'AddBookDialog.dart';

class _FutureBookInfoBox extends StatelessWidget {
  final Future<NewBook> parseNewBook;

  const _FutureBookInfoBox({Key key, this.parseNewBook}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                  color: Theme
                      .of(context)
                      .primaryColor
              )
          ),
          constraints: BoxConstraints.expand(height: 200),
          child: FutureBuilder(future: parseNewBook, builder: _buildFuture),
        ),
      );

  Widget _buildFuture(BuildContext context, AsyncSnapshot<NewBook> snapshot) {
    if (snapshot.hasError) {
      return _NewBookParsingFailure(errorMessage: snapshot.error.toString());
    }

    if (snapshot.connectionState == ConnectionState.waiting) {
      return _LoadingIndicator();
    }

    if (snapshot.hasData) {
      return _NewBookInfo(newBook: snapshot.data);
    }

    return _Hint();
  }
}

class _Hint extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Align(
        child: Text(
          "输入 Url 开始",
          style: Theme.of(context).textTheme.body1,
        ),
      );
}

class _LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Align(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      );
}

class _NewBookParsingFailure extends StatelessWidget {
  final String errorMessage;

  const _NewBookParsingFailure({Key key, this.errorMessage}) : super(key: key);

  TextStyle _errorMessageStyle(BuildContext context) {
    final theme = Theme.of(context);
    return theme.textTheme.body1.copyWith(color: theme.errorColor);
  }

  @override
  Widget build(BuildContext context) =>
      Align(child: Text(errorMessage, style: _errorMessageStyle(context)));
}

class _NewBookInfo extends StatelessWidget {
  final NewBook newBook;

  const _NewBookInfo({Key key, this.newBook}) : super(key: key);

  @override
  Widget build(BuildContext context) => ListView(children: <Widget>[
        _buildRow(Icons.vpn_key, newBook.book.id),
        _buildRow(Icons.title, newBook.book.title),
        _buildRow(Icons.book, newBook.book.bookInfoUrl.toString()),
        _buildRow(Icons.list, newBook.book.chapterListUrl.toString()),
        _buildRow(Icons.bookmark_border,
            newBook.currentChapter?.title ?? "<未知>")
      ]);

  ListTile _buildRow(IconData icon, String value) =>
      ListTile(leading: Icon(icon), title: Text(value));
}
