import 'dart:async';

import 'package:rxdart/rxdart.dart';

abstract class Request<T> {
  final BehaviorSubject<T> _controller;

  Stream<T> get valueStream => _controller.stream;

  Request({T initialValue, bool executeOnFirstListen = true})
      : _controller = initialValue != null ? BehaviorSubject.seeded(initialValue) : BehaviorSubject() {
    if (executeOnFirstListen) {
      _controller.onListen = reload;
    }
  }

  FutureOr<T> execute();

  Future<T> reload({quiet: false}) async => putValue(execute(), quiet: quiet);

  Future<T> putValue(FutureOr<T> value, {quiet: false}) async {
    if (!quiet && value is Future) markBusy();

    try {
      final result = await value;
      _controller.add(result);
      return result;
    } catch (error, stacktrace) {
      _controller.addError(error, stacktrace);
      rethrow;
    }
  }

  T putValueSync(T value) {
    putValue(value);
    return value;
  }

  void markBusy() {
    _controller.add(null);
  }

  bool get hasCurrentValue => _controller.hasValue;

  T get currentValue => _controller.value;

  Future<T> get firstValue => valueStream.first;
}
