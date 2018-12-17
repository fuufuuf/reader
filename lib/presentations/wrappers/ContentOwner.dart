import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:reader/presentations/wrappers/ContentLoader.dart';

class ContentController<T> {
  final T initialData;
  final bool respondToReloading;
  final StreamController<Future<T>> _controller;

  ContentController({
    this.initialData,
    this.respondToReloading = false,
    Future<T> initialFuture,
  }) : _controller = StreamController() {
    if (initialFuture != null) {
      _controller.add(initialFuture);
    }
  }

  void setValue(T value) {
    _controller.add(Future.value(value));
  }

  void setFuture(Future<T> future) {
    _controller.add(future);
  }

  Stream<Future<T>> get stream => _controller.stream;

  static ContentController<T> of<T>(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(
          _typeOf<ControllerProvider<T>>()
      ) as ControllerProvider<T>)
          .controller;
}

Type _typeOf<T>() => T;

class ControllerProvider<T> extends InheritedWidget {
  final ContentController<T> controller;

  ControllerProvider(
      {@required this.controller, Key key, @required Widget child})
      :super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) =>
      !identical(this, oldWidget) &&
          runtimeType == oldWidget.runtimeType &&
          controller != (oldWidget as ControllerProvider<T>).controller;
}

class ContentOwner<T> extends StatefulWidget {
  final ContentRender<T> render;
  final ContentController<T> controller;

  const ContentOwner(
      {Key key, @required this.render, @required this.controller})
      : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      ContentState(render: render, controller: controller);
}

class ContentState<T> extends State<ContentOwner<T>> {
  final ContentRender<T> render;
  final ContentController<T> controller;
  StreamSubscription<Future<T>> _subscription;
  Future<T> future;

  ContentState({
    @required this.render,
    @required this.controller});

  @override
  void initState() {
    super.initState();

    _subscription = controller.stream.listen((Future<T> newFuture) {
      setState(() {
        future = newFuture;
      });
    });
  }

  @override
  void dispose() {
    if (_subscription != null) {
      _subscription.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      ControllerProvider<T>(
          controller: controller,
          child: ContentLoader<T>(
              initialData: controller.initialData,
              respondToReloading: controller.respondToReloading,
              future: future,
              render: render
          )
      )
  ;
}

