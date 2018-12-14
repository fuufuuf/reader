import 'package:flutter/widgets.dart';
import 'package:reader/presentations/components/ScreenScaffold.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      ScreenScaffold(
          body: Center(
            child: Text("Loading..."),
          )
      );
}
