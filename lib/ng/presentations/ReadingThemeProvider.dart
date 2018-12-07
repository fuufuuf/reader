import 'package:flutter/widgets.dart';
import 'package:reader/ng/models/ReadingTheme.dart';

class ReadingThemeProvider extends InheritedWidget {
  final ReadingTheme theme;

  ReadingThemeProvider({Key key, this.theme, Widget child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) =>
      (oldWidget as ReadingThemeProvider).theme == theme;

  static ReadingTheme fetchReadingTheme(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(ReadingThemeProvider)
              as ReadingThemeProvider)
          .theme;
}
