import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timnew_reader/arch/Loader.dart';
import 'package:timnew_reader/features/BookList/BookListScreen.dart';
import 'package:timnew_reader/features/Theme/AppTheme.dart';
import 'package:timnew_reader/features/Theme/AppThemeLoader.dart';
import 'package:timnew_reader/features/Theme/ThemeManager.dart';
import 'package:timnew_reader/repositories/settings/ThemeRepository.dart';
import 'package:timnew_reader/features/Theme/ReadingThemeData.dart';

import 'PersistentStorageInitializer.dart';

class ReaderApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ReaderAppState(false);
}

class _ReaderAppState extends State<ReaderApp> {
  bool nightMode;
  ReadingThemeData currentTheme;

  _ReaderAppState(this.nightMode) {
    reloadTheme();
  }

  void toggleNightMode() {
    nightMode = !nightMode;
    reloadTheme();
  }

  void reloadTheme() {
    final themeId = nightMode ? ThemeRepository.nightTheme : ThemeRepository.dayTheme;

    currentTheme = ThemeRepository.fetchTheme(themeId);
  }

  VoidCallback wrap(VoidCallback callback) => () {
        setState(callback);
      };

  @override
  Widget build(BuildContext context) => MultiLoader(
        aspects: [
          PersistentStorageInitializer(),
          AppThemeLoader(),
          AspectLoader.wrap(ListenableProvider<ThemeManager>(create: (context) => context.read<ThemeManager>())),
        ],
        builder: buildApp,
      );

  Widget buildApp(BuildContext context, Widget child) {
    final appTheme = context.watch<AppTheme>();

    return MaterialApp(
      title: 'Reader',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: appTheme.brightness),
      home: BookListScreen(),
    );
  }
}
