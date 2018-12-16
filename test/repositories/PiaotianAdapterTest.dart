import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:reader/models/BookEntry.dart';
import 'package:reader/models/BookInfo.dart';
import 'package:reader/models/ChapterContent.dart';
import 'package:reader/models/ChapterList.dart';
import 'package:reader/repositories/network/PiaotianAdapter.dart';
import 'package:reader/repositories/network/ReaderHttpClient.dart';

class FakeClient extends ReaderHttpClient {
  final Map<Uri, Uri> _fixtureMap = Map<Uri, Uri>();

  @override
  Future<String> fetchHtml(Uri url, {bool enforceGbk: false}) async {
    var fileName = _fixtureMap[url];

    if (fileName == null) {
      throw "Http Error 404";
    }

    return File.fromUri(fileName).readAsString();
  }

  FakeClient registerFixture(Uri url, String fileName) {
    _fixtureMap[url] =
        Platform.script.resolve('./test/fixtures/').resolve(fileName);
    return this;
  }
}

void main() {
  final FakeClient client = FakeClient();
  final PiaotianAdapter adapter = PiaotianAdapter(client);

  final bookUrl = Uri.parse('https://www.piaotian.com/bookinfo/9/9054.html');
  final menuUrl = Uri.parse('https://www.piaotian.com/html/9/9054/');
  final chapterUrl =
      Uri.parse('https://www.piaotian.com/html/9/9054/5941036.html');
  final testUrl = Uri.parse('/test');

  setUp(() {
    client
        .registerFixture(bookUrl, "book.html")
        .registerFixture(menuUrl, 'menu.html')
        .registerFixture(chapterUrl, 'chapter.html')
        .registerFixture(testUrl, 'test.html');
  });

  test('test setup', () async {
    await client.fetchHtml(bookUrl);
    await client.fetchHtml(menuUrl);
    await client.fetchHtml(chapterUrl);
  });

  test('should check type', () async {
    expect(await adapter.fetchResourceType(bookUrl), equals(BookInfo));
    expect(await adapter.fetchResourceType(menuUrl), equals(ChapterList));
    expect(await adapter.fetchResourceType(chapterUrl), equals(ChapterContent));
  });

  test('should parser as right type', () async {
    expect(await adapter.fetchFromUrl(bookUrl),
        allOf(isNotNull, isInstanceOf<BookInfo>()));
    expect(await adapter.fetchFromUrl(menuUrl),
        allOf(isNotNull, isInstanceOf<ChapterList>()));
    expect(await adapter.fetchFromUrl(chapterUrl),
        allOf(isNotNull, isInstanceOf<ChapterContent>()));
  });

  test('it should parse book info', () async {
    final book = await adapter.fetchBookInfo(bookUrl);

    expect(book.url, bookUrl);
    expect(book.bookId, equals('piaotian-9-9054'));
    expect(book.chapterListUrl,
        equals(Uri.parse('https://www.piaotian.com/html/9/9054/')));
    expect(book.title, equals('大道朝天'));
    expect(book.author, equals('猫腻'));
    expect(book.genre, equals('玄幻魔法'));
    expect(book.completeness, equals('连载中'));
    expect(book.lastUpdated, equals('2018-12-07'));
    expect(book.length, equals('1429051字'));
  });

  test('it should parse chapter list', () async {
    final menu = await adapter.fetchChapterList(menuUrl);

    expect(menu.url, menuUrl);
    expect(menu.title, equals('大道朝天'));
    expect(menu.chapters.length, equals(439));

    final firstChapter = menu.chapters.first;
    expect(firstChapter.title, equals('说在前面'));
    expect(firstChapter.url,
        equals(Uri.parse('https://www.piaotian.com/html/9/9054/5941033.html')));

    final lastChapter = menu.chapters.last;
    expect(lastChapter.title, equals('第一章剑峰生于天地间'));
    expect(lastChapter.url,
        equals(Uri.parse('https://www.piaotian.com/html/9/9054/6868941.html')));

    expect(menu.bookInfoUrl, equals(bookUrl));
  });

  test('it should parse chapter content', () async {
    final chapter = await adapter.fetchChapterContent(chapterUrl);

    expect(chapter.url, equals(chapterUrl));
    expect(chapter.chapterListUrl, equals(menuUrl));
    expect(chapter.previousChapterUrl,
        equals(Uri.parse('https://www.piaotian.com/html/9/9054/5941035.html')));
    expect(chapter.nextChapterUrl,
        equals(Uri.parse('https://www.piaotian.com/html/9/9054/5941116.html')));
    
    expect(chapter.paragraphs.length, equals(86));
    expect(chapter.paragraphs.first, equals('“稍后看着何等样的天地异变，都莫要惊慌。”'));
    expect(chapter.paragraphs.last, equals('无论是镇上的民宅还是峰间的崖洞，都镀上了一层金光，仿佛真实的仙境，或者神国。'));
  });

  group('parse book entry', () {
    final bookEntry = BookEntry((b) =>
    b
      ..id = 'piaotian-9-9054'
      ..bookName = '大道朝天'
      ..bookInfoUrl = Uri.parse('https://www.piaotian.com/bookinfo/9/9054.html')
      ..chapterListUrl = Uri.parse('https://www.piaotian.com/html/9/9054/')
    );

    test('should parse from book info page', () async {
      final entry = await adapter.fetchBookEntry(bookUrl);

      expect(entry, equals(bookEntry));
    });

    test('should parse from chapter list', () async {
      final entry = await adapter.fetchBookEntry(menuUrl);

      expect(entry, equals(bookEntry));
    });

    test('should parse from chapter content', () async {
      final entry = await adapter.fetchBookEntry(chapterUrl);

      expect(entry, equals(bookEntry));
    });
  });
}
