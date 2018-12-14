import 'package:flutter/widgets.dart';
import 'package:reader/presentations/components/ScreenScaffold.dart';

class EmptyContentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      ScreenScaffold(
          body: const Center(child: Text("No content loaded"))
      );

}
