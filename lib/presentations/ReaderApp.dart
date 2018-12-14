import 'package:flutter/material.dart';
import 'package:reader/models/ReadingTheme.dart';
import 'package:reader/presentations/providers/ReadingThemeProvider.dart';
import 'package:reader/presentations/screens/EmptyContentScreen.dart';
import 'package:reader/presentations/wrappers/ContentTypeLoader.dart';

class ReaderApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() =>
      _ReaderAppState(ReadingTheme.defaultTheme);

  static void openUrl(BuildContext context, Uri url) {
    Navigator.of(context).push(
        MaterialPageRoute(
            builder: (BuildContext context) =>
                ContentTypeLoader.loadFromUri(url)
        )
    );
  }
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
    return ReadingThemeProvider(
        theme: currentTheme,
        switchTheme: updateTheme,
        child: MaterialApp(
            title: 'Reader',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: EmptyContentScreen()
        )
    );
  }
}


