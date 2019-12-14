import 'package:flutter/material.dart';
import 'package:flutter_event_bus/flutter_event_bus.dart';
import 'package:timnew_reader/features/booklist/BookListScreen.dart';

class ReaderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      EventBusWidget(
          child: MaterialApp(
            title: '米良追书',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            initialRoute: "/",
            routes: buildRoutes(),
          )
      );

  Map<String, WidgetBuilder> buildRoutes() =>
      <String, WidgetBuilder>{
        "/": (_) => BookListScreen(),
      };
}
