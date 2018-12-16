import 'package:flutter/material.dart';
import 'package:reader/models/BookEntry.dart';
import 'package:reader/presentations/components/ScreenScaffold.dart';

class AddBookDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddBookDialogState();

  static Future<BookEntry> show(BuildContext context) => Navigator.push(
      context,
      MaterialPageRoute(
          builder: (_) => AddBookDialog(), fullscreenDialog: true));
}

class _AddBookDialogState extends State<AddBookDialog> {
  @override
  Widget build(BuildContext context) => ScreenScaffold(
        title: 'Add new book',
        body: _renderBody(context),
      );

  Widget _renderBody(BuildContext context) => null;
}
