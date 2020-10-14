import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:screen/screen.dart';
import 'package:timnew_reader/arch/Request.dart';
import 'package:timnew_reader/features/App/UserException.dart';
import 'package:timnew_reader/arch/RenderMixin.dart';
import 'package:timnew_reader/models/ChapterContent.dart';

import 'ChapterContentRequest.dart';
import 'ChapterContentView.dart';
import 'OverscrollDetector.dart';
import 'ReadingControlPanel.dart';
import 'ReadingScaffold.dart';

class ChapterContentScreen extends StatefulWidget {
  final ChapterContentRequest request;

  ChapterContentScreen(this.request) : assert(request != null);

  static const String routeName = "ReadingScreen";

  static MaterialPageRoute buildRoute(ChapterContentRequest request) => MaterialPageRoute(
        settings: RouteSettings(name: routeName, arguments: request),
        builder: (_) => ChapterContentScreen(request),
      );

  @override
  State<StatefulWidget> createState() => _ChapterContentScreenState();
}

class _ChapterContentScreenState extends State<ChapterContentScreen> with RenderAsyncSnapshot<ChapterContent> {
  ChapterContentRequest get request => widget.request;

  @override
  void initState() {
    super.initState();
    _enableReadingMode();
  }

  void _enableReadingMode() {
    Screen.keepOn(true);
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  @override
  void dispose() {
    _disableReadingMode();
    super.dispose();
  }

  void _disableReadingMode() {
    Screen.keepOn(false);
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  }

  @override
  Widget build(BuildContext context) {
    return ReadingScaffold(
      builder: _buildGestureDetector,
      content: buildStream(request.valueStream),
    );
  }

  Widget _buildGestureDetector(BuildContext context, Widget child) => GestureDetector(
        onDoubleTap: () => ReadingControlPanel.show(context: context, request: request),
        child: child,
      );

  Widget buildWaiting(BuildContext context) {
    var theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "加載中...",
              style: theme.textTheme.bodyText2,
            ),
          ),
          RefreshButton(request: request),
        ],
      ),
    );
  }

  Widget buildError(BuildContext context, Object error) {
    final errorMessage = error is UserException ? error.message : error.toString();
    var theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Icons.sentiment_very_dissatisfied,
              color: theme.errorColor,
              size: theme.textTheme.headline3.fontSize,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0, bottom: 24.0),
              child: Text(
                errorMessage,
                style: theme.textTheme.bodyText2,
              ),
            ),
            RefreshButton(request: request),
          ],
        ),
      ),
    );
  }

  @override
  Widget buildData(BuildContext context, ChapterContent content) {
    return OverscrollDetector(
      allowUpwardOverscroll: request.hasPreviousChapter,
      allowDownwardOverscroll: request.hasNextChapter,
      onUpwardNavigate: loadPreviousChapter,
      onDownwardNavigate: loadNextChapter,
      child: ReadingContent(chapter: content),
    );
  }

  void loadPreviousChapter() {
    request.loadPreviousChapter();
  }

  void loadNextChapter() {
    request.loadNextChapter();
  }
}

class RefreshButton extends StatelessWidget {
  final Request request;

  const RefreshButton({Key key, @required this.request})
      : assert(request != null),
        super(key: key);

  @override
  Widget build(BuildContext context) => OutlineButton(
        onPressed: () => request.reload(),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.refresh),
            Text("重新加載"),
          ],
        ),
      );
}
