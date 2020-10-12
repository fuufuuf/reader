import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timnew_reader/arch/Loader.dart';
import 'package:timnew_reader/features/BookList/BookListScreen.dart';
import 'package:timnew_reader/features/Theme/AppTheme.dart';
import 'package:timnew_reader/features/Theme/AppThemeLoader.dart';
import 'package:timnew_reader/features/Theme/ThemeManager.dart';

import 'PersistentStorageInitializer.dart';

class ReaderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Reader',
        debugShowCheckedModeBanner: false,
        builder: buildWrapper,
        home: BookListScreen.initialRoute(),
      );

  Widget buildWrapper(BuildContext context, Widget child) {
    return MultiLoader(
      aspects: [PersistentStorageInitializer(), AppThemeLoader()],
      builder: buildAppThemeProvider,
      child: child,
    );
  }

  Widget buildAppThemeProvider(BuildContext context, Widget child) {
    return ValueListenableProvider(
      create: (context) => context.read<ThemeManager>(),
      builder: buildTheme,
      child: child,
    );
  }

  Widget buildTheme(BuildContext context, Widget child) {
    final appTheme = context.watch<AppTheme>();

    return AnimatedTheme(
      duration: appTheme.transitionDuration,
      data: ThemeData(brightness: appTheme.brightness),
      child: child,
    );
  }
}
