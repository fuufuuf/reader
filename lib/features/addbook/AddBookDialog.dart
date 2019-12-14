import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_event_bus/flutter_event_bus.dart';
import 'package:timnew_reader/bookparser/BookRepository.dart';
import 'package:timnew_reader/models/CurrentBook.dart';

part '_AddBookForm.dart';
part '_DialogView.dart';
part '_FormButtonBar.dart';
part '_FutureBookInfoBox.dart';
part '_UrlField.dart';
part '_events.dart';

class AddBookDialog extends StatelessWidget {
  static Future<CurrentBook> showDialog(BuildContext context) =>
      Navigator.push<CurrentBook>(
          context,
          MaterialPageRoute(
              maintainState: true,
              fullscreenDialog: true,
              builder: (_) => AddBookDialog()));

  @override
  Widget build(BuildContext context) => _DialogView();
}
