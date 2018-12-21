import 'package:flutter/widgets.dart';
import 'package:reader/viewModels/ReadingTheme.dart';

typedef void SwitchTheme(bool nightMode);

class ReadingThemeProvider extends InheritedWidget {
  final ReadingTheme theme;
  final SwitchTheme switchThemeApi;

  ReadingThemeProvider({Key key, this.theme, this.switchThemeApi, Widget child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) =>
      (oldWidget as ReadingThemeProvider).theme == theme;

  static ReadingTheme of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(
          ReadingThemeProvider) as ReadingThemeProvider).theme;

  static void switchTheme(BuildContext context, bool nightMode) =>
      (context.inheritFromWidgetOfExactType(
          ReadingThemeProvider) as ReadingThemeProvider)
          .switchThemeApi(nightMode);
}
