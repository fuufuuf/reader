part of 'AddBookDialog.dart';

class _UrlField extends StatelessWidget {
  final TextEditingController controller;

  const _UrlField(this.controller) : super(key: const Key("urlField"));

  @override
  Widget build(BuildContext context) => TextFormField(
      decoration: InputDecoration(
          labelText: "新书 Url",
          suffixIcon: IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              controller.clear();
            },
          )),
      controller: controller,
      onFieldSubmitted: (_) {
        EventBus.publishTo(context, _ParseNewBookUrlEvent());
      });
}
