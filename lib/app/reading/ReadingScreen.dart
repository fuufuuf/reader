import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:screen/screen.dart';
import 'package:timnew_reader/app/UserException.dart';
import 'package:timnew_reader/app/reading/ChapterContentRequest.dart';
import 'package:timnew_reader/arch/RenderMixin.dart';
import 'package:timnew_reader/models/ChapterContent.dart';
import 'package:timnew_reader/app/reading/ChapterContentView.dart';
import 'package:timnew_reader/app/reading/OverScrollNavigateContainer.dart';
import 'package:timnew_reader/app/reading/ReadingPopUpMenu.dart';
import 'package:timnew_reader/app/reading/ReadingScaffold.dart';

class ReadingScreen extends StatefulWidget {
  final ChapterContentRequest request;

  ReadingScreen(this.request) : assert(request != null);

  static MaterialPageRoute buildRoute(ChapterContentRequest request) => MaterialPageRoute(
        settings: RouteSettings(name: "ReadingScreen", arguments: request),
        builder: (_) => ReadingScreen(request),
      );

  @override
  State<StatefulWidget> createState() => _ReadingScreenState(request);
}

class _ReadingScreenState extends State<ReadingScreen> with RenderAsyncSnapshot<ChapterContent> {
  ChapterContentRequest _request;

  _ReadingScreenState(this._request);

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
      content: buildStream(_request.valueStream),
    );
  }

  Widget _buildContainer({bool isWaiting, ChapterContent content, Widget child}) {
    return OverScrollNavigateContainer(
      key: Key("NavigateContainer"),
      isLoading: isWaiting,
      allowUpwardOverScroll: content?.hasPrevious ?? false,
      allowDownwardOverScroll: content?.hasNext ?? false,
      onUpwardNavigate: _navigateUp,
      onDownwardNavigate: _navigateDown,
      child: child,
    );
  }

  Widget buildWaiting(BuildContext context) => _buildContainer(
        isWaiting: true,
        child: Center(
          child: Text("加載中..."),
        ),
      );

  Widget buildError(BuildContext context, Object error) {
    final errorMessage = error is UserException ? error.message : error.toString();

    return _buildContainer(
      isWaiting: false,
      child: Center(
        child: Column(
          children: <Widget>[
            Icon(Icons.cancel_outlined),
            Text("加載錯誤"),
            Text(errorMessage),
            TextButton(
                onPressed: () => _request.reload(),
                child: Row(
                  children: [
                    Icon(Icons.refresh),
                    Text("重新加載"),
                  ],
                ))
          ],
        ),
      ),
    );
  }

  @override
  Widget buildData(BuildContext context, ChapterContent content) {
    return _buildContainer(
      isWaiting: false,
      content: content,
      child: ChapterContentView(chapter: content),
    );
  }

  void _onDoubleTap(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) => ReadingPopUpMenu(
        request: _request,
        navigateUp: _navigateUp,
        navigateDown: _navigateDown,
      ),
    );
  }

  void _navigateUp() {}

  void _navigateDown() {}
}
