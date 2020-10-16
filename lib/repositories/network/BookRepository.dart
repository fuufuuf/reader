import 'package:timnew_reader/features/App/common.dart';
import 'package:timnew_reader/models/BookIndex.dart';

import 'package:timnew_reader/models/BookInfo.dart';
import 'package:timnew_reader/models/ChapterContent.dart';
import 'package:timnew_reader/models/ChapterList.dart';
import 'package:timnew_reader/models/NewBook.dart';
import 'package:timnew_reader/repositories/network/ParseExtensions.dart';

import 'SiteAdapter.dart';
import 'JingjiangAdapter.dart';
import 'PiaotianAdapter.dart';
import 'QidianAdapter.dart';

import 'ReaderHttpClient.dart';

class BookRepository {
  static ReaderHttpClient client = ReaderHttpClient();

  static Map<String, SiteAdapter> adapters = {
    PiaotianAdapter.adapterName: PiaotianAdapter(client),
    JingjiangAdapter.adapterName: JingjiangAdapter(client),
    QidianAdapter.adapterName: QidianAdapter(client)
  };

  static Future<NewBook> parseNewBook(String urlString) async {
    final url = urlString.asUri();

    final SiteAdapter adapter =
        adapters.values.firstWhere((adapter) => adapter.canParse(url), orElse: () => userError("不支持的網站鏈接: $urlString"));

    return adapter.parseNewBook(url).userTimeout(adapter.defaultLoadTimeout, "頁面加載超時");
  }
}

extension BookIndexNetworkExtension on BookIndex {
  SiteAdapter findAdapter() => BookRepository.adapters[adapter] ?? userError("應用版本異常，找不到網站適配器: $adapter");

  Future<ChapterList> fetchChapterList() async {
    final adapter = findAdapter();

    return adapter.fetchChapterList(this).userTimeout(adapter.defaultLoadTimeout, "頁面加載超時");
  }

  Future<BookInfo> fetchBookInfo() async {
    final adapter = findAdapter();

    return adapter.fetchBookInfo(this).userTimeout(adapter.defaultLoadTimeout, "頁面加載超時");
  }

  Future<ChapterContent> fetchChapterContent(Uri url) async {
    final adapter = findAdapter();

    return adapter.fetchChapterContent(this, url).userTimeout(adapter.defaultLoadTimeout, "頁面加載超時");
  }
}
