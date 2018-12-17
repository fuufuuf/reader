import 'package:flutter/material.dart';
import 'package:reader/presentations/components/ErrorView.dart';
import 'package:reader/presentations/components/ScreenScaffold.dart';

class NotFoundScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ScreenScaffold(
      title: 'Not Found', body: ErrorView(error: '404 Content Not Found'));
}
