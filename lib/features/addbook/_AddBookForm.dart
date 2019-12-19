part of 'AddBookDialog.dart';

class _AddBookForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddBookFormInteractor();
}

class _AddBookFormInteractor extends Interactor<_AddBookForm> {
  final TextEditingController _urlController = TextEditingController();

  Future<CurrentBook> _parseBookInfoFuture;
  CurrentBook _parsedBook;

  bool get _isBookParsed => _parsedBook != null;

  @override
  void initState() {
    super.initState();
    _parseCopiedUrl(null);
  }

  @override
  Widget build(BuildContext context) =>
      Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <Widget>[
        _UrlField(_urlController),
        _FutureBookInfoBox(
          currentBook: _parseBookInfoFuture,
        ),
        _FormButtonBar(
          allowSubmit: _isBookParsed,
        )
      ]);

  @override
  Subscription subscribeEvents(EventBus eventBus) =>
      eventBus.respond<_PasteUrlEvent>(_parseCopiedUrl)
          .respond<_ParseNewBookUrlEvent>(_parseUrl)
          .respond<_SubmitFormEvent>(_submitForm);

  void _parseCopiedUrl(_PasteUrlEvent event) async {
    final copied = await Clipboard.getData(Clipboard.kTextPlain);
    if (copied != null) {
      _urlController.text = copied.text;
      _parseUrl(null);
    }
  }

  void _parseUrl(_ParseNewBookUrlEvent event) async {
    final url = Uri.parse(_urlController.text);

    setState(() {
      _parseBookInfoFuture = BookCrawler.fetchFromUrl(url, CurrentBook());
    });

    _parseBookInfoFuture.then((data) {
      setState(() {
        _parsedBook = data;
      });
    });
  }

  void _submitForm(_SubmitFormEvent event) {
    Navigator.of(context).pop(_parsedBook);
  }
}
