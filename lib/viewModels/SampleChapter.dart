import 'package:built_collection/built_collection.dart';
import 'package:reader/models/ChapterContent.dart';
import 'package:reader/models/ChapterList.dart';

class SampleChapter implements ChapterContent {
  @override
  Uri get chapterListUrl => null;

  @override
  Future<ChapterList> fetchChapterList() => null;

  @override
  Future<ChapterContent> fetchNextChapter() => null;

  @override
  Future<ChapterContent> fetchPreviousChapter() => null;

  @override
  bool get hasNext => false;

  @override
  bool get hasPrevious => false;

  @override
  Uri get nextChapterUrl => null;

  @override
  BuiltList<String> get paragraphs => BuiltList<String>(const [
        '  作者自云：曾历过一番梦幻之后，故将真事隐去，而借通灵说此《石头记》一书也，故曰“甄士隐”云云。但书中所记何事何人?自己又云：“今风尘碌碌，一事无成，忽念及当日所有之女子：一一细考较去，觉其行止见识皆出我之上。我堂堂须眉诚不若彼裙钗，我实愧则有馀，悔又无益，大无可如何之日也。',
        '  看官你道此书从何而起?说来虽近荒唐，细玩颇有趣味。却说那女娲氏炼石补天之时，于大荒山无稽崖炼成高十二丈、见方二十四丈大的顽石三万六千五百零一块。那娲皇只用了三万六千五百块，单单剩下一块未用，弃在青埂峰下。',
        '  又不知过了几世几劫，因有个空空道人访道求仙，从这大荒山无稽崖青埂峰下经过。'
      ]);

  @override
  Uri get previousChapterUrl => null;

  @override
  ChapterContent rebuild(Function(ChapterContentBuilder builder) updates) =>
      null;

  @override
  Future<ChapterContent> reload() => null;

  @override
  String get title => '文章标题';

  @override
  ChapterContentBuilder toBuilder() => null;

  @override
  Uri get url => null;
}
