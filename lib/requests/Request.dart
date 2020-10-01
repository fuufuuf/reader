import 'dart:async';

import 'package:meta/meta.dart';

abstract class Request<T> {
  @protected
  final StreamController<T> _controller;

  Stream<T> get resultStream => _controller.stream;

  Request() : _controller = StreamController(sync: true) {
    _controller.onListen = reload;
  }

  Future<T> reload({quiet: false}) async => putValue(execute(), quiet: quiet);

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

  FutureOr<T> execute();
}
