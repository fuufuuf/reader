import 'package:flutter/material.dart';
import 'package:reader/models/models.dart';

class ReaderScreen extends StatefulWidget {
  final Book book;
  final int chapterIndex;

  ReaderScreen(this.book, this.chapterIndex);

  @override
  State<StatefulWidget> createState() => _ReaderScreenState(chapterIndex);
}

class _ReaderScreenState extends State<ReaderScreen> {
  int chapterIndex;

  _ReaderScreenState(this.chapterIndex);

  Chapter get currentChapter => widget.book.chapters[chapterIndex];

  @override
  Widget build(BuildContext context) => Scaffold(
        body: _LongTextView(currentChapter),
      );
}

class _LongTextView extends StatelessWidget {
  final Chapter chapter;

  _LongTextView(this.chapter);

  Widget _renderParagraph(BuildContext context, int index) =>
      _Paragraph(chapter.content[index]);

  @override
  Widget build(BuildContext context) => ListView.builder(
      itemBuilder: _renderParagraph, itemCount: chapter.content.length);
}

class _Paragraph extends StatelessWidget {
  final String content;

  _Paragraph(this.content);

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.all(8),
        child: Text(
          content,
          textAlign: TextAlign.left,
        ),
      );
}
