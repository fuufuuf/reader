import 'package:flutter/material.dart';
import 'package:reader/presentations/ReaderApp.AppRouter.dart';
import 'package:reader/presentations/wrappers/ReadingThemeProvider.dart';
import 'package:reader/viewModels/ReadingTheme.dart';

class ReaderApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() =>
      _ReaderAppState(false);
}

class _ReaderAppState extends State<ReaderApp> {
  bool nightMode;
  AppRouter _appRouter;

  ReadingTheme get currentTheme =>
      nightMode ? ReadingTheme.nightTheme : ReadingTheme.dayTheme;

  _ReaderAppState(this.nightMode) :
        _appRouter= AppRouter();

  void toggleNightMode() {
    this.setState(() {
      nightMode = !nightMode;
    });
  }

  @override
  Widget build(BuildContext context) =>
      ReadingThemeProvider(
          theme: currentTheme,
          toggleNightModeApi: toggleNightMode,
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
