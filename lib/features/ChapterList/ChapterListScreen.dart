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
      titleWidget: Row(
        children: [
          Text(request.bookName),
          IconButton(icon: Icon(Icons.info_outline), onPressed: _openBookInfo),
        ],
      ),
      appBarActions: <Widget>[
        IconButton(icon: Icon(Icons.refresh), onPressed: _reload),
        IconButton(icon: Icon(Icons.bookmark_border), onPressed: _scrollToCurrent),
      ],
      body: Provider.value(
        value: scrollController,
        child: buildStream(request.valueStream),
      ));

  @override
  Widget buildData(BuildContext context, BuiltList<ChapterRef> chapters) {
    return _ChapterListView(request, chapters, scrollController, positionListener);
  }

  void _openBookInfo() {
    AppRouter.of(context).gotoBookInfo(request.bookIndex);
  }

  void _reload() {
    request.reload();
  }

  void _scrollToCurrent() {
    scrollController.scrollToCurrentChapter(context, request);
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
      leading: Icon(Icons.bookmark_border),
      title: Text(chapter.title),
      onTap: () async {
        await AppRouter.of(context).gotoChapterContent(request.bookIndex, chapter);
        context.read<ItemScrollController>().scrollToCurrentChapter(context, request);
      },
    );
  }
}

extension ScrollToChapterExtension on ItemScrollController {
  void _scrollControl(BuildContext context, ChapterListRequest request, Function(int) callback) {
    final currentChapterIndex = request.findCurrentChapterIndex();

    if (currentChapterIndex == null || !isAttached) return;

    try {
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
