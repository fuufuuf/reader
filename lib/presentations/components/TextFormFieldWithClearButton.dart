import 'package:flutter/material.dart';

class TextFormFieldWithClearButton extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final ValueChanged<String> onFieldSubmitted;

  const TextFormFieldWithClearButton({Key key, this.controller, this.labelText, this.onFieldSubmitted})
      : super(key: key);

  @override
  _TextFormFieldWithClearButtonState createState() => _TextFormFieldWithClearButtonState();
}

class _TextFormFieldWithClearButtonState extends State<TextFormFieldWithClearButton> {
  bool _showClearButton;

  @override
  void initState() {
    super.initState();

    _onTextChangedByController();

    widget.controller.addListener(_onTextChangedByController);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChangedByController);
    super.dispose();
  }

  void _onTextChangedByController() {
    _textChanged(widget.controller.text);
  }

  void _textChanged(String text) {
    final newValue = text.length > 0;
    if (newValue != _showClearButton) {
      setState(() {
        _showClearButton = newValue;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        decoration: InputDecoration(labelText: widget.labelText, suffixIcon: _buildClearButton()),
        controller: widget.controller,
        onChanged: _textChanged,
        onFieldSubmitted: widget.onFieldSubmitted);
  }

  Widget _buildClearButton() {
    if (!_showClearButton) return null;

    return IconButton(
      icon: Icon(Icons.clear),
      onPressed: () {
        setState(() {
          widget.controller.clear();
        });
      },
    );
  }
}
