import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:timnew_reader/models/ChapterContent.dart';

class ReadingContent extends StatelessWidget {
  final ChapterContent chapter;

  const ReadingContent({Key key, this.chapter}) : super(key: key);

  @override
  Widget build(BuildContext context) => ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemBuilder: _renderParagraph,
        itemCount: chapter.paragraphs.length + 1,
      );

  Widget _renderParagraph(BuildContext context, int index) {
    if (index == 0) {
      return _ChapterTitle(chapter.title);
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
      padding: EdgeInsets.all(8),
      child: Text(content,
          style: TextStyle(fontWeight: FontWeight.w500), textScaleFactor: 1.4, textAlign: TextAlign.center));
}

class _Paragraph extends StatelessWidget {
  final String content;

  _Paragraph(this.content);

  @override
  Widget build(BuildContext context) => Padding(padding: EdgeInsets.all(8), child: Text(content));
}
