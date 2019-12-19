import 'package:built_collection/built_collection.dart';
import 'package:flutter/widgets.dart';
import 'package:timnew_reader/models/CurrentBook.dart';
import 'package:timnew_reader/models/book_models.dart';

class CurrentBookStore extends InheritedModel<CurrentBookAspect> {
  final CurrentBook currentBook;

  BookIndex get bookIndex => currentBook.bookIndex;

  BookInfo get bookInfo => currentBook.bookInfo;

  BuiltList<ChapterRef> get chapterList => currentBook.chapterList;

  ChapterRef get chapter => currentBook.chapter;

  ChapterContent get chapterContent => currentBook.chapterContent;

  CurrentBookStore(
      {Key key, @required this.currentBook, @required Widget child})
      :super(key: key, child: child);

  @override
  bool updateShouldNotify(CurrentBookStore oldWidget) =>
      oldWidget.currentBook != currentBook;

  @override
  bool updateShouldNotifyDependent(CurrentBookStore oldWidget,
      Set<CurrentBookAspect> dependencies) =>
      dependencies.any((aspect) =>
      currentBook.selectBy(aspect) !=
          oldWidget.currentBook.selectBy(aspect));

  static CurrentBookStore of(BuildContext context,
      CurrentBookAspect aspect) =>
      InheritedModel.inheritFrom<CurrentBookStore>(context, aspect: aspect);
}
