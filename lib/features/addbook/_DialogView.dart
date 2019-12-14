part of 'AddBookDialog.dart';

class _DialogView extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text("添加新书"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: _AddBookForm(),
      ));
}
