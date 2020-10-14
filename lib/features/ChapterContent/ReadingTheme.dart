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
    final color = appTheme.contentForegroundColor;

    final newTheme = theme.copyWith(
      textTheme: theme.textTheme.apply(
        displayColor: color,
        bodyColor: color,
        fontSizeFactor: appTheme.settings.readingTextScaleFactor,
      ),
    );

    return AnimatedTheme(
      duration: appTheme.defaultTransitionDuration,
      data: newTheme,
      isMaterialAppTheme: true,
      child: child,
    );
  }
}
