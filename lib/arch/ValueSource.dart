import 'dart:async';

import 'package:flutter/widgets.dart';

abstract class ValueSource<T> {
  @protected
  final StreamController<T> _controller;

  Stream<T> get valueStream => _controller.stream;

  ValueSource([T initialValue]) : _controller = StreamController.broadcast(sync: true) {
    _controller.onListen = _onListen;
    _value = initialValue;
  }

  T _value;
  Object _error;

  bool get hasValue => _value != null;

  bool get hasError => _error != null;

  bool get hasCurrent => hasValue || hasError;

  T get currentValue => _value;

  Object get currentError => _error;

  Future<T> get value async {
    if (hasValue) return currentValue;
    if (hasError) return Future.error(currentError);

    return valueStream.first;
  }

  T _putValue(T value) {
    _value = value;
    _error = null;
    if (_controller.hasListener) _controller.add(value);

    return value;
  }

  Object _putError(Object error) {
    _error = error;
    _value = null;
    if (_controller.hasListener) _controller.addError(error);

    return error;
  }

  void _announceCurrent() {
    if (hasValue) _controller.add(currentValue);
    if (hasError) _controller.addError(currentError);
  }

  void _onListen() {
    if (hasCurrent)
      _announceCurrent();
    else
      reload();
  }

  Future<T> reload({quiet: false}) async => putValue(initialize(), quiet: quiet);

  Future<T> putValue(FutureOr<T> value, {quiet: false}) async {
    if (!quiet && value is Future) markBusy();

    try {
      return _putValue(await value);
    } on Exception catch (error) {
      throw _putError(error);
    }
  }

  T putValueSync(T value) {
    putValue(value);
    return value;
  }

  void markBusy() {
    _controller.add(null);
  }

  FutureOr<T> initialize();
}
