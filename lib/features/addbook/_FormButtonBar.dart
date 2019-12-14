part of 'AddBookDialog.dart';

class _FormButtonBar extends StatelessWidget {
  final bool allowSubmit;

  const _FormButtonBar({Key key, @required this.allowSubmit}) : super(key: key);

  @override
  Widget build(BuildContext context) => Align(
      alignment: Alignment.centerRight,
      child: ButtonBar(
        children: <Widget>[
          FlatButton(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Text('加载'),
            onPressed: () {
              EventBus.publishTo(context, _ParseNewBookUrlEvent());
            },
          ),
          RaisedButton(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              textTheme: ButtonTextTheme.primary,
              child: Text('添加'),
              onPressed: allowSubmit
                  ? () {
                      EventBus.publishTo(context, _SubmitFormEvent());
                    }
                  : null)
        ],
      ));
}
