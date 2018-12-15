import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reader/models/BookEntry.dart';
import 'package:reader/repositories/settings/BookEntryRepository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FakeSharedPreferences {
  final Map<String, Object> data;

  FakeSharedPreferences(MethodChannel channel, this.data) {
    channel.setMockMethodCallHandler(handler);
  }

  Future<dynamic> handler(MethodCall methodCall) async {
    print("RPC: $methodCall");

    switch (methodCall.method) {
      case 'getAll':
        return data;
      case 'setString':
      case 'setStringList':
        data[methodCall.arguments['key']] = methodCall.arguments['value'];
        return true;
      case 'remove':
        data.remove(methodCall.arguments['key']);
        return true;
      case 'clear':
        data.clear();
        return true;
      default:
        print("Not implemented ${methodCall.method}");
    }
  }

  List<dynamic> get ids => data['flutter.bookEntryIds'];
}

void main() {
  final bookInfoUrl = Uri.parse("http://example.com/bookInfo");
  final bookChaptersUrl = Uri.parse("http://example.com/chapters");
  final currentChapterUrl = Uri.parse("http://example.com/chapter/current");
  final bookId = 'bookId';
  final bookName = 'book';

  FakeSharedPreferences fakePrefs;

  const channel = MethodChannel('plugins.flutter.io/shared_preferences');

  setUp(() {
    fakePrefs = FakeSharedPreferences(channel, {
      'flutter.bookEntryIds': ['oldBook'],
      'flutter.bookEntry-oldBook': '''{
        "id": "oldBook",
        "bookName": "Old Book",
        "chapterListUrl": "http://oldbook.com/chapters",
        "bookInfoUrl": "http://oldbook.com/bookintro",
        "currentChapterUrl": "http://oldbook.com/chapters/1222"
      }'''
    });
  });

  tearDown(() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  });

  test('should add book', () async {
    final list = await BookEntryRepository.fetchAll();

    final newEntry = BookEntry((b) => b
      ..id = bookId
      ..bookInfoUrl = bookInfoUrl
      ..chapterListUrl = bookChaptersUrl
      ..currentChapterUrl = currentChapterUrl
      ..bookName = bookName);

    final newList = await BookEntryRepository.addBookEntry(list, newEntry);

    expect(newList, contains(newEntry));

    expect(fakePrefs.ids, equals(['oldBook', bookId]));
    expect(fakePrefs.data['flutter.bookEntry-bookId'], isInstanceOf<String>());
  });

  test('should remove entry', () async {
    final list = await BookEntryRepository.fetchAll();

    final newList = await BookEntryRepository.removeBookEntryByIndex(list, 0);

    expect(newList, isEmpty);

    expect(fakePrefs.ids, isEmpty);
    expect(fakePrefs.data.containsKey('flutter.bookEntry-oldBook'), isFalse);
  });

  test('should update entry', () async {
    final list = await BookEntryRepository.fetchAll();

    final newList = await BookEntryRepository.updateBookEntryByIndex(
        list, 0, (b) => b..bookName = 'New Book');

    expect(newList.first.bookName, equals('New Book'));
    expect(fakePrefs.data['flutter.bookEntry-oldBook'], contains('New Book'));
  });
}
