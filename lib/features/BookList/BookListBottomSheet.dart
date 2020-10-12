import 'package:flutter/material.dart';

import 'BookListRequest.dart';

class BookListBottomSheet extends StatelessWidget {
  final BookListRequest request;
  final VoidCallback onAddNewBook;
  final VoidCallback onExportAllBooks;

  BookListBottomSheet({@required this.request, @required this.onAddNewBook, @required this.onExportAllBooks});

  static const String routeName = "BookListBottomSheet";

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            InkWell(
              child: ListTile(
                leading: Icon(Icons.add),
                title: Text("添加新書"),
                onTap: () => dismiss(context, onAddNewBook),
              ),
            ),
            InkWell(
              child: ListTile(
                leading: Icon(Icons.archive),
                title: Text("導出書目"),
                onTap: () => dismiss(context, onExportAllBooks),
              ),
            ),
          ],
        ),
      );

  void dismiss(BuildContext context, [VoidCallback onDismissed]) {
    Navigator.of(context).pop();

    if (onDismissed != null) {
      onDismissed();
    }
  }
}
