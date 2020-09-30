import 'package:flutter/widgets.dart';
import 'package:timnew_reader/models/ReadingTheme.dart';

typedef void ThemeCallback();

class ReadingThemeProvider extends InheritedWidget {
  final ReadingTheme theme;
  final ThemeCallback toggleNightModeApi;
  final ThemeCallback reloadThemeApi;

  ReadingThemeProvider(
      {Key key,
      this.theme,
      this.toggleNightModeApi,
      this.reloadThemeApi,
      Widget child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) =>
      (oldWidget as ReadingThemeProvider).theme == theme;

  static ReadingThemeProvider _provider(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType();

  static ReadingTheme of(BuildContext context) => _provider(context).theme;

  static void toggleNightMode(BuildContext context) =>
      _provider(context).toggleNightModeApi();

  static void reloadTheme(BuildContext context) =>
      _provider(context).reloadThemeApi();
}
