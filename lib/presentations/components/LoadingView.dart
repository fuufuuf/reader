import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoadingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      Center(
              child: CircularProgressIndicator(value: null)
      );
}
