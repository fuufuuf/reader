import 'dart:async';

import 'package:rxdart/rxdart.dart';

class EventBus {
  static PublishSubject<Object> bus = PublishSubject();

  static void post(Object event) {
    bus.add(event);
  }

  static StreamSubscription<T> on<T>(void onData(T event)) =>
      bus.ofType(TypeToken<T>()).listen(onData);
}
