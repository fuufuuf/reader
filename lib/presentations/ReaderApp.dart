import 'package:flutter/material.dart';
import 'package:reader/models/ReadingTheme.dart';
import 'package:reader/presentations/providers/ReadingThemeProvider.dart';
import 'package:reader/presentations/wrappers/ContentTypeLoader.dart';

class ReaderApp extends StatefulWidget {
  // This widget is the root of your application.

  @override
  State<StatefulWidget> createState() =>
      _ReaderAppState(ReadingTheme.defaultTheme);
}

class _ReaderAppState extends State<ReaderApp> {
  ReadingTheme currentTheme;

  _ReaderAppState(this.currentTheme);

  void updateTheme(bool nightMode) {
    this.setState(() {
      this.currentTheme = nightMode ?
      ReadingTheme.darkTheme :
      ReadingTheme.defaultTheme;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Reader',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ReadingThemeProvider(
            theme: currentTheme,
            switchTheme: updateTheme,
          child: ContentTypeLoader.loadFromUriString(
              'https://www.piaotian.com/html/9/9054/6877125.html'),
        )
    );
  }
}


