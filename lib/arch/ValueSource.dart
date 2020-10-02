import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:timnew_reader/arch/AsyncValueBuilder.dart';

abstract class ValueSource<T> {
  @protected
  final StreamController<T> _controller;

  Stream<T> get valueStream => _controller.stream;

  ValueSource() : _controller = StreamController(sync: true) {
    _controller.onListen = reload;
  }

  T _value;
  Object _error;

  bool get hasValue => _value != null;

  bool get hasError => _error != null;

  bool get hasCurrent => hasValue || hasError;

  T get value => _value;

  Object get error => _error;

  T _putValue(T value) {
    _value = value;
    _error = null;
    _controller.add(value);

    return value;
  }

  Object _putError(Object error) {
    _error = error;
    _value = null;
    _controller.addError(error);

    return error;
  }

  Future<T> reload({quiet: false}) async => putValue(initialize(), quiet: quiet);

  Future<T> putValue(FutureOr<T> value, {quiet: false}) async {
    if (!quiet) markBusy();

    try {
      return _putValue(await value);
    } on Exception catch (error) {
      throw _putError(error);
    }
  }

  void markBusy() {
    _controller.add(null);
  }

  FutureOr<T> initialize();

  static TS find<TS extends ValueSource>(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_ValueSourceInheritedWidget<TS>>().request;
}

typedef bool SourceChangeChecker<TS extends ValueSource>(TS current, TS old);

abstract class ValueSourceHost<T, TS extends ValueSource<T>> extends StatelessWidget {
  final TS valueSource;

  ValueSourceHost(this.valueSource);

  @override
  Widget build(BuildContext context) => _ValueSourceInheritedWidget(valueSource, buildChild(), checkRequestChanged);

  bool checkRequestChanged(TS current, TS old) => current != old;

  Widget buildChild() => AsyncValueBuilder.valueSource(
        valueSource: valueSource,
        dataBuilder: buildValue,
        errorBuilder: buildError,
        waitingBuilder: buildWaiting,
        activeBuilder: buildActive,
        noneBuilder: buildNoValue,
      );

  Widget buildValue(BuildContext context, T value);

  Widget buildError(BuildContext context, Offset error) => AsyncValueBuilder.defaultErrorBuilder(context, error);

  Widget buildWaiting(BuildContext context) => AsyncValueBuilder.defaultWaitingBuilder(context);

  Widget buildActive(BuildContext context) => AsyncValueBuilder.defaultWaitingBuilder(context);

  Widget buildNoValue(BuildContext context) => AsyncValueBuilder.defaultWaitingBuilder(context);
}

class _ValueSourceInheritedWidget<TS extends ValueSource> extends InheritedWidget {
  final TS request;

  final SourceChangeChecker changeChecker;

  const _ValueSourceInheritedWidget(this.request, Widget child, this.changeChecker)
      : assert(request != null),
        assert(child != null),
        assert(changeChecker != null),
        super(child: child);

  @override
  bool updateShouldNotify(_ValueSourceInheritedWidget old) => changeChecker(request, old.request);
}
