import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:timnew_reader/features/App/common.dart';
import 'package:timnew_reader/widgets/IndexedTrackingScrollController.dart';
import 'package:timnew_reader/features/ChapterContent/ScrollTarget.dart';
import 'package:timnew_reader/models/ChapterContent.dart';
import 'ChapterContentWithScroll.dart';
import 'ReadingTheme.dart';

class ChapterContentView extends StatelessWidget {
  final ChapterContentWithScroll content;
  final IndexedTrackingScrollController scrollController;

  ChapterContentView({Key key, @required this.content, @required this.scrollController})
      : assert(content != null),
        assert(scrollController != null),
        super(key: key);

  ChapterContent get chapter => content.chapter;

  ScrollTarget get scrollTarget => content.scrollTarget;

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((_) => _updateScroll());
    return ReadingTheme(
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        controller: scrollController,
        slivers: [
          SliverList(
            key: scrollController.sliverListKey,
            delegate: SliverChildBuilderDelegate(
              _buildChild,
              childCount: chapter.paragraphs.length + 1,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildChild(BuildContext context, int index) {
    if (index == 0) return _ChapterTitle(chapter.title);

    return _Paragraph(chapter.paragraphs[index - 1]);
  }

  _updateScroll() {
    scrollTarget.when(
      top: () => scrollController.moveToTop(),
      bottom: () => scrollController.moveToBottom(),
      paragraph: (index) => scrollController.jumpToIndex(index.ensureWithInRange(0, chapter.paragraphs.length)),
    );
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
