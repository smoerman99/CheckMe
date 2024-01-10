import 'package:flutter/material.dart';

class TextFormFieldWithStyling extends StatelessWidget {
  final TextEditingController _taskNameController;
  final String _hintText;
  final Icon _icon;
  final TextInputType _textInputType;
  final bool _needsExpanding;

  const TextFormFieldWithStyling(
      {Key? key,
      required TextEditingController taskNameController,
      required Icon icon,
      required TextInputType textInputType,
      required bool needsExpanding,
      required String hintText})
      : _taskNameController = taskNameController,
        _icon = icon,
        _textInputType = textInputType,
        _hintText = hintText,
        _needsExpanding = needsExpanding,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
      child: SizedBox(
        height: 50,
        child: TextFormField(
          obscureText: _needsExpanding,
          expands: false,
          controller: _taskNameController,
          style: TextStyle(
            fontSize: 18,
          ),
          keyboardType: _textInputType,
          decoration: InputDecoration(
            prefixIcon: _icon,
            hintText: _hintText,
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black, width: 2.0),
            ),
            border: OutlineInputBorder(),
            errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 2),
            ),
          ),
          cursorColor: Colors.black,
          autovalidateMode: AutovalidateMode.always,
          onSaved: (String? value) {
            // This optional block of code can be used to run
            // code when the user saves the form.
          },
          validator: (String? value) {
            if (value?.isEmpty != null) {
              if (value!.contains('@')) {
                return 'Do not use the @ char.';
              }
            } else {
              return null;
            }
          },
        ),
      ),
    );
  }
}
