import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:reader/events/EventBus.dart';
import 'package:reader/events/OpenUrlEvent.dart';
import 'package:reader/models/ReadingTheme.dart';
import 'package:reader/presentations/ContentTypeLoader.dart';
import 'package:reader/presentations/EmptyContentView.dart';
import 'package:reader/presentations/ReadingThemeProvider.dart';

class MainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() =>
      _MainScreenState(
          currentUrl: Uri.parse(
              "https://www.piaotian.com/html/9/9054/5941033.html"),
          currentTheme: ReadingTheme.defaultTheme);
}

class _MainScreenState extends State<MainScreen> {
  Uri currentUrl;
  ReadingTheme currentTheme;

  StreamSubscription<OpenUrlEvent> _subscription;

  _MainScreenState({this.currentUrl, this.currentTheme});

  @override
  void initState() {
    super.initState();
    _subscription = EventBus.on(_onOpenUrlEvent);
  }

  @override
  void dispose() {
    if (_subscription != null) {
      _subscription.cancel();
    }

    super.dispose();
  }

  void _onOpenUrlEvent(OpenUrlEvent event) {
    this.setState(() {
      currentUrl = event.url;
    });
  }

  void _onSwitchNightMode(bool nightMode) {
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
          switchTheme: _onSwitchNightMode,
          child: _renderChild(context)
      );

  Widget _renderChild(BuildContext context) {
    if (currentUrl == null) {
      return EmptyContentView();
    } else {
      return ContentTypeLoader.loadFromUri(currentUrl);
    }
  }
}
