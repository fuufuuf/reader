import 'package:built_collection/built_collection.dart';
import 'package:html/dom.dart';

import 'package:timnew_reader/features/App/common.dart';
import 'package:timnew_reader/repositories/network/ReaderHttpClient.dart';
import 'package:timnew_reader/repositories/network/SiteAdapter.dart';
import 'package:timnew_reader/repositories/network/ParseExtensions.dart';

import 'package:timnew_reader/models/BookIndex.dart';
import 'package:timnew_reader/models/BookInfo.dart';
import 'package:timnew_reader/models/ChapterContent.dart';
import 'package:timnew_reader/models/ChapterList.dart';
import 'package:timnew_reader/models/ChapterRef.dart';
import 'package:timnew_reader/models/NewBook.dart';

class JingjiangAdapter extends SiteAdapter {
  static const String adapterName = "jingjiang";

  JingjiangAdapter(ReaderHttpClient client) : super(client);

  @override
  bool canParse(Uri url) => url.host.safeEqual('www.jjwxc.net') || url.host.safeEqual("my.jjwxc.net");

  // http://www.jjwxc.net/onebook.php?novelid=4398312
  // http://www.jjwxc.net/onebook.php?novelid=4398312&chapterid=1
  // http://my.jjwxc.net/onebook_vip.php?novelid=4398312&chapterid=19
  String _extractBookId(Uri url) => url.queryParameters["novelid"];

  String _extractChapterId(Uri url) => url.queryParameters["chapterid"];

  bool _isVipChapter(Uri url) => url.path.safeEqual("/onebook_vip.php");

  @override
  Future<BookInfo> fetchBookInfo(BookIndex bookIndex) async {
    final document = await client.fetchDom(bookIndex.bookInfoUrl);

    return BookInfo(
      bookIndex: bookIndex,
      author: document.querySelector('[itemprop=author]')?.text?.trim(),
      genre: document.querySelector('[itemprop=genre]')?.text?.trim(),
      completeness: document.querySelector('[itemprop=updataStatus]')?.text?.trim(),
      length: document.querySelector('[itemprop=wordCount]')?.text?.trim(),
    );
  }

  @override
  Future<ChapterList> fetchChapterList(BookIndex bookIndex) async {
    final document = await client.fetchDom(bookIndex.chapterListUrl);

    return ChapterList(
      bookIndex: bookIndex,
      chapters: _builtChapterList(bookIndex, document),
    );
  }

  BuiltList<ChapterRef> _builtChapterList(BookIndex bookIndex, Document document) =>
      document.querySelectorAll('[itemprop=chapter]').map((e) => _buildChapterRef(bookIndex, e)).toBuiltList();

  ChapterRef _buildChapterRef(BookIndex bookIndex, Element element) {
    /*
    <tr itemprop="chapter" itemscope="" itemtype="http://schema.org/Chapter">
      <td align="center">1</td>
      <td>
        <span itemprop="headline">
          <div style="float: left">
            <a itemprop="url" href="http://www.jjwxc.net/onebook.php?novelid=4708412&amp;chapterid=1">?????????</a>
          </div>
          <div style="float: right"></div>
        </span>
      </td>
      <td>??????????????????????????????????????????????????????</td>
      <td align="center" itemprop="wordCount">3192</td>
      <td align="center" class="chapterclick" clickchapterid="1">179318</td>
      <td
        align="center"
        title="?????????????????????2020-07-04 00:08:39 ?????????????????????2020-07-06 09:00:00"
      >
        <span> 2020-08-13 20:00:12 </span>
      </td>
    </tr>
     */
    final tds = element.querySelectorAll('td');

    satisfy(tds.length > 3) ?? userError("???????????????????????????: $element");

    // tds[1] and tds[2] which contains chapter name varies from book to book
    final title = tds.sublist(1, 2).map((e) => e.text?.trim()).where((e) => e != null).join(" ");

    final aElement = element.querySelector('[itemprop=url]') ?? userError("????????????????????????: $element");

    final normalUrl = aElement?.href()?.asAbsoluteUri(bookIndex.chapterListUrl)?.enforceHttps();

    final chapterUrl = normalUrl ?? aElement?.rel()?.asAbsoluteUri(bookIndex.chapterListUrl)?.enforceHttps();

    return ChapterRef(
      bookIndex: bookIndex,
      title: title,
      url: chapterUrl,
      isLocked: normalUrl == null,
    );
  }

