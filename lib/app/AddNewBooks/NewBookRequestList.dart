import 'package:built_collection/built_collection.dart';
import 'package:timnew_reader/app/AddNewBooks/BookList/BookList.dart';
import 'package:timnew_reader/arch/ValueSource.dart';

import 'NewBookRequest.dart';

class NewBookRequestList extends ValueSource<BuiltList<NewBookRequest>> {
  final BookList bookList;

  NewBookRequestList(this.bookList) : super(BuiltList());

  BuiltList<NewBookRequest> tryAdd(String text) {
    final requests = text
        .split("\n")
        .map((e) => e.trim())
        .where((element) => element.isNotEmpty)
        .map((e) => NewBookRequest(bookList, e));

    if (!hasValue) return putValueSync(requests.toBuiltList());

    if (requests.isEmpty) return currentValue;

    final existedUrls = currentValue.map((e) => e.url).toSet();
    final deduped = requests.where((r) => !existedUrls.contains(r.url)).toBuiltList();
    return putValueSync(currentValue + deduped);
  }

  BuiltList<NewBookRequest> clear() {
    return putValueSync(currentValue.rebuild((b) => b.clear()));
  }

  @override
  BuiltList<NewBookRequest> initialize() => BuiltList();
}
