import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:reader/models/Book.dart';
import 'package:reader/models/ChapterContent.dart';
import 'package:reader/models/TableOfContents.dart';
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
    expect(await adapter.checkType(bookUrl), equals(Book));
    expect(await adapter.checkType(menuUrl), equals(TableOfContents));
    expect(await adapter.checkType(chapterUrl), equals(ChapterContent));
  });

  test('should parser as right type', () async {
    expect(await adapter.open(bookUrl), isInstanceOf<Book>());
    expect(await adapter.open(menuUrl), isInstanceOf<TableOfContents>());
    expect(await adapter.open(chapterUrl), isInstanceOf<ChapterContent>());
  });

  test('it should parse book', () async {
    final book = await adapter.openBook(bookUrl);

    expect(book.url, bookUrl);
    expect(book.title, equals('大道朝天'));
    expect(book.author, equals('猫腻'));
    expect(book.menuUrl,
        equals(Uri.parse('https://www.piaotian.com/html/9/9054/')));
  });

  test('it should parse menu', () async {
    final menu = await adapter.openMenu(menuUrl);

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

    expect(menu.bookUrl.path, equals(bookUrl.path));
  });

  test('it should parse chapter', () async {
    final chapter = await adapter.openChapter(chapterUrl);

    expect(chapter.url, equals(chapterUrl));
    expect(chapter.bookUrl.path, equals(bookUrl.path));
    expect(chapter.menuUrl, equals(menuUrl));
    expect(chapter.previousChapterUrl,
        equals(Uri.parse('https://www.piaotian.com/html/9/9054/5941035.html')));
    expect(chapter.nextChapterUrl,
        equals(Uri.parse('https://www.piaotian.com/html/9/9054/5941116.html')));
    
    expect(chapter.paragraphs.length, equals(86));
    expect(chapter.paragraphs.first, equals('“稍后看着何等样的天地异变，都莫要惊慌。”'));
    expect(chapter.paragraphs.last, equals('无论是镇上的民宅还是峰间的崖洞，都镀上了一层金光，仿佛真实的仙境，或者神国。'));
  });
}
