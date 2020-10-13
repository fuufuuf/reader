import 'package:timnew_reader/features/App/UserException.dart';
import 'package:timnew_reader/models/BookIndex.dart';

import 'package:timnew_reader/models/BookInfo.dart';
import 'package:timnew_reader/models/ChapterContent.dart';
import 'package:timnew_reader/models/ChapterList.dart';
import 'package:timnew_reader/models/NewBook.dart';
import 'package:timnew_reader/repositories/network/safeExtractors.dart';

import 'PiaotianAdapter.dart';
import 'SiteAdapter.dart';

import 'ReaderHttpClient.dart';

class BookRepository {
  static ReaderHttpClient client = ReaderHttpClient();

  static Map<String, SiteAdapter> adapters = {
    PiaotianAdapter.name: PiaotianAdapter(client),
    // JingjiangAdapter.name: JingjiangAdapter(client),
    // QidianAdapter.name: QidianAdapter(client)
  };

  static Future<NewBook> parseNewBook(String urlString) async {
    final url = urlString.asUri();

    final SiteAdapter adapter =
        adapters.values.firstWhere((adapter) => adapter.canParse(url)) ?? {throw UserException("不支持的網站鏈接: $urlString")};

    return await adapter.parseNewBook(url);
  }
}

extension BookIndexExtension on BookIndex {
  SiteAdapter findAdapter() => BookRepository.adapters[adapter] ?? {throw UserException("應用版本異常，找不到網站適配器: $adapter")};

  Future<ChapterList> fetchChapterList() async => findAdapter().fetchChapterList(this);

  Future<BookInfo> fetchBookInfo() async => findAdapter().fetchBookInfo(this);

  Future<ChapterContent> fetchChapterContent(Uri url) async => findAdapter().fetchChapterContent(this, url);
}
