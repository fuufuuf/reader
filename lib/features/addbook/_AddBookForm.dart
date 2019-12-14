part of 'AddBookDialog.dart';

class _AddBookForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddBookFormInteractor();
}

class _AddBookFormInteractor extends Interactor<_AddBookForm> {
  final TextEditingController _urlController = TextEditingController();

  Future<NewBook> _parseNewBookFuture;

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
  Subscription subscribeEvents(EventBus eventBus) => Subscription.empty();
}
