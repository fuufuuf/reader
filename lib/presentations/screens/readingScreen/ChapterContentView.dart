import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:reader/events/EventBus.dart';
import 'package:reader/events/OpenUrlEvent.dart';
import 'package:reader/models/ChapterContent.dart';

class ChapterContentView extends StatelessWidget {
  final ChapterContent chapter;

  const ChapterContentView({Key key, this.chapter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemBuilder: _renderParagraph,
        itemCount: chapter.paragraphs.length + 2);
  }

  Widget _renderParagraph(BuildContext context, int index) {
    if (index == 0) {
      return _ChapterTitle(chapter.title);
    } else if (index == chapter.paragraphs.length + 1) {
      return _NavigationView(chapter);
    } else {
      return _Paragraph(chapter.paragraphs[index - 1]);
    }
  }
}

class _ChapterTitle extends StatelessWidget {
  final String content;

  _ChapterTitle(this.content);

  @override
  Widget build(BuildContext context) => Padding(
      padding: EdgeInsets.all(16),
      child: Text(content, textScaleFactor: 2.0, textAlign: TextAlign.center));
}

class _Paragraph extends StatelessWidget {
  final String content;

  _Paragraph(this.content);

  @override
  Widget build(BuildContext context) =>
      Padding(padding: EdgeInsets.all(8), child: Text(content));
}

class _NavigationView extends StatelessWidget {
  final ChapterContent chapter;

  _NavigationView(this.chapter);

  @override
  Widget build(BuildContext context) {
    var textColor = DefaultTextStyle
        .of(context)
        .style
        .color;

    return Padding(
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
  }

  void _gotoPrevious() {
    EventBus.post(OpenUrlEvent(chapter.previousChapterUrl));
  }

  void _gotoNext() {
    EventBus.post(OpenUrlEvent(chapter.nextChapterUrl));
  }
}
