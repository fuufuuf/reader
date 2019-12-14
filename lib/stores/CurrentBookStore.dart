import 'package:built_collection/built_collection.dart';
import 'package:flutter/widgets.dart';
import 'package:timnew_reader/models/CurrentBook.dart';
import 'package:timnew_reader/models/book_models.dart';

class CurrentBookStore extends InheritedModel<CurrentBookAspect> {
  final CurrentBook state;

  BookIndex get bookIndex => state.bookIndex;

  BookInfo get bookInfo => state.bookInfo;

  BuiltList<ChapterRef> get chapterList => state.chapterList;

  ChapterRef get chapter => state.chapter;

  ChapterContent get chapterContent => state.chapterContent;

  CurrentBookStore(this.state, Widget child)
      :super(key: ObjectKey(CurrentBookStore), child: child);

  @override
  bool updateShouldNotify(CurrentBookStore oldWidget) =>
      oldWidget.state != state;

  @override
  bool updateShouldNotifyDependent(CurrentBookStore oldWidget,
      Set<CurrentBookAspect> dependencies) =>
      dependencies.any((aspect) =>
      state.selectBy(aspect) !=
          oldWidget.state.selectBy(aspect));

  static CurrentBookStore of(BuildContext context, CurrentBookAspect aspect) =>
      InheritedModel.inheritFrom<CurrentBookStore>(context, aspect: aspect);
}
