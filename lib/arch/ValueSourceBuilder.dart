import 'dart:async';

import 'package:flutter/widgets.dart';

import 'ValueSource.dart';
import 'AsyncValueBuilder.dart';

abstract class ValueSourceBuilder<T, TS extends ValueSource<T>> extends StatelessWidget {
  final TS valueSource;

  T get currentValue {
    if (!valueSource.hasValue) throw StateError("Access value when it doesn't exists");

    return valueSource.currentValue;
  }

  Object get currentError {
    if (!valueSource.hasError) throw StateError("Access value when it doesn't exists");

    return valueSource.currentError;
  }

  Future<T> putValue(FutureOr<T> value, {quiet: false}) => valueSource.putValue(value, quiet: quiet);

  ValueSourceBuilder(this.valueSource, {Key key})
      : assert(valueSource != null),
        super(key: key);

  @override
  Widget build(BuildContext context) => AsyncValueBuilder.valueSource(
        valueSource: valueSource,
        dataBuilder: buildValue,
        errorBuilder: buildError,
        waitingBuilder: buildWaiting,
        activeBuilder: buildActive,
        noneBuilder: buildNoValue,
      );

  Widget buildValue(BuildContext context, T value);

  Widget buildError(BuildContext context, Object error) => AsyncValueBuilder.defaultErrorBuilder(context, error);

  Widget buildWaiting(BuildContext context) => AsyncValueBuilder.defaultWaitingBuilder(context);

  Widget buildActive(BuildContext context) => buildWaiting(context);

  Widget buildNoValue(BuildContext context) => buildWaiting(context);
}
