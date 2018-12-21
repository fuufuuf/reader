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
  final AppRouter _router;

  ReadingTheme currentTheme;

  _ReaderAppState(this.currentTheme)
      : _router = AppRouter();

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
        initialRoute: _router.initialRoute,
        onGenerateRoute: _router.generateRoute,
        onUnknownRoute: _router.onUnknownRoute,
      );
}
