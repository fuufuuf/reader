import 'package:flutter/cupertino.dart';
import 'package:flutter_event_bus/flutter_event_bus.dart';

/// Base class for the top level [Interactor] which should be used as the top widget
/// RootInteractor will provide [EventBus] and [Store] to children widgets
abstract class RootInteractor<T extends StatefulWidget> extends Interactor<T> {
  final EventBus _eventBus;

  @override
  EventBus get eventBus => _eventBus;

  /// Create an instance of the RootInteractor
  /// If [eventBus] if not given, a default one will be created
  RootInteractor({EventBus eventBus}) : _eventBus = eventBus ?? EventBus();

  @override
  Widget build(BuildContext context) => EventBusWidget.bindEventBus(eventBus,
      child: buildStores(context, child: buildChild(context)));

  /// Build Stores to provide states to child widgets
  @protected
  Widget buildStores(BuildContext context, {@required Widget child});

  /// Build the widget like normal [build] method does
  @protected
  Widget buildChild(BuildContext context);
}
