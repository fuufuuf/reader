import 'dart:async';

// ignore: implementation_imports
import 'package:rxdart/src/rx.dart';

// ignore: implementation_imports
import 'package:rxdart/src/streams/value_stream.dart';

// ignore: implementation_imports
import 'package:rxdart/src/subjects/subject.dart';

// ignore: implementation_imports
import 'package:rxdart/src/transformers/start_with.dart';

// ignore: implementation_imports
import 'package:rxdart/src/transformers/start_with_error.dart';

class BehaviorSubject<T> extends Subject<T> implements ValueStream<T> {
  _Wrapper<T> _wrapper;

  BehaviorSubject._(
    StreamController<T> controller,
    Stream<T> stream,
    this._wrapper,
  ) : super(controller, stream);

  /// Constructs a [BehaviorSubject], optionally pass handlers for
  /// [onListen], [onCancel] and a flag to handle events [sync].
  ///
  /// See also [StreamController.broadcast]
  factory BehaviorSubject({
    void Function() onListen,
    void Function() onCancel,
    bool sync = false,
  }) {
    // ignore: close_sinks
    final controller = StreamController<T>.broadcast(
      onListen: onListen,
      onCancel: onCancel,
      sync: sync,
    );

    final wrapper = _Wrapper<T>();

    return BehaviorSubject<T>._(
        controller, Rx.defer<T>(_deferStream(wrapper, controller, sync), reusable: true), wrapper);
  }

  /// Constructs a [BehaviorSubject], optionally pass handlers for
  /// [onListen], [onCancel] and a flag to handle events [sync].
  ///
  /// [seedValue] becomes the current [value] and is emitted immediately.
  ///
  /// See also [StreamController.broadcast]
  factory BehaviorSubject.seeded(
    T seedValue, {
    void Function() onListen,
    void Function() onCancel,
    bool sync = false,
  }) {
    // ignore: close_sinks
    final controller = StreamController<T>.broadcast(
      onListen: onListen,
      onCancel: onCancel,
      sync: sync,
    );

    final wrapper = _Wrapper<T>.seeded(seedValue);

    return BehaviorSubject<T>._(
      controller,
      Rx.defer<T>(_deferStream(wrapper, controller, sync), reusable: true),
      wrapper,
    );
  }

  static Stream<T> Function() _deferStream<T>(_Wrapper<T> wrapper, StreamController<T> controller, bool sync) => () {
        if (wrapper.latestIsError) {
          return controller.stream
              .transform(StartWithErrorStreamTransformer(wrapper.latestError, wrapper.latestStackTrace, sync));
        } else if (wrapper.latestIsValue) {
          return controller.stream.transform(StartWithStreamTransformer(wrapper.latestValue, sync: sync));
        }

        return controller.stream;
      };

  @override
  void onAdd(T event) => _wrapper.setValue(event);

  @override
  void onAddError(Object error, [StackTrace stackTrace]) => _wrapper.setError(error, stackTrace);

  @override
  ValueStream<T> get stream => this;

  @override
  bool get hasValue => _wrapper.latestIsValue;

  /// Get the latest value emitted by the Subject
  @override
  T get value => _wrapper.latestValue;

  bool get hasError => _wrapper.latestIsError;

  Object get error => _wrapper.latestError;

  StackTrace get errorStackTrace => _wrapper.latestStackTrace;

  /// Set and emit the new value
  set value(T newValue) => add(newValue);
}

class _Wrapper<T> {
  T latestValue;
  Object latestError;
  StackTrace latestStackTrace;

  bool latestIsValue = false, latestIsError = false;

  /// Non-seeded constructor
  _Wrapper();

  _Wrapper.seeded(this.latestValue) : latestIsValue = true;

  void setValue(T event) {
    latestIsValue = true;
    latestIsError = false;

    latestValue = event;

    latestError = null;
    latestStackTrace = null;
  }

  void setError(Object error, [StackTrace stackTrace]) {
    latestIsValue = false;
    latestIsError = true;

    latestValue = null;

    latestError = error;
    latestStackTrace = stackTrace;
  }
}
