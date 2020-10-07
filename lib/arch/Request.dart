import 'dart:async';

import 'package:rxdart/rxdart.dart';

import 'FuncTypes.dart';
export 'FuncTypes.dart';

abstract class Request<T> {
  final BehaviorSubject<T> _subject;

  Stream<T> get valueStream => _subject;

  Request({T initialValue, bool executeOnFirstListen = true})
      : _subject = initialValue != null ? BehaviorSubject.seeded(initialValue) : BehaviorSubject() {
    if (executeOnFirstListen) {
      _subject.onListen = reload;
    }
  }

  FutureOr<T> execute();

  Future<T> reload({quiet: false}) async => await putValue(execute(), quiet: quiet);

  Future<T> putValue(FutureOr<T> value, {quiet: false}) async {
    if (!quiet && value is Future) markBusy();

    try {
      final result = await value;
      _subject.add(result);
      return result;
    } catch (error, stacktrace) {
      _subject.addError(error, stacktrace);
      rethrow;
    }
  }

  T putValueSync(T value) {
    putValue(value);
    return value;
  }

  void markBusy() {
    _subject.add(null);
  }

  bool get hasCurrentValue => _subject.hasValue;

  T get currentValue {
    if (!hasCurrentValue) throw StateError("Reading currentValue before it is ready");
    return _subject.value;
  }

  Future<T> get firstValue => valueStream.first;

  void updateValueSync(ValueUpdater<T> updater) {
    try {
      putValueSync(updater(currentValue));
    } on Exception catch (error, stacktrace) {
      _subject.addError(error, stacktrace);
    }
  }
}
