import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timnew_reader/arch/RenderMixin.dart';

abstract class Initializer<T> extends StatelessWidget with RenderAsyncSnapshot<T> {
  final WidgetBuilder childBuilder;

  Initializer({Key key, @required this.childBuilder})
      : assert(childBuilder != null),
        super(key: key);

  Future<T> initialize();

  @override
  Widget build(BuildContext context) => buildFuture(initialize());

  @override
  Widget buildData(BuildContext context, T data) => Provider.value(
        value: data,
        child: Builder(
          builder: childBuilder,
        ),
      );
}

class GroupInitializer extends StatelessWidget with RenderAsyncSnapshot<List<Provider>> {
  final WidgetBuilder childBuilder;
  final BuiltList<GroupAspect> aspects;

  GroupInitializer({Key key, @required Iterable<GroupAspect> aspects, @required this.childBuilder})
      : assert(aspects != null),
        assert(childBuilder != null),
        this.aspects = aspects.toBuiltList(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final futureProviders = Future.wait(aspects.map((it) => it.execute()), eagerError: true);
    return buildFuture(futureProviders);
  }

  @override
  Widget buildData(BuildContext context, List<Provider> providers) {
    return MultiProvider(
      providers: providers,
      child: Builder(builder: childBuilder),
    );
  }
}

abstract class GroupAspect<T> {
  Future<Provider<T>> execute();
}

abstract class AspectInitializer<T> implements GroupAspect<T> {
  Future<T> initialize();

  Future<Provider<T>> execute() async => Provider.value(value: await initialize());
}

typedef FutureOr<T> InitializeFunction<T>();

class FunctionAspectInitializer<T> implements GroupAspect<T> {
  final InitializeFunction<T> function;

  FunctionAspectInitializer(this.function);

  Future<Provider<T>> execute() async => Provider.value(value: await function());
}
