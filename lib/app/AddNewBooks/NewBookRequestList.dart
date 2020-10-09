import 'package:built_collection/built_collection.dart';
import 'package:timnew_reader/app/BookList/BookList.dart';
import 'package:timnew_reader/arch/Store.dart';
import 'package:timnew_reader/models/NewBook.dart';

import 'NewBookRequest.dart';

class NewBookRequestList extends ValueStore<BuiltList<NewBookRequest>> {
  final BookList bookList;

  NewBookRequestList(this.bookList) : super(BuiltList());

  BuiltList<NewBookRequest> tryAdd(String text) {
    final requests = text
        .split("\n")
        .map((e) => e.trim())
        .where((element) => element.isNotEmpty)
        .map((e) => NewBookRequest(bookList, e));

    if (requests.isEmpty) return value;

    final existedUrls = value.map((e) => e.url).toSet();
    final deduped = requests.where((r) => !existedUrls.contains(r.url)).toBuiltList();
    return putValue(value + deduped);
  }

  BuiltList<NewBookRequest> clear() {
    return putValue(value.rebuild((b) => b.clear()));
  }

  BuiltList<NewBook> collectResult() {
    final requests = value;

    final hasRunningRequest = requests.any((r) => !r.hasCurrent);

    if (hasRunningRequest) return null;

    final allNewBooks = requests.where((r) => r.hasData).map((r) => r.currentData).toBuiltList();

    return allNewBooks;
  }
}
