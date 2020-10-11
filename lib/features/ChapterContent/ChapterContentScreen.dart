import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:screen/screen.dart';
import 'package:timnew_reader/features/App/UserException.dart';
import 'package:timnew_reader/arch/RenderMixin.dart';
import 'package:timnew_reader/models/ChapterContent.dart';

import 'ChapterContentRequest.dart';
import 'ChapterContentView.dart';
import 'OverScrollNavigateContainer.dart';
import 'ReadingPopUpMenu.dart';
import 'ReadingScaffold.dart';

class ChapterContentScreen extends StatefulWidget {
  final ChapterContentRequest request;

  ChapterContentScreen(this.request) : assert(request != null);

  static MaterialPageRoute buildRoute(ChapterContentRequest request) => MaterialPageRoute(
        settings: RouteSettings(name: "ReadingScreen", arguments: request),
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
      onDoubleTap: _onDoubleTap,
      content: buildStream(request.valueStream),
    );
  }

  Widget _buildContainer({Widget child}) {
    return OverScrollNavigateContainer(
      key: Key("NavigateContainer"),
      allowUpwardOverScroll: request.hasPreviousChapter,
      allowDownwardOverScroll: request.hasNextChapter,
      onUpwardNavigate: _navigateUp,
      onDownwardNavigate: _navigateDown,
      child: child,
    );
  }

  Widget buildWaiting(BuildContext context) => Center(
        child: Text("加載中..."),
      );

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
            OutlineButton(
                onPressed: () => request.reload(),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.refresh),
                    Text("重新加載"),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  @override
  Widget buildData(BuildContext context, ChapterContent content) {
    return _buildContainer(
      child: ReadingContent(chapter: content),
    );
  }

  void _onDoubleTap(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) => ReadingPopUpMenu(
        request: request,
        navigateUp: _navigateUp,
        navigateDown: _navigateDown,
      ),
    );
  }

  void _navigateUp() {
    request.loadPreviousChapter();
  }

  void _navigateDown() {
    request.loadNextChapter();
  }
}
