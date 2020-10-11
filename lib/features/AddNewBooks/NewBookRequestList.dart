import 'package:built_collection/built_collection.dart';
import 'package:timnew_reader/features/BookList/BookList.dart';
import 'package:timnew_reader/features/App/UserException.dart';
import 'package:timnew_reader/arch/Store.dart';
import 'package:timnew_reader/models/NewBook.dart';

import 'NewBookRequest.dart';

class NewBookRequestList extends ValueStore<BuiltList<NewBookRequest>> {
  final BookList bookList;

  NewBookRequestList(this.bookList) : super(BuiltList());

  BuiltList<NewBookRequest> tryAdd(String text) {
    final newUrls =
        text.split("\n").map((e) => e.trim()).where((element) => element.isNotEmpty).toSet(); // Ensure url is unique

    newUrls.removeAll(value.map((e) => e.url)); // Ensure not already added urls

    if (newUrls.isEmpty) return value;

    final newRequests = newUrls.map((e) => NewBookRequest(bookList, e)).toBuiltList();

    return putValue(value + newRequests);
  }

  BuiltList<NewBookRequest> clear() {
    return putValue(value.rebuild((b) => b.clear()));
  }

  BuiltList<NewBook> collectResult() {
    final requests = value;

    final hasRunningRequest = requests.any((r) => !r.hasCurrent);

    if (hasRunningRequest) return null;

    final allNewBooks = requests.where((r) => r.hasData).map((r) => r.currentData).toBuiltList();

    final bookIds = allNewBooks.map((b) => b.bookId).toSet();

    if (bookIds.length < allNewBooks.length) {
      throw UserException("有重複的新書籍");
    }

    return allNewBooks;
  }
}
