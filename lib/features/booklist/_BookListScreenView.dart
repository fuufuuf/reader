part of 'BookListScreen.dart';

class _BookListScreenView extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      Scaffold(
        appBar: AppBar(
          title: Text("米良读书"),
        ),
        body: _BookList(),
        floatingActionButton: _AddBookButton(),
      );
}

class _AddBookButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            EventBus.publishTo(context, _AddBookEvent());
          }
      );
}

class _BookList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final books = BookListStore
        .of(context)
        .books;

    return Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
            itemBuilder: (context, index) => _BookIndexItem(books[index]),
            itemCount: books.length)
    );
  }
}

class _BookIndexItem extends StatelessWidget {
  final BookIndex book;

  _BookIndexItem(this.book);

  @override
  Widget build(BuildContext context) =>
      Dismissible(
          key: Key(book.id),
          background: Container(
            color: Colors.redAccent,
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 16),
            child: Text('滑动删除', style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold)),
          ),
          direction: DismissDirection.endToStart,
          onDismissed: (DismissDirection direction) {
            EventBus.publishTo(context, _RemoveBookEvent(book));
          },
          dismissThresholds: const {DismissDirection.endToStart: .9},
          child: ListTile(
              leading: Icon(Icons.book),
              title: Text(book.title),
              trailing: IconButton(
                  icon: Icon(Icons.info_outline),
                  onPressed: () {
                    EventBus.publishTo(context, _ShowChapterListEvent(book));
                  }),
              onTap: () {
                EventBus.publishTo(context, _OpenBookEvent(book));
              }
          ));

}
