import 'dart:async';

import 'package:timnew_reader/arch/BehaviourSubject.dart';

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
    if (!quiet && value is Future) markAsWaiting();

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

  void markAsWaiting() {
    _subject.add(null);
  }

  bool get hasData => _subject.hasValue;

  T get currentData {
    if (!hasData) throw StateError("Reading currentValue when there isn't data");
    return _subject.value;
  }

  bool get hasError => _subject.hasError;

  Object get currentError => _subject.error;

  StackTrace get currentErrorStackTrace => _subject.errorStackTrace;

  bool get hasCurrent => hasData || hasError;

  Future<T> get first => valueStream.firstWhere((result) => result != null);

  void updateValueSync(ValueUpdater<T> updater) {
    try {
      putValueSync(updater(currentData));
    } on Exception catch (error, stacktrace) {
      _subject.addError(error, stacktrace);
    }
  }
}
