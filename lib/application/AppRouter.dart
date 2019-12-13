import 'package:flutter/material.dart';

class AppRouter {
  final String initialRoute = "/splash";

  final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
    "/splash": (context) => null,
    "/": (context) => null
  };

  Route onUnknownRoute(RouteSettings settings) => null;
}