  @override
  Future<ChapterContent> fetchChapterContent(BookIndex bookIndex, Uri url) async {
    if (_isVipChapter(url)) return _buildVipChapterContent(bookIndex, url);

    final document = await client.fetchDom(url);

    final contentTable = document.getElementById('oneboolt') ?? userError("??????????????????, ??????????????????");

    final pagingLinks =
        contentTable.querySelectorAll('tr')?.last?.querySelectorAll('a') ?? userError("??????????????????, ?????????????????????");

    final pageLinksCount = pagingLinks.length;
    pageLinksCount.checkInRange(1, 2, "???????????????????????????????????????????????? $pageLinksCount");

    final previousChapterUrl = pageLinksCount == 1 ? null : pagingLinks.first.href().asAbsoluteUri(url).enforceHttps();

    final nextUrl = pagingLinks.last.href().asAbsoluteUri(url).enforceHttps();
    final nextChapterUrl = nextUrl.path.safeEqual("/onebook.php") ? nextUrl : null;

    final contentText = contentTable.querySelector('.noveltext') ?? userError("????????????????????????");

    return ChapterContent(
      bookIndex: bookIndex,
      url: url,
      title: contentText.querySelector('h2')?.text?.trim() ?? userError("????????????????????????"),
      previousChapterUrl: previousChapterUrl,
      nextChapterUrl: nextChapterUrl,
      isLocked: false,
      paragraphs: contentText.notEmptyTextChildrenAsParagraphs(),
    );
  }

  ChapterContent _buildVipChapterContent(BookIndex bookIndex, Uri url) => ChapterContent(
        bookIndex: bookIndex,
        url: url,
        title: "VIP ??????",
        isLocked: true,
        paragraphs: BuiltList.of(["VIP ??????????????????"]),
      );

  @override
  Future<NewBook> parseNewBook(Uri url) {
    satisfy(url.host.safeEqual('www.jjwxc.net')) ?? userError("??????????????????: ${url.host}");
    satisfy(url.path.safeEqual('/onebook.php')) ?? userError("??????????????????: ${url.path}");
    satisfy(url.hasQuery) ?? userError("?????? QueryString: ${url.toString()}");
    _extractBookId(url) ?? userError("???????????? ID");

    final chapterId = _extractChapterId(url);
    if (chapterId == null) return newBookFromBookInfo(url);
    return newBookFromChapterContent(url);
  }

  String _buildBookId(Uri url) => "${adapterName}-${_extractBookId(url)}";

  Future<NewBook> newBookFromBookInfo(Uri url) async {
    final document = await client.fetchDom(url);

    return NewBook(
      adapter: adapterName,
      bookId: _buildBookId(url),
      bookName: document.querySelector('[itemprop=articleSection]').text?.trim(),
      bookInfoUrl: url,
      chapterListUrl: url,
    );
  }

  Future<NewBook> newBookFromChapterContent(Uri url) async {
    final document = await client.fetchDom(url);

    final titleElement = document.querySelector('.noveltitle a');
    final chapterListUrl = titleElement.href()?.asUri()?.enforceHttps();

    return NewBook(
      adapter: adapterName,
      bookId: _buildBookId(url),
      bookName: titleElement.text?.trim(),
      bookInfoUrl: chapterListUrl,
      chapterListUrl: chapterListUrl,
      currentChapterUrl: url,
    );
  }
}
