import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:reader/presentations/components/ScreenScaffold.dart';
import 'package:reader/presentations/wrappers/ContentTypeLoader.dart';

class EmptyContentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      ScreenScaffold(
          title: "Loading Url",
          body: Align(
            child: TextField(
              keyboardType: TextInputType.url,
              onSubmitted: (String url) {
                _openUrl(context, url);
              },
            ),
          )
      );

  void _openUrl(BuildContext context, String url) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) =>
            ContentTypeLoader.loadFromUriString(url)));
  }
}
