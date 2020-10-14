import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:timnew_reader/features/ChapterList/ChapterListRequest.dart';
import 'package:timnew_reader/features/App/UserException.dart';
import 'package:timnew_reader/features/Routing/AppRouter.dart';
import 'package:timnew_reader/arch/RenderMixin.dart';
import 'package:timnew_reader/models/BookIndex.dart';
import 'package:timnew_reader/models/ChapterRef.dart';
import 'package:timnew_reader/widgets/ScreenScaffold.dart';

class ChapterListScreen extends StatefulWidget {
  final ChapterListRequest request;

  ChapterListScreen(BookIndex bookIndex)
      : assert(bookIndex != null),
        request = ChapterListRequest(bookIndex);

  static const String routeName = "ChapterList";

  static MaterialPageRoute buildRoute(BookIndex bookIndex) => MaterialPageRoute(
        settings: RouteSettings(name: routeName, arguments: bookIndex),
        builder: (_) => ChapterListScreen(bookIndex),
      );

  @override
  _ChapterListScreenState createState() => _ChapterListScreenState();
}

class _ChapterListScreenState extends State<ChapterListScreen> with RenderAsyncSnapshot<BuiltList<ChapterRef>> {
  ChapterListRequest get request => widget.request;

  final ItemScrollController scrollController = ItemScrollController();
  final ItemPositionsListener positionListener = ItemPositionsListener.create();

  @override
  Widget build(BuildContext context) => ScreenScaffold(
      title: Text(request.bookName, overflow: TextOverflow.ellipsis),
      appBarActions: <Widget>[
        IconButton(
          icon: Icon(Icons.more_horiz),
          onPressed: _showBottomSheet,
        ),
      ],
      body: Provider.value(
        value: scrollController,
        child: buildStream(request.valueStream),
      ));

  @override
  Widget buildData(BuildContext context, BuiltList<ChapterRef> chapters) {
    return _ChapterListView(request, chapters, scrollController, positionListener);
  }

  void openBookInfo() {
    AppRouter.of(context).gotoBookInfo(request.bookIndex);
  }

  void reload() {
    request.reload();
  }

  void onShowCurrentChapter() {
    scrollController.scrollToCurrentChapter(context, request);
  }

  Future _showBottomSheet() => showModalBottomSheet(
        context: context,
        builder: (_) => ChapterListBottomSheet(
          onBookInfo: openBookInfo,
          onReload: reload,
          onShowCurrentChapter: onShowCurrentChapter,
        ),
      );
}

class ChapterListBottomSheet extends StatelessWidget {
  final VoidCallback onBookInfo;
  final VoidCallback onReload;
  final VoidCallback onShowCurrentChapter;

  const ChapterListBottomSheet({
    Key key,
    this.onBookInfo,
    this.onReload,
    this.onShowCurrentChapter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            InkWell(
              child: ListTile(
                leading: Icon(Icons.info),
                title: Text("書目信息"),
                onTap: () => dismiss(context, onBookInfo),
              ),
            ),
            InkWell(
              child: ListTile(
                leading: Icon(Icons.refresh),
                title: Text("刷新"),
                onTap: () => dismiss(context, onReload),
              ),
            ),
            InkWell(
              child: ListTile(
                leading: Icon(Icons.bookmark_border),
                title: Text("滾動到當前章節"),
                onTap: () => dismiss(context, onShowCurrentChapter),
              ),
            ),
          ],
        ),
      );

  void dismiss(BuildContext context, [VoidCallback onDismissed]) {
    Navigator.of(context).pop();

    if (onDismissed != null) {
      onDismissed();
    }
  }
}

class _ChapterListView extends StatelessWidget {
  final ChapterListRequest request;
  final BuiltList<ChapterRef> chapters;
  final ItemScrollController scrollController;
  final ItemPositionsListener scrollListener;

  _ChapterListView(this.request, this.chapters, this.scrollController, this.scrollListener);

  @override
  Widget build(BuildContext context) {
    scheduleJumpToCurrentPage(context);

    return ScrollablePositionedList.builder(
      itemBuilder: (context, index) => _ChapterEntry(request, index, chapters[index]),
      itemCount: chapters.length,
      itemScrollController: scrollController,
      itemPositionsListener: scrollListener,
    );
  }

  void scheduleJumpToCurrentPage(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      scrollController.jumpToCurrentChapter(context, request);
    });
  }
}

class _ChapterEntry extends StatelessWidget {
  final ChapterListRequest request;
  final ChapterRef chapter;
  final int index;

  _ChapterEntry(this.request, this.index, this.chapter);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: _buildIcon(context),
      title: Text(chapter.title),
      onTap: () async {
        await AppRouter.of(context).gotoChapterContent(request.bookIndex, chapter);
        context.read<ItemScrollController>().scrollToCurrentChapter(context, request);
      },
    );
  }

  Widget _buildIcon(BuildContext context) =>
      chapter.isLocked ? Icon(Icons.lock, color: Theme.of(context).errorColor) : Icon(Icons.bookmark_border);
}

extension ScrollToChapterExtension on ItemScrollController {
  void _scrollControl(BuildContext context, ChapterListRequest request, Function(int) callback) {
    try {
      final currentChapterIndex = request.findCurrentChapterIndex();

      if (currentChapterIndex == null || !isAttached) return;

      callback(currentChapterIndex);
    } on UserException catch (ex) {
      ex.showAsSnackBar(context);
    }
  }

  void jumpToCurrentChapter(BuildContext context, ChapterListRequest request) {
    _scrollControl(context, request, (index) => jumpTo(index: index));
  }

  void scrollToCurrentChapter(BuildContext context, ChapterListRequest request) {
    _scrollControl(
      context,
      request,
      (index) => scrollTo(
        index: index,
        duration: Duration(seconds: 1),
        curve: Curves.linear,
      ),
    );
  }
}
