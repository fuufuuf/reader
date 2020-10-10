import 'dart:async';

import 'package:async/async.dart';
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

  T get result => null;

  FutureOr<T> load();

  Future<Result<T>> reload({quiet: false}) async => await execute(load(), quiet: quiet);

  Future<Result<T>> execute(FutureOr<T> value, {quiet: false}) async {
    if (!quiet && value is Future) markAsWaiting();

    try {
      final result = await value;
      return putValue(result);
    } on Exception catch (error, stackTrace) {
      return putError(error, stackTrace);
    } catch (error) {
      rethrow;
    }
  }

  ValueResult<T> putValue(T value) {
    _subject.add(value);
    return Result.value(value);
  }

  ErrorResult putError(Object error, StackTrace stackTrace) {
    _subject.addError(error, stackTrace);
    return Result.error(error, stackTrace);
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

  Result<T> safeUpdate(ValueUpdater<T> updater) {
    try {
      return putValue(updater(currentData));
    } on Exception catch (error, stacktrace) {
      return putError(error, stacktrace);
    } catch (error) {
      rethrow;
    }
  }

  Future<Result<T>> safeUpdateAsync(AsyncValueUpdater<T> updater, {quiet: false}) {
    return execute(updater(currentData), quiet: quiet);
  }
}
