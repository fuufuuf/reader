part of 'ChapterListScreen.dart';

class _ChapterListScreenView extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: _BookTitle(),
          actions: <Widget>[_BookInfoButton()],
        ),
        body: _ChapterList(),
      );
}

class _BookInfoButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bookIndex =
        CurrentBookStore.of(context, CurrentBookAspect.BookIndex).bookIndex;

    return IconButton(
        icon: Icon(Icons.info_outline),
        onPressed: () {
          EventBus.publishTo(context, _ShowBookInfoEvent(bookIndex));
        });
  }
}

class _BookTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Text(_fetchTitle(context));

  String _fetchTitle(BuildContext context) =>
      CurrentBookStore.of(context, CurrentBookAspect.BookIndex).bookIndex.title;
}

class _ChapterList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var chapters =
        CurrentBookStore.of(context, CurrentBookAspect.ChapterList).chapterList;

    return ListView.builder(
        itemCount: chapters.length,
        itemBuilder: (context, index) {
          final chapterRef = chapters[index];
          return _ChapterListItem(
              key: Key(chapterRef.url.toString()), chapterRef: chapterRef);
        });
  }
}

class _ChapterListItem extends StatelessWidget {
  final ChapterRef chapterRef;

  const _ChapterListItem({Key key, this.chapterRef}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.bookmark_border),
      title: Text(chapterRef.title),
      onTap: () {
        EventBus.publishTo(context, _ShowChapterContentEvent(chapterRef));
      },
    );
  }
}
