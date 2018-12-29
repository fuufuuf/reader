import 'package:flutter/material.dart';
import 'package:timnew_reader/presentations/ReaderApp.AppRouter.dart';
import 'package:timnew_reader/presentations/wrappers/ReadingThemeProvider.dart';
import 'package:timnew_reader/repositories/settings/ThemeRepository.dart';
import 'package:timnew_reader/models/ReadingTheme.dart';

class ReaderApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() =>
      _ReaderAppState(false);
}

class _ReaderAppState extends State<ReaderApp> {
  bool nightMode;
  ReadingTheme currentTheme;

  AppRouter _appRouter;

  _ReaderAppState(this.nightMode) {
    _appRouter = AppRouter();
    reloadTheme();
  }

  void toggleNightMode() {
    nightMode = !nightMode;
    reloadTheme();
  }

  void reloadTheme() {
    final themeId = nightMode ? ThemeRepository.nightTheme : ThemeRepository
        .dayTheme;

    currentTheme = ThemeRepository.fetchTheme(themeId);
  }


  VoidCallback wrap(VoidCallback callback) =>
          () {
        setState(callback);
      };

  @override
  Widget build(BuildContext context) =>
      ReadingThemeProvider(
          theme: currentTheme,
          toggleNightModeApi: wrap(toggleNightMode),
          reloadThemeApi: wrap(reloadTheme),
          child: _renderApp()
      );

  Widget _renderApp() =>
      MaterialApp(
        title: 'Reader',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: _appRouter.initialRoute,
        onGenerateRoute: _appRouter.generateRoute,
        onUnknownRoute: _appRouter.onUnknownRoute,
      );
}
