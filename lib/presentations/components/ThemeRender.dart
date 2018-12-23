import 'package:flutter/material.dart';
import 'package:reader/viewModels/ReadingTheme.dart';

class ThemeRender extends StatelessWidget {
  final ReadingTheme theme;

  final Widget child;

  ThemeRender({Key key, this.theme, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(color: theme.textColor);
    return DefaultTextStyle.merge(
        style: textStyle,
        child: IconTheme.merge(
          data: IconThemeData(size: textStyle.fontSize, color: theme.textColor),
          child: child,
        ));
  }
}
