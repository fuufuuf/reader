import 'package:flutter/widgets.dart';
import 'package:timnew_reader/models/CurrentBook.dart';

class CurrentBookStore extends InheritedModel<CurrentBookAspect> {
  final CurrentBook currentBook;

  CurrentBookStore(this.currentBook);

  @override
  bool updateShouldNotify(CurrentBookStore oldWidget) =>
      oldWidget.currentBook != currentBook;

  @override
  bool updateShouldNotifyDependent(
          CurrentBookStore oldWidget, Set<CurrentBookAspect> dependencies) =>
      dependencies.any((aspect) =>
          currentBook.selectBy(aspect) !=
          oldWidget.currentBook.selectBy(aspect));
}
