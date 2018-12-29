import 'package:flutter/widgets.dart';
import 'package:reader/viewModels/ReadingTheme.dart';

typedef void ToggleNightModeCallback();

class ReadingThemeProvider extends InheritedWidget {
  final ReadingTheme theme;
  final ToggleNightModeCallback toggleNightModeApi;

  ReadingThemeProvider(
      {Key key, this.theme, this.toggleNightModeApi, Widget child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) =>
      (oldWidget as ReadingThemeProvider).theme == theme;

  static ReadingTheme of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(
          ReadingThemeProvider) as ReadingThemeProvider).theme;

  static void toggleNightMode(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(
          ReadingThemeProvider) as ReadingThemeProvider)
          .toggleNightModeApi();
}
