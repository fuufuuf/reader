import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:timnew_reader/arch/AsyncValueBuilder.dart';

import 'package:timnew_reader/models/NewBook.dart';

import 'package:timnew_reader/requests/AddNewBook.dart';

import 'package:timnew_reader/presentations/components/ScreenScaffold.dart';

class AddBookDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddBookDialogState();

  static Future<NewBook> show(BuildContext context) =>
      Navigator.push(context, MaterialPageRoute(builder: (_) => AddBookDialog(), fullscreenDialog: true));
}

class _AddBookDialogState extends State<AddBookDialog> {
  final TextEditingController _urlController = TextEditingController();

  BuiltList<AddNewBook> requests = BuiltList();

  void _clearRequests() {
    setState(() {
      requests = BuiltList();
    });
  }

  void _onUserInputConfirmed() {
    setState(() {
      final text = _urlController.text;
      _urlController.clear();
      _parseNewBookUrls(text);
    });
  }

  void _onLoadFromClipboard() async {
    final data = await Clipboard.getData(Clipboard.kTextPlain);

    if (data != null) {
      setState(() {
        _parseNewBookUrls(data.text);
      });
    }
  }

  void _parseNewBookUrls(String text) {
    final existing = requests.map((it) => it.url).toSet();

    final newRequests = AddNewBook.fromUrlInput(text).where((it) => !existing.contains(it.url)).toBuiltList();

    setState(() {
      requests += newRequests;
    });
  }

  @override
  Widget build(BuildContext context) => ScreenScaffold(
      title: '添加新書',
      body:
          Padding(padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4), child: Form(child: _renderForm(context))));

  Widget _renderForm(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(labelText: "新書 Url", suffixIcon: _renderClearUrlButton()),
            controller: _urlController,
            onChanged: (_) {
              setState(() {});
            },
            onFieldSubmitted: (_) {
              _onUserInputConfirmed();
            },
          ),
          Expanded(child: _renderNewBookList()),
          Align(
              alignment: Alignment.centerRight,
              child: ButtonBar(
                children: <Widget>[
                  FlatButton(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: Text('清空'),
                    onPressed: _clearRequests,
                  ),
                  FlatButton(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: Text('從剪貼盤加載'),
                    onPressed: _onLoadFromClipboard,
                  )
                ],
              )),
        ],
      );

  Widget _renderClearUrlButton() {
    if (_urlController.text.isEmpty) {
      return null;
    }

    return IconButton(
      icon: Icon(Icons.clear),
      onPressed: () {
        setState(() {
          _urlController.clear();
        });
      },
    );
  }

  Widget _renderNewBookList() {
    if (requests.isEmpty) {
      return Center(
        child: Text("輸入書目 Url 添加"),
      );
    }

    return ListView.builder(itemBuilder: _buildEntry, itemCount: requests.length);
  }

  Widget _buildEntry(BuildContext context, int index) {
    final request = requests[index];
    final errorColor = Theme.of(context).errorColor;

    VoidCallback onDismissed = () {
      setState(() {
        requests = requests.rebuild((b) => b.removeAt(index));
      });
    };

    return AsyncValueBuilder.request(
      key: Key(request.url),
      request: request,
      dataBuilder: (BuildContext context, NewBook newBook) => Card(
        child: ListTile(
          leading: Icon(Icons.book),
          title: Text(newBook.bookName),
          subtitle: Text(request.url),
        ),
      ),
      errorBuilder: (BuildContext context, Object error) => _removable(
        key: Key(request.url),
        onDismissed: onDismissed,
        child: Card(
          child: ListTile(
            leading: Icon(Icons.error_outline, color: errorColor),
            title: Text(request.url),
            subtitle: Text(error.toString(), style: TextStyle(color: errorColor)),
            onTap: () {
              request.reload();
            },
            onLongPress: () {
              Clipboard.setData(ClipboardData(text: request.url));
              Scaffold.of(context).showSnackBar(SnackBar(content: Text('網站鏈接已經複製')));
            },
          ),
        ),
      ),
      waitingBuilder: (BuildContext context) => _ignorable(
          key: Key(request.url),
          onDismissed: onDismissed,
          child: Card(child: ListTile(leading: CircularProgressIndicator(value: null), title: Text(request.url)))),
    );
  }

  Widget _removable({Key key, VoidCallback onDismissed, Widget child}) => Dismissible(
      key: key,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        child: const Text('滑动删除', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (DismissDirection direction) => onDismissed(),
      dismissThresholds: const {DismissDirection.endToStart: .7},
      child: child);

  Widget _ignorable({Key key, VoidCallback onDismissed, Widget child}) => Dismissible(
      key: key,
      background: Container(
        color: Colors.yellow.shade700,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        child: const Text('忽略', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (DismissDirection direction) => onDismissed(),
      dismissThresholds: const {DismissDirection.endToStart: .7},
      child: child);
}
