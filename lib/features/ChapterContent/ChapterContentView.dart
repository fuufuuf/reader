import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:timnew_reader/features/App/common.dart';
import 'package:timnew_reader/features/ChapterContent/ScrollTarget.dart';
import 'package:timnew_reader/models/ChapterContent.dart';
import 'ChapterContentWithScroll.dart';
import 'ReadingTheme.dart';

class ReadingContent extends StatelessWidget {
  final ChapterContentWithScroll content;
  final ItemScrollController scrollController;
  final ItemPositionsListener scrollListener;

  const ReadingContent({
    Key key,
    @required this.content,
    this.scrollController,
    this.scrollListener,
  })  : assert(content != null),
        super(key: key);

  ChapterContent get chapter => content.chapter;

  ScrollTarget get scrollTarget => content.scrollTarget;

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((_) => _updateScroll());
    return ReadingTheme(
      child: ScrollablePositionedList.builder(
        physics: const BouncingScrollPhysics(),
        itemScrollController: scrollController,
        itemPositionsListener: scrollListener,
        itemBuilder: _renderParagraph,
        itemCount: chapter.paragraphs.length + 1,
      ),
    );
  }

  Widget _renderParagraph(BuildContext context, int index) {
    if (index == 0) {
      return _ChapterTitle(chapter.title);
    } else {
      return _Paragraph(chapter.paragraphs[index - 1]);
    }
  }

  _updateScroll() {
    final index = scrollTarget.map(
      top: (_) => 0,
      bottom: (_) => chapter.paragraphs.length - 1,
      paragraph: (s) => s.index.regulateAmong(0, chapter.paragraphs.length - 1),
    );

    scrollController.jumpTo(index: index);
  }
}

class _ChapterTitle extends StatelessWidget {
  final String content;

  _ChapterTitle(this.content);

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.all(8),
        child: Text(
          content,
          style: Theme.of(context).textTheme.headline5,
          textAlign: TextAlign.center,
        ),
      );
}

class _Paragraph extends StatelessWidget {
  final String content;

  _Paragraph(this.content);

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.all(8),
        child: Text(
          content,
          style: Theme.of(context).textTheme.bodyText1,
        ),
      );
}
