import 'package:html/dom.dart';
import 'package:timnew_reader/features/App/UserException.dart';

typedef T UnsafeExtract<T>();

T safe<T>(UnsafeExtract<T> action) {
  try {
    return action();
  } catch (ex) {
    print(ex);
    return null;
  }
}

String safeText(UnsafeExtract<String> action) => safe(() => action()?.trim());

Uri safeUrl(Uri base, UnsafeExtract<String> action) => safe(() {
      final urlString = action();
      if (urlString == null) return null;

      return base.resolve(urlString).replace(scheme: 'https');
    });

Uri safeUrlWithPattern(Uri base, RegExp pattern, UnsafeExtract<String> action) {
  final url = safeUrl(base, action);

  if (url != null && pattern.hasMatch(url.toString())) {
    return url;
  } else {
    return null;
  }
}

Iterable<T> safeList<T>(UnsafeExtract<Iterable<T>> action) => safe(action) ?? <T>[];

// ignore: sdk_version_never
Never userError(String message) {
  throw UserException(message);
}

void userAssert(bool assertion, String message) {
  if (!assertion) userError(message);
}

T notNull<T>(T value, String message) => value ?? {userError(message)};

extension StringParseExtension on String {
  // ignore: missing_return
  Uri asUri() {
    try {
      return Uri.parse(notNull(this, "鏈接為空"));
    } on FormatException {
      userError("無效的鏈接: $this");
    }
  }

  // ignore: missing_return
  Uri asAbsoluteUri(Uri base) {
    try {
      return base.resolve(notNull(this, "鏈接為空"));
    } on FormatException {
      userError("無效的鏈接: $this");
    }
  }

  bool safeEqual(String expected) => this?.toLowerCase() == expected;
}

extension ElementParseExtension on Element {
  String href() => attributes['href'];

  String rel() => attributes['rel'];

  Iterable<String> textNodesAsParagraphs() => nodes
      .where((node) => node.nodeType == Node.TEXT_NODE)
      .map((node) => node.text.trim())
      .where((text) => text.isNotEmpty)
      .map((text) => '    ' + text);
}

extension UriParseExtension on Uri {
  Uri enforceHttps() => replace(scheme: 'https');

  Uri nullIfPathNotMatch(RegExp pathPattern) => pathPattern.hasMatch(path) ? this : null;
}
