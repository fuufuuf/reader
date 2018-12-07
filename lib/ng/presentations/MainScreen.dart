import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:reader/ng/events/EventBus.dart';
import 'package:reader/ng/events/OpenUrlEvent.dart';
import 'package:reader/ng/presentations/ContentTypeLoader.dart';
import 'package:reader/ng/presentations/EmptyContentView.dart';

class MainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() =>
      _MainScreenState(
          currentUrl: Uri.parse(
              "https://www.piaotian.com/html/9/9054/5941035.html"));
}

class _MainScreenState extends State<MainScreen> {
  Uri currentUrl;

  StreamSubscription<OpenUrlEvent> _subscription;

  _MainScreenState({this.currentUrl});

  @override
  void initState() {
    super.initState();

    _subscription = EventBus.on(onOpenUrlEvent);
  }

  @override
  void dispose() {
    if (_subscription != null) {
      _subscription.cancel();
    }

    super.dispose();
  }

  void onOpenUrlEvent(OpenUrlEvent event) {
    this.setState(() {
      currentUrl = event.url;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (currentUrl == null) {
      return EmptyContentView();
    } else {
      return ContentTypeLoader.loadFromUri(currentUrl);
    }
  }
}
