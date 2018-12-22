import 'package:flutter/material.dart';
import 'package:reader/presentations/ReaderApp.AppRouter.dart';
import 'package:reader/presentations/wrappers/ReadingThemeProvider.dart';
import 'package:reader/viewModels/ReadingTheme.dart';

class ReaderApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() =>
      _ReaderAppState(ReadingTheme.defaultTheme);
}

class _ReaderAppState extends State<ReaderApp> {
  ReadingTheme currentTheme;
  AppRouter _appRouter;

  _ReaderAppState(this.currentTheme) :
        _appRouter= AppRouter();

  void updateTheme(bool nightMode) {
    this.setState(() {
      this.currentTheme = nightMode ?
      ReadingTheme.darkTheme :
      ReadingTheme.defaultTheme;
    });
  }

  @override
  Widget build(BuildContext context) =>
      ReadingThemeProvider(
          theme: currentTheme,
          switchThemeApi: updateTheme,
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
