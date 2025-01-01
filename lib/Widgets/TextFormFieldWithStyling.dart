import 'package:flutter/material.dart';

class TextFormFieldWithStyling extends StatelessWidget {
  final TextEditingController _Controller;
  final String _hintText;
  final Icon _icon;
  final TextInputType _textInputType;
  final bool _needsExpanding;

  const TextFormFieldWithStyling({
    Key? key,
    required TextEditingController controller,
    required Icon icon,
    required TextInputType textInputType,
    required bool needsExpanding,
    required String hintText,
  })  : _Controller = controller,
        _icon = icon,
        _textInputType = textInputType,
        _hintText = hintText,
        _needsExpanding = needsExpanding,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: SizedBox(
        height: 60,
        child: TextFormField(
          showCursor: true,
          obscureText: _needsExpanding,
          expands: false,
          controller: _Controller,
          style: TextStyle(
            fontSize: 20,
            color: Colors.black87, // Dark text for better readability
          ),
          keyboardType: _textInputType,
          decoration: InputDecoration(
            filled: true,
            // fillColor:
            //     Color(0xFFF7F7F7), // Light gray background for subtle elegance
            labelText: _hintText,
            labelStyle: TextStyle(
              color: Colors.black, // Softer gray color for the label text
              fontSize: 18,
              fontWeight:
                  FontWeight.bold, // Slightly bolder for better readability
            ),
            prefixIcon: _icon,

            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.black, // Bright color on focus
                width: 2.5,
              ),
              borderRadius: BorderRadius.circular(
                  12), // Rounded borders for a modern look
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey[400]!, // Subtle border when not focused
                width: 2,
              ),
              borderRadius: BorderRadius.circular(12), // Rounded borders
            ),
            errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red, // Red border on error
                width: 2,
              ),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey[400]!, // Default border color
                width: 2,
              ),
              borderRadius: BorderRadius.circular(12), // Rounded borders
            ),
            contentPadding: EdgeInsets.symmetric(
                vertical: 10, horizontal: 12), // Padding inside the text field
          ),
          cursorColor: Colors.blue, // Cursor color is blue
          autovalidateMode: AutovalidateMode
              .onUserInteraction, // Validate when user interacts
          onSaved: (String? value) {
            // This optional block of code can be used to run
            // code when the user saves the form.
          },
        ),
      ),
    );
  }
}
