part of 'AddBookDialog.dart';

class _FutureBookInfoBox extends StatelessWidget {
  final Future<CurrentBook> currentBook;

  const _FutureBookInfoBox({Key key, this.currentBook}) : super(key: key);

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
          constraints: BoxConstraints.expand(height: 270),
          child: FutureBuilder(future: currentBook, builder: _buildFuture),
        ),
      );

  Widget _buildFuture(BuildContext context,
      AsyncSnapshot<CurrentBook> snapshot) {
    if (snapshot.hasError) {
      return _NewBookParsingFailure(errorMessage: snapshot.error.toString());
    }

    if (snapshot.connectionState == ConnectionState.waiting) {
      return _LoadingIndicator();
    }

    if (snapshot.hasData) {
      return _NewBookInfo(currentBook: snapshot.data);
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
  final CurrentBook currentBook;

  const _NewBookInfo({Key key, this.currentBook}) : super(key: key);

  @override
  Widget build(BuildContext context) => ListView(children: <Widget>[
    _buildRow(Icons.vpn_key, currentBook.bookIndex.id),
    _buildRow(Icons.title, currentBook.bookIndex.title),
    _buildRow(Icons.book, currentBook.bookIndex.bookInfoUrl.toString()),
    _buildRow(Icons.list, currentBook.bookIndex.chapterListUrl.toString()),
        _buildRow(Icons.bookmark_border,
            currentBook.chapter?.title ?? "<未知>")
      ]);

  ListTile _buildRow(IconData icon, String value) =>
      ListTile(leading: Icon(icon), title: Text(value));
}
