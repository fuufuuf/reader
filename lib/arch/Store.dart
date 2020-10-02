import 'dart:async';

import 'package:flutter/widgets.dart';

import 'StoreHost.dart';

abstract class Store<T> {
  @protected
  final StreamController<T> _controller;

  Stream<T> get valueStream => _controller.stream;

  Store() : _controller = StreamController(sync: true) {
    _controller.onListen = reload;
  }

  Future<T> reload({quiet: false}) async => putValue(initialize(), quiet: quiet);

  Future<T> putValue(FutureOr<T> value, {quiet: false}) async {
    if (!quiet) markBusy();

    try {
      final result = await value;

      _controller.add(result);

      return result;
    } catch (error) {
      _controller.addError(error);
      throw error;
    }
  }

  void markBusy() {
    _controller.add(null);
  }

  FutureOr<T> initialize();

  static TR find<TR extends Store>(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<StoreProvider<TR>>().request;
}
