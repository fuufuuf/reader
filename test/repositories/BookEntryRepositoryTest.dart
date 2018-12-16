import 'package:built_collection/built_collection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:reader/models/BookEntry.dart';
import 'package:reader/repositories/settings/BookEntryRepository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  final bookInfoUrl = Uri.parse("http://oldbook.com/bookintro");
  final bookChaptersUrl = Uri.parse("http://oldbook.com/chapters");
  final currentChapterUrl = Uri.parse("http://oldbook.com/chapters/1222");
  final bookId = 'oldbook-1-1';
  final bookName = 'Old Book';

  final listKey = 'bookEntryIds';

  final bookEntry = BookEntry((builder) =>
  builder
    ..id = bookId
    ..bookName = bookName
    ..bookInfoUrl = bookInfoUrl
    ..chapterListUrl = bookChaptersUrl
    ..currentChapterUrl = currentChapterUrl
  );

  MockSharedPreferences prefs;

  setUp(() {
    prefs = MockSharedPreferences();
  });

  void initFixture() {
    when(prefs.getStringList(listKey)).thenReturn(['oldbook-1-1']);
    when(prefs.getString('bookEntry-oldbook-1-1')).thenReturn('''{
      "id": "$bookId",
      "bookName": "$bookName",
      "chapterListUrl": "$bookChaptersUrl",
      "bookInfoUrl": "$bookInfoUrl",
      "currentChapterUrl": "$currentChapterUrl"
    }''');
  }

  test('should build entry', () {
    initFixture();
    final entry = BookEntryRepository.buildEntry(prefs, bookId);

    expect(entry, equals(bookEntry));
  });

  test('should save entry', () {
    BookEntryRepository.saveEntry(prefs, bookEntry);

    final json = verify(
        prefs.setString('bookEntry-$bookId', captureAny)).captured
        .first;

    expect(json, contains(bookId));
    expect(json, contains(bookName));
    expect(json, contains(bookInfoUrl.toString()));
    expect(json, contains(bookChaptersUrl.toString()));
    expect(json, contains(currentChapterUrl.toString()));
  });

  test('should remove entry', () {
    BookEntryRepository.removeEntry(prefs, bookId);
    verify(prefs.remove('bookEntry-$bookId'));
  });

  test('should build list', () {
    initFixture();

    final list = BookEntryRepository.buildList(prefs);

    expect(list, hasLength(1));
    expect(list.first.id, equals('oldbook-1-1'));
  });

  test('should return empty if nothing found', () {
    final list = BookEntryRepository.buildList(prefs);
    expect(list, isEmpty);
  });

  test('should save list', () {
    BookEntryRepository.saveList(
        prefs,
        BuiltList([bookEntry, bookEntry.rebuild((b) => b.id = 'newbook-1-1')]));

    verify(prefs.setStringList(listKey, [bookId, 'newbook-1-1']));
  });
}
