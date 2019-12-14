import 'package:flutter/material.dart';
import 'package:timnew_reader/features/booklist/BookListLoadingInteractor.dart';

import 'BookListScreenView.dart';

class BookListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => BookListLoadingInteractorWidget(
      childBuilder: (_) => BookListScreenView());
}
