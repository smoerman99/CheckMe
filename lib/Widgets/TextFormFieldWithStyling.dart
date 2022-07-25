import 'package:flutter/material.dart';

class TextFormFieldWithStyling extends StatelessWidget {
  const TextFormFieldWithStyling({
    Key key,
    @required TextEditingController taskNameController,
  })  : _taskNameController = taskNameController,
        super(key: key);

  final TextEditingController _taskNameController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _taskNameController,
      style: TextStyle(
        fontSize: 16,
        color: Colors.black,
      ),
      decoration: const InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.orange, width: 1),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.orange, width: 2),
        ),
      ),
      maxLength: 50,
      cursorColor: Colors.black,
      validator: (userInput) {
        if (userInput.isEmpty) {
          return "Please enter sometext";
        } else {
          return "null";
        }
      },
    );
  }
}
