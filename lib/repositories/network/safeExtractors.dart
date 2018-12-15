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

      return base.resolve(urlString);
    });

Iterable<T> safeList<T>(UnsafeExtract<Iterable<T>> action) => safe(action) ?? <T>[];
