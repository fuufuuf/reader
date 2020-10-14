import 'package:built_collection/built_collection.dart';
import 'package:html/dom.dart';
import 'package:timnew_reader/features/App/UserException.dart';

// ignore: sdk_version_never
Never userError(String message) {
  throw UserException(message);
}

dynamic satisfy(bool assertion) {
  if (!assertion) return null;
  return assertion;
}

extension StringParseExtension on String {
  // ignore: missing_return
  Uri asUri() {
    try {
      return Uri.parse(this ?? userError("鏈接為空"));
    } on FormatException {
      userError("無效的鏈接: $this");
    }
  }

  // ignore: missing_return
  Uri asAbsoluteUri(Uri base) {
    try {
      return base.resolve(this ?? userError("鏈接為空"));
    } on FormatException {
      userError("無效的鏈接: $this");
    }
  }

  bool safeEqual(String expected) => this?.toLowerCase() == expected ?? false;

  String remove(String toBeRemoved) => replaceAll(toBeRemoved, "");
}

extension ElementParseExtension on Element {
  String href() => attributes['href'];

  String rel() => attributes['rel'];

  String firstNotEmptyChildText() => nodes.notEmptyTexts().first;

  BuiltList<String> notEmptyTextChildrenAsParagraphs() => nodes.textChildren().notEmptyTexts().asParagraphs();

  BuiltList<String> notEmptyChildrenTextAsParagraphs() => nodes.notEmptyTexts().asParagraphs();
}

extension NodeListParseExtension on Iterable<Node> {
  Iterable<Node> textChildren() => where((node) => node.nodeType == Node.TEXT_NODE);

  Iterable<String> notEmptyTexts() => map((node) => node.text.trim()).where((text) => text.isNotEmpty);
}

extension StringIterableExtension on Iterable<String> {
  BuiltList<String> asParagraphs() => map((text) => '    ' + text).toBuiltList();
}

extension UriParseExtension on Uri {
  Uri enforceHttps() => replace(scheme: 'https');

  Uri nullIfPathNotMatch(RegExp pathPattern) => pathPattern.hasMatch(path) ? this : null;
}

extension IntParseExtension on int {
  int checkInRange(int low, int high, String message) {
    satisfy(this >= low && this <= high) ?? userError(message);

    return this;
  }
}

extension ObjectParseExtension<T> on T {
  T nullIf(bool Function(T) criteria) {
    if (criteria(this)) return null;
    return this;
  }

  T nullIfNot(bool Function(T) criteria) {
    if (!criteria(this)) return null;
    return this;
  }
}
