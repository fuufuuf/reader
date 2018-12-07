import 'package:flutter/widgets.dart';
import 'package:reader/ng/presentations/ContentTypeLoader.dart';

class MainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) => ContentTypeLoader.loadFromUriString(
      "https://www.piaotian.com/html/9/9054/5941036.html");
}
