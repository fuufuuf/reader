import 'dart:io';

import 'package:timnew_reader/repositories/network/ReaderHttpClient.dart';

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
    _fixtureMap[url] = Platform.script.resolve('./test/repositories/').resolve(fileName);
    return this;
  }
}
