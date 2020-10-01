import 'dart:async';

import 'package:meta/meta.dart';

abstract class Request<T> {
  @protected
  final StreamController<T> _controller;

  Stream<T> get resultStream => _controller.stream;

  Request() : _controller = StreamController(sync: true) {
    _controller.onListen = reload;
  }

  Future<T> reload({quiet: false}) async {
    if (!quiet) _controller.add(null);

    try {
      final result = await execute();

      _controller.add(result);

      return result;
    } catch (error) {
      _controller.addError(error);
      throw error;
    }
  }

  Future<T> execute();
}
