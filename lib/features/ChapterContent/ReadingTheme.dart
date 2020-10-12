import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timnew_reader/features/Theme/AppTheme.dart';

class ReadingTheme extends StatelessWidget {
  final Widget child;

  const ReadingTheme({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final appTheme = context.watch<AppTheme>();
    final readingThemeData = appTheme.readingThemeData;

    final newTheme = theme.copyWith(
      textTheme: theme.textTheme.apply(
        displayColor: readingThemeData.textColor,
        bodyColor: readingThemeData.textColor,
        fontSizeFactor: readingThemeData.fontScaleFactor,
      ),
    );

    return AnimatedTheme(
      duration: appTheme.transitionDuration,
      data: newTheme,
      isMaterialAppTheme: true,
      child: child,
    );
  }
}
