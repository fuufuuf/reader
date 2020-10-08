import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:timnew_reader/app/AddNewBooks/NewBookRequestList.dart';
import 'package:timnew_reader/app/AddNewBooks/NewBookRequest.dart';
import 'package:timnew_reader/app/BookList/BookList.dart';
import 'package:timnew_reader/arch/RenderMixin.dart';
import 'package:timnew_reader/models/NewBook.dart';
import 'package:timnew_reader/presentations/components/SwipeRemovable.dart';
import 'package:timnew_reader/presentations/components/TextFormFieldWithClearButton.dart';
import 'package:timnew_reader/presentations/components/ScreenScaffold.dart';

class AddNewBookDialog extends StatefulWidget {
  final BookList bookList;
  final NewBookRequestList requests;

  AddNewBookDialog(this.bookList) : requests = NewBookRequestList(bookList);

  @override
  _AddNewBookDialogState createState() => _AddNewBookDialogState();

  static Future<NewBook> show(BuildContext context, BookList bookList) =>
      Navigator.push(context, MaterialPageRoute(builder: (_) => AddNewBookDialog(bookList), fullscreenDialog: true));
}

class _AddNewBookDialogState extends State<AddNewBookDialog> {
  final TextEditingController _urlController = TextEditingController();

  NewBookRequestList get requests => widget.requests;

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      title: '添加新書',
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

class _NewBookListView extends StatelessWidget
    with RenderValueStore<BuiltList<NewBookRequest>>, WithEmptyContent<BuiltList<NewBookRequest>> {
  final NewBookRequestList newBookList;

  _NewBookListView(this.newBookList);

  @override
  Widget build(BuildContext context) => buildValueStore(newBookList);

  @override
  bool checkEmpty(BuiltList<NewBookRequest> data) => data.isEmpty;

  @override
  Widget buildEmpty(BuildContext context) => Center(
        child: Text("輸入書目 Url 添加"),
      );

  @override
  Widget buildContent(BuildContext context, BuiltList<NewBookRequest> content) =>
      ListView.builder(itemCount: content.length, itemBuilder: _buildListItem);

  Widget _buildListItem(BuildContext context, int index) {
    final request = newBookList.value[index];

    return _NewBookListItem(
      request,
      () {
        newBookList.value = newBookList.value.rebuild((b) => b.removeAt(index));
      },
    );
  }
}

class _NewBookListItem extends StatelessWidget with RenderAsyncSnapshot<NewBook> {
  final VoidCallback removeItem;
  final NewBookRequest request;

  _NewBookListItem(this.request, this.removeItem) : super(key: Key(request.url));

  @override
  Widget build(BuildContext context) => buildStream(request.valueStream);

  @override
  Widget buildData(BuildContext context, NewBook data) {
    throw Card(
      child: ListTile(
        leading: _buildBookIcon(context, data.isDuplicated),
        title: _buildBookTitle(context, data),
        subtitle: Text(request.url),
      ),
    );
  }

  Widget _buildBookTitle(BuildContext context, NewBook newBook) {
    if (!newBook.isDuplicated) return Text(newBook.bookName);

    return RichText(
      text: TextSpan(children: [
        TextSpan(text: "[已存在] ", style: TextStyle(color: Colors.yellow.shade700)),
        TextSpan(text: newBook.bookName),
      ]),
    );
  }

  Widget _buildBookIcon(BuildContext context, bool isDuplicated) =>
      isDuplicated ? Icon(Icons.warning, color: Colors.yellow.shade700) : Icon(Icons.book);

  @override
  Widget buildError(BuildContext context, Object error) {
    final errorColor = Theme.of(context).errorColor;

    return SwipeRemovable(
      key: Key(request.url),
      onRemoved: removeItem,
      child: Card(
        child: ListTile(
          leading: Icon(Icons.error_outline, color: errorColor),
          title: Text(error.toString(), style: TextStyle(color: errorColor)),
          subtitle: Text(request.url),
          onTap: () {
            request.reload();
          },
          onLongPress: () {
            Clipboard.setData(ClipboardData(text: request.url));
            Scaffold.of(context).showSnackBar(SnackBar(content: Text('網站鏈接已經複製')));
          },
        ),
      ),
    );
  }

  @override
  Widget buildWaiting(BuildContext context) {
    return SwipeRemovable(
      key: Key(request.url),
      onRemoved: removeItem,
      child: Card(
        child: ListTile(
          leading: CircularProgressIndicator(value: null),
          title: Text("加載中..."),
          subtitle: Text(request.url),
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
