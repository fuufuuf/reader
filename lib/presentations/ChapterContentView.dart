import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:reader/events/EventBus.dart';
import 'package:reader/events/OpenUrlEvent.dart';
import 'package:reader/models/Chapter.dart';
import 'package:reader/presentations/ReadingThemeProvider.dart';

class ChapterContentView extends StatelessWidget {
  final Chapter chapter;

  const ChapterContentView({Key key, this.chapter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textColor =
        ReadingThemeProvider.fetch(context).theme.chapterViewTextColor;
    final style = DefaultTextStyle.of(context).style.apply(color: textColor);

    return ListView.builder(
        itemBuilder: (BuildContext context, int index) =>
            _renderParagraph(context, index, textColor, style),
        itemCount: chapter.paragraphs.length + 2);
  }

  Widget _renderParagraph(
      BuildContext context, int index, Color textColor, TextStyle style) {
    if (index == 0) {
      return _ChapterTitle(chapter.title, style);
    } else if (index == chapter.paragraphs.length + 1) {
      return _NavigationView(chapter, textColor);
    } else {
      return _Paragraph(chapter.paragraphs[index - 1], style);
    }
  }
}

class _ChapterTitle extends StatelessWidget {
  final String content;
  final TextStyle style;

  _ChapterTitle(this.content, this.style);

  @override
  Widget build(BuildContext context) => Padding(
      padding: EdgeInsets.all(16),
      child: Text(content,
          textScaleFactor: 2.0, textAlign: TextAlign.center, style: style));
}

class _Paragraph extends StatelessWidget {
  final String content;
  final TextStyle style;

  _Paragraph(this.content, this.style);

  @override
  Widget build(BuildContext context) =>
      Padding(padding: EdgeInsets.all(8), child: Text(content, style: style));
}

class _NavigationView extends StatelessWidget {
  final Chapter chapter;
  final Color textColor;

  _NavigationView(this.chapter, this.textColor);

  @override
  Widget build(BuildContext context) => Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 18),
      child: Row(children: <Widget>[
        Expanded(
            child: IconButton(
          icon: Icon(
            Icons.navigate_before,
            color: textColor,
          ),
          onPressed: chapter.hasPrevious ? _gotoPrevious : null,
        )),
        Expanded(
          child: IconButton(
            icon: Icon(
              Icons.navigate_next,
              color: textColor,
            ),
            onPressed: chapter.hasNext ? _gotoNext : null,
          ),
        )
      ]));

  void _gotoPrevious() {
    EventBus.post(OpenUrlEvent(chapter.previousChapterUrl));
  }

  void _gotoNext() {
    EventBus.post(OpenUrlEvent(chapter.nextChapterUrl));
  }
}
