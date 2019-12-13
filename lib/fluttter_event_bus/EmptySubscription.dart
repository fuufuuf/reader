import 'dart:async';

import 'package:flutter_event_bus/flutter_event_bus.dart';

class EmptySubscription implements Subscription {
  @override
  void dispose() {
    subscriptions.clear();
  }

  @override
  Subscription respond<T>(responder) {
    throw Exception("Empty Subscription doesn't support respond");
  }

  @override
  List<StreamSubscription> get subscriptions => List(0);
}
