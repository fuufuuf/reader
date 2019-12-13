import 'package:flutter/material.dart';
import 'package:flutter_event_bus/flutter_event_bus/EventBus.dart';
import 'package:flutter_event_bus/flutter_event_bus/Subscription.dart';
import 'package:timnew_reader/application/AppRouter.dart';
import 'package:timnew_reader/fluttter_event_bus/EmptySubscription.dart';
import 'package:timnew_reader/fluttter_event_bus/RootInteractor.dart';

class ReaderApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AppInteractor();
}

class AppInteractor extends RootInteractor<ReaderApp> {
  AppRouter _appRouter = AppRouter();

  @override
  Subscription subscribeEvents(EventBus eventBus) => EmptySubscription();

  @override
  Widget buildStores(BuildContext context, {Widget child}) => null;

  @override
  Widget buildChild(BuildContext context) => MaterialApp(
        initialRoute: _appRouter.initialRoute,
        routes: _appRouter.routes,
        onUnknownRoute: _appRouter.onUnknownRoute,
      );
}
