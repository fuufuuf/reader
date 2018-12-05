import 'package:flutter/material.dart';

class TextForm extends StatelessWidget {
  final String question;
  final String hint;
  final TextInputType keyboardType;
  final FormFieldSetter<String> onSubmitted;
  final String initialValue;
  final FormFieldValidator<String> validator;

  const TextForm({
    Key key,
    this.question,
    this.hint,
    this.keyboardType = TextInputType.url,
    this.onSubmitted,
    this.initialValue,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Form(
          child: Column(
        children: <Widget>[
          TextFormField(
              keyboardType: keyboardType,
              onSaved: onSubmitted,
              initialValue: initialValue,
              validator: validator,
              decoration:
                  new InputDecoration(hintText: hint, labelText: question)),
          RaisedButton(
            onPressed: () {
              Form.of(context).save();
            },
          )
        ],
      ));
}
