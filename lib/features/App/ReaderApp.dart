import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:timnew_reader/features/BookList/BookListScreen.dart';
import 'package:timnew_reader/features/Theme/AppTheme.dart';
import 'package:timnew_reader/features/Theme/AppThemeManager.dart';

import 'SplashScreen.dart';

class ReaderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Reader',
        debugShowCheckedModeBanner: false,
        builder: buildWrapper,
        home: Builder(builder: (_) => BookListScreen.create()),
      );

  Widget buildWrapper(BuildContext context, Widget child) {
    return SplashScreen(
      builder: buildAppThemeProvider,
      child: child,
    );
  }

  Widget buildAppThemeProvider(BuildContext context, Widget child) {
    return ValueListenableProvider.value(
      value: AppThemeManager.instance,
      builder: buildTheme,
      child: child,
    );
  }

  Widget buildTheme(BuildContext context, Widget child) {
    final appTheme = context.watch<AppTheme>();

    return AnimatedTheme(
      duration: appTheme.defaultTransitionDuration,
      data: ThemeData(brightness: appTheme.palette.brightness),
      child: child,
    );
  }
}
