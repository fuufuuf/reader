import 'package:flutter/widgets.dart';

class ErrorView extends StatelessWidget {
  final Object error;

  ErrorView({this.error});

  @override
  Widget build(BuildContext context) => Center(
      child: Column(
          children: <Widget>[const Text("Error"), Text(error.toString())]));
}
