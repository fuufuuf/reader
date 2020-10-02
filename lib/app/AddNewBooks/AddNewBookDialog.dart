import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:timnew_reader/app/AddNewBooks/NewBookRequestList.dart';
import 'package:timnew_reader/app/AddNewBooks/NewBookRequest.dart';
import 'package:timnew_reader/arch/ValueSourceBuilder.dart';
import 'package:timnew_reader/models/NewBook.dart';
import 'package:timnew_reader/presentations/components/SwipeRemovable.dart';
import 'package:timnew_reader/presentations/components/TextFormFieldWithClearButton.dart';
import 'package:timnew_reader/presentations/components/ScreenScaffold.dart';

class AddNewBookDialog extends StatefulWidget {
  final NewBookRequestList requests = NewBookRequestList();

  @override
  _AddNewBookDialogState createState() => _AddNewBookDialogState();

  static Future<NewBook> show(BuildContext context) =>
      Navigator.push(context, MaterialPageRoute(builder: (_) => AddNewBookDialog(), fullscreenDialog: true));
}

class _AddNewBookDialogState extends State<AddNewBookDialog> {
  final TextEditingController _urlController = TextEditingController();

  NewBookRequestList get requests => widget.requests;

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      title: '添加新書!!',
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormFieldWithClearButton(
                labelText: "新書 Url",
                controller: _urlController,
                onFieldSubmitted: _newUrlEntered,
              ),
              Expanded(child: _NewBookListView(requests)),
              Align(
                  alignment: Alignment.centerRight,
                  child: ButtonBar(
                    children: <Widget>[
                      _FormButton(text: '清空', onPressed: _clearRequests),
                      _FormButton(text: '從剪貼盤加載', onPressed: _onLoadFromClipboard)
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  void _newUrlEntered(String value) {
    _urlController.clear();
    requests.tryAdd(value);
  }

  void _clearRequests() {
    requests.clear();
  }

  void _onLoadFromClipboard() async {
    var data = await Clipboard.getData(Clipboard.kTextPlain);

    requests.tryAdd(data.text);
  }
}

class _NewBookListView extends ValueSourceBuilder<BuiltList<NewBookRequest>, NewBookRequestList> {
  _NewBookListView(NewBookRequestList newBookList) : super(newBookList);

  @override
  Widget buildValue(BuildContext context, BuiltList<NewBookRequest> value) {
    if (value.isEmpty) return _buildEmptyView();

    return ListView.builder(itemCount: value.length, itemBuilder: _buildListItem);
  }

  Widget _buildEmptyView() => Center(
        child: Text("輸入書目 Url 添加"),
      );

  Widget _buildListItem(BuildContext context, int index) {
    final request = currentValue[index];

    return _NewBookListItem(
      request,
      () {
        putValue(currentValue.rebuild((b) => b.removeAt(index)));
      },
    );
  }
}

class _NewBookListItem extends ValueSourceBuilder<NewBook, NewBookRequest> {
  final VoidCallback removeItem;

  _NewBookListItem(NewBookRequest request, this.removeItem) : super(request, key: Key(request.url));

  @override
  Widget buildValue(BuildContext context, NewBook newBook) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.book),
        title: Text(newBook.bookName),
        subtitle: Text(valueSource.url),
      ),
    );
  }

  @override
  Widget buildError(BuildContext context, Object error) {
    final errorColor = Theme.of(context).errorColor;

    return SwipeRemovable(
      key: Key(valueSource.url),
      onRemoved: removeItem,
      child: Card(
        child: ListTile(
          leading: Icon(Icons.error_outline, color: errorColor),
          title: Text(error.toString(), style: TextStyle(color: errorColor)),
          subtitle: Text(valueSource.url),
          onTap: () {
            valueSource.reload();
          },
          onLongPress: () {
            Clipboard.setData(ClipboardData(text: valueSource.url));
            Scaffold.of(context).showSnackBar(SnackBar(content: Text('網站鏈接已經複製')));
          },
        ),
      ),
    );
  }

  Widget buildWaiting(BuildContext context) {
    return SwipeRemovable(
      key: Key(valueSource.url),
      onRemoved: removeItem,
      child: Card(
        child: ListTile(
          leading: CircularProgressIndicator(value: null),
          title: Text("加載中..."),
          subtitle: Text(valueSource.url),
        ),
      ),
    );
  }
}

class _FormButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  _FormButton({Key key, this.text, this.onPressed}) : super(key: key ?? Key(text));

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Text(text),
      onPressed: onPressed,
    );
  }
}
