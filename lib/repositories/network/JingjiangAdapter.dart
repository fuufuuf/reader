import 'package:html/dom.dart';
import 'package:timnew_reader/models/BookInfo.dart';
import 'package:timnew_reader/models/ChapterContent.dart';
import 'package:timnew_reader/models/ChapterList.dart';
import 'package:timnew_reader/models/ChapterRef.dart';
import 'package:timnew_reader/models/NewBook.dart';
import 'package:timnew_reader/repositories/network/ReaderHttpClient.dart';
import 'package:timnew_reader/repositories/network/SiteAdapter.dart';
import 'package:timnew_reader/repositories/network/safeExtractors.dart';

class JingjiangAdapter extends SiteAdapter {
  JingjiangAdapter(ReaderHttpClient client) : super(client);

  static final bookUrlPattern = RegExp(r"http://www.jjwxc.net/onebook.php?novelid=(\d+)", caseSensitive: false);

  static final chapterContentUrlPattern =
      RegExp(r"http://www.jjwxc.net/onebook.php?novelid=(\d+)&chapterid=(\d+)", caseSensitive: false);

  @override
  Future<Type> fetchResourceType(Uri url) async {
    _assertUrl(url);

    if (_chapterId(url) != null) {
      return ChapterContent;
    } else {
      return ChapterList;
    }
  }

  @override
  Future<NewBook> createBook(Uri url) async {
    final content = await fetchFromUrl(url);

    if (content is ChapterList) {
      return _buildBookEntryFromChapterList(content);
    }

    if (content is ChapterContent) {
      return _buildBookEntryFromChapterContent(content);
    }

    assert(false);
  }

  NewBook _buildBookEntryFromChapterList(ChapterList list) => NewBook(
        bookId: _extractBookId(list.bookInfoUrl),
        bookName: list.title,
        bookInfoUrl: list.bookInfoUrl,
        chapterListUrl: list.url,
      );

  Future<NewBook> _buildBookEntryFromChapterContent(ChapterContent content) async {
    return _buildBookEntryFromChapterList(await content.fetchChapterList())
        .rebuild((b) => b..currentChapterUrl = content.url);
  }

  String _extractBookId(Uri url) {
    return 'jingjiang-${_bookId(url)}';
  }

  @override
  Future<BookInfo> fetchBookInfo(Uri url) async {
    final document = await client.fetchDom(url, enforceGbk: true);

    return BookInfo(
      url: url,
      bookId: _bookId(url),
      chapterListUrl: url,
      title: safeText(() => document.querySelector('[itemprop=articleSection]').text),
      author: safeText(() => document.querySelector('[itemprop=author]').text),
      genre: safeText(() => document.querySelector('[itemprop=genre]').text),
      completeness: safeText(() => document.querySelector('[itemprop=updataStatus]').text),
      lastUpdated: "",
      length: safeText(() => document.querySelector('[itemprop=wordCount]').text),
    );
  }

  @override
  Future<ChapterList> fetchChapterList(Uri url) async {
    final document = await client.fetchDom(url, enforceGbk: true);

    return ChapterList(
      url: url,
      bookInfoUrl: url,
      title: safeText(() => document.querySelector('[itemprop=articleSection]').text),
      chapters: safeList(() => document.querySelectorAll('[itemprop=chapter]').map((e) => _buildChapterRef(url, e))),
    );
  }

  ChapterRef _buildChapterRef(Uri url, Element element) {
    final tds = element.querySelectorAll('td');

    final chapterIndex = safeText(() => tds[1].text);
    final chapterAbstract = safeText(() => tds[2].text);

    final title = "$chapterIndex $chapterAbstract";

    final normalUrl = safeUrl(url, () => element.querySelector('[itemprop=url]').attributes['href']);

    final chapterUrl = normalUrl ?? safeUrl(url, () => element.querySelector('[itemprop=url]').attributes['rel']);

    return ChapterRef(
      title: title,
      url: chapterUrl,
    );
  }

  @override
  Future<ChapterContent> fetchChapterContent(Uri url) async {
    final document = await client.fetchDom(url, enforceGbk: true);

    return ChapterContent((result) {
      result
        ..url = url
        ..chapterListUrl = url.resolve(document.querySelector('.noveltitle a').attributes['href']);

      final contentTable = document.getElementById('oneboolt');
      final rows = contentTable.querySelectorAll('tr');

      final pagingLinks = rows.last.querySelectorAll('a');
      final pageLinksCount = pagingLinks.length;

      parseAssert(pageLinksCount == 1 || pageLinksCount == 2, "導航條解析錯誤：異常的導航鏈接數 $pageLinksCount");

      if (pageLinksCount == 1) {
        result..previousChapterUrl = null;
      } else {
        result..previousChapterUrl = safeUrl(url, () => pagingLinks.first.attributes['href']);
      }

      final nextUrl = url.resolve(pagingLinks.last.attributes['href']);
      if (safeCompare(nextUrl.path, "/onebook.php"))
        result..nextChapterUrl = nextUrl;
      else
        result..nextChapterUrl = null;

      final contentText = contentTable.querySelector('.noveltext');

      result
        ..title = safeText(() => contentText.querySelector('h2').text)
        ..paragraphs.addAll(safeList(() => contentText.nodes
            .where((node) => node.nodeType == Node.TEXT_NODE)
            .map((node) => node.text.trim())
            .where((text) => text.isNotEmpty)
            .map((text) => '    ' + text)))
        ..isLocked = false;
    });
  }

  void _assertUrl(Uri url) {
    parseAssert(safeCompare(url.host, 'www.jjwxc.net'), "不支持的網站: ${url.host}");

    parseAssert(safeCompare(url.path, '/onebook.php'), "不支持的路徑: ${url.path}");

    parseAssert(url.hasQuery, "沒有 QueryString: ${url.toString()}");

    parseAssert(_bookId(url) != null, "沒有數目 ID");
  }

  String _chapterId(Uri url) => url.queryParameters["chapterid"];

  String _bookId(Uri url) => url.queryParameters["novelid"];
}
