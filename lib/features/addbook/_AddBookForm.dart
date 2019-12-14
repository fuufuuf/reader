part of 'AddBookDialog.dart';

class _AddBookForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddBookFormInteractor();
}

class _AddBookFormInteractor extends Interactor<_AddBookForm> {
  final TextEditingController _urlController = TextEditingController();

  Future<NewBook> _parseNewBookFuture;

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
          parseNewBook: _parseNewBookFuture,
        ),
        _FormButtonBar(
          allowSubmit: false,
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

  void _parseUrl(_ParseNewBookUrlEvent event) {

  }

  void _submitForm(_SubmitFormEvent event) {
  }
}
