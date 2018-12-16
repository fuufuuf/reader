import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ErrorView extends StatelessWidget {
  final Object error;

  ErrorView({this.error});

  @override
  Widget build(BuildContext context) =>
      Center(
          child: Text(error.toString(),
              style: TextStyle(color: Theme
                  .of(context)
                  .errorColor)
          )
      );
}
