import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:screen/screen.dart';
import 'package:timnew_reader/arch/Request.dart';
import 'package:timnew_reader/features/App/common.dart';
import 'package:timnew_reader/arch/RenderMixin.dart';
import 'package:timnew_reader/widgets/IndexedTrackingScrollController.dart';
import 'package:timnew_reader/features/ChapterContent/ChapterContentWithScroll.dart';
import 'package:timnew_reader/features/ChapterContent/ReadingTheme.dart';
import 'package:timnew_reader/features/Theme/AppTheme.dart';
import 'package:timnew_reader/repositories/PersistentStorage.dart';

import 'ChapterContentRequest.dart';
import 'ChapterContentView.dart';
import 'OverscrollDetector.dart';
import 'ReadingControlPanel.dart';
import 'ReadingGestureDetector.dart';
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

class _ChapterContentScreenState extends State<ChapterContentScreen>
    with RenderAsyncSnapshot<ChapterContentWithScroll> {
  ChapterContentRequest get request => widget.request;

  IndexedTrackingScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = IndexedTrackingScrollController();

    _enableReadingMode();
    _scrollController.addListener(_saveCurrentParagraph);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_saveCurrentParagraph);
    _disableReadingMode();
    super.dispose();
  }

  void _enableReadingMode() {
    Screen.keepOn(true);
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  void _disableReadingMode() {
    Screen.keepOn(false);
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  }

  void _saveCurrentParagraph() async {
    if (!request.hasData) return;

    final itemIndex = _scrollController.findFirstVisibleIndex();

    if (itemIndex == null) {
      // Rendering is not finished, wait for end of the frame
      WidgetsBinding.instance.scheduleFrameCallback((_) => _saveCurrentParagraph());

      return;
    }

    await request.bookIndex.saveCurrentParagraph(itemIndex);
  }

  @override
  Widget build(BuildContext context) {
    return ReadingScaffold(
      builder: _buildGestureDetector,
      content: buildStream(request.valueStream),
    );
  }

  Widget _buildGestureDetector(BuildContext context, Widget child) => ReadingGestureDetector(
        onPageUp: pageUp,
        onPageDown: pageDown,
        onControlPanel: () => ReadingControlPanel.show(context: context, request: request),
        child: child,
      );

  Widget buildWaiting(BuildContext context) {
    var theme = Theme.of(context);

    return ReadingTheme(
      child: Center(
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
      ),
    );
  }

  Widget buildError(BuildContext context, Object error) {
    final errorMessage = error is UserException ? error.message : error.toString();
    var theme = Theme.of(context);
    return ReadingTheme(
      child: Center(
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
      ),
    );
  }

  @override
  Widget buildData(BuildContext context, ChapterContentWithScroll content) => OverscrollDetector(
        allowUpwardOverscroll: request.hasPreviousChapter,
        allowDownwardOverscroll: request.hasNextChapter,
        onUpwardNavigate: loadPreviousChapter,
        onDownwardNavigate: loadNextChapter,
        scrollController: _scrollController,
        child: ChapterContentView(
          scrollController: _scrollController,
          content: content,
        ),
      );

  void loadPreviousChapter() {
    if (request.hasPreviousChapter) {
      request.loadPreviousChapter();
    }
  }

  void loadNextChapter() {
    if (request.hasNextChapter) {
      request.loadNextChapter();
    }
  }

  void pageUp() async {
    if (_scrollController.isAtTop) {
      loadPreviousChapter();
    } else {
      final appTheme = context.read<AppTheme>();

      _scrollController.moveToPreviousScreen(duration: appTheme.pagingDuration);
    }
  }

  void pageDown() async {
    if (_scrollController.isAtBottom) {
      loadNextChapter();
    } else {
      final appTheme = context.read<AppTheme>();

      _scrollController.moveToNextScreen(duration: appTheme.pagingDuration);
    }
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
