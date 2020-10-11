import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timnew_reader/features/Theme/AppTheme.dart';

class ReadingTheme extends StatelessWidget {
  final Widget child;

  const ReadingTheme({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final readingThemeData = context.watch<AppTheme>().readingThemeData;

    final newTheme = theme.copyWith(
      textTheme: theme.textTheme.apply(
        displayColor: readingThemeData.textColor,
        fontSizeFactor: readingThemeData.fontScaleFactor,
      ),
    );

    return Theme(
      data: newTheme,
      isMaterialAppTheme: true,
      child: child,
    );
  }
}
