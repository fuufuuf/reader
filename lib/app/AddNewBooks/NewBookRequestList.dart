import 'package:built_collection/built_collection.dart';
import 'package:timnew_reader/arch/ValueSource.dart';

import 'NewBookRequest.dart';

class NewBookRequestList extends ValueSource<BuiltList<NewBookRequest>> {
  NewBookRequestList() : super(BuiltList());

  BuiltList<NewBookRequest> tryAdd(String text) {
    final requests = _buildRequests(text);

    if (!hasValue)
      return putValueSync(requests);
    else if (requests.isEmpty)
      return value;
    else
      return putValueSync(value + requests);
  }

  BuiltList<NewBookRequest> _buildRequests(String text) => text
      .split("\n")
      .map((e) => e.trim())
      .where((element) => element.isNotEmpty)
      .map((e) => NewBookRequest(e))
      .toBuiltList();

  BuiltList<NewBookRequest> clear() {
    return putValueSync(value.rebuild((b) => b.clear()));
  }

  @override
  BuiltList<NewBookRequest> initialize() => BuiltList();
}
