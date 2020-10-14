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

    final newTheme = theme.copyWith(textTheme: _patchTextTheme(theme.textTheme, appTheme));

    return AnimatedTheme(
      duration: appTheme.defaultTransitionDuration,
      data: newTheme,
      isMaterialAppTheme: true,
      child: child,
    );
  }

  TextTheme _patchTextTheme(TextTheme theme, AppTheme appTheme) {
    final color = appTheme.contentForegroundColor;
    final textScaleFactor = appTheme.settings.readingTextScaleFactor;
    final lineScaleFactor = appTheme.settings.readingLineSpaceScaleFactor;

    final newTheme = theme.apply(bodyColor: color, displayColor: color, fontSizeFactor: textScaleFactor);

    final patchedLineHeight = TextTheme(
      headline1: newTheme.headline1?.copyWith(
        height: lineScaleFactor,
      ),
      headline2: newTheme.headline2?.copyWith(
        height: lineScaleFactor,
      ),
      headline3: newTheme.headline3?.copyWith(
        height: lineScaleFactor,
      ),
      headline4: newTheme.headline4?.copyWith(
        height: lineScaleFactor,
      ),
      headline5: newTheme.headline5?.copyWith(
        height: lineScaleFactor,
      ),
      headline6: newTheme.headline6?.copyWith(
        height: lineScaleFactor,
      ),
      subtitle1: newTheme.subtitle1?.copyWith(
        height: lineScaleFactor,
      ),
      subtitle2: newTheme.subtitle2?.copyWith(
        height: lineScaleFactor,
      ),
      bodyText1: newTheme.bodyText1?.copyWith(
        height: lineScaleFactor,
      ),
      bodyText2: newTheme.bodyText2?.copyWith(
        height: lineScaleFactor,
      ),
      caption: newTheme.caption?.copyWith(
        height: lineScaleFactor,
      ),
    );

    return patchedLineHeight;
  }
}
