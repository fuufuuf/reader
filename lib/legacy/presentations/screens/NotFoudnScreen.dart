import 'package:flutter/material.dart';
import '../components/ErrorView.dart';
import '../components/ScreenScaffold.dart';

class NotFoundScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ScreenScaffold(
      title: 'Not Found', body: ErrorView(error: '404 Content Not Found'));
}
