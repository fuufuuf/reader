import 'package:flutter/widgets.dart';
import 'package:reader/models/ReadingTheme.dart';

typedef void SwitchTheme(bool nightMode);

class ReadingThemeProvider extends InheritedWidget {
  final ReadingTheme theme;
  final SwitchTheme switchTheme;

  ReadingThemeProvider({Key key, this.theme, this.switchTheme, Widget child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) =>
      (oldWidget as ReadingThemeProvider).theme == theme;

  static ReadingThemeProvider fetch(BuildContext context) =>
      context.inheritFromWidgetOfExactType(
          ReadingThemeProvider) as ReadingThemeProvider;

  static ReadingTheme fetchTheme(BuildContext context) =>
      fetch(context).theme;
}
