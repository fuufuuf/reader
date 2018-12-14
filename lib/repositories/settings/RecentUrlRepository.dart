import 'package:shared_preferences/shared_preferences.dart';

class RecentUrlRepository {
  static const recentUrlsKey = 'recentUrls';
  static const maxCount = 10;

  static Future<List<String>> loadRecentUrls() async {
    final instance = await SharedPreferences.getInstance();

    return instance.getStringList(recentUrlsKey);
  }

  static Future<bool> recentOpened(Uri url) async {
    final instance = await SharedPreferences.getInstance();

    final list = instance.getStringList(recentUrlsKey);

    _updateList(list, url);

    return instance.setStringList(recentUrlsKey, list);
  }

  static _updateList(List<String> list, Uri url) {
    final newUrl = url.toString();

    if (list.contains(newUrl)) {
      list.remove(newUrl);
      list.insert(0, newUrl);
    } else {
      list.insert(0, newUrl);
      if (list.length > maxCount) {
        list.removeLast();
      }
    }
  }
}
