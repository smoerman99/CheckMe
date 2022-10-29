import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  const TextWidget(
      {Key key, @required String content, @required double fontSize})
      : _content = content,
        _fontSize = fontSize,
        super(key: key);

  final String _content;
  final double _fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      _content,
      style: TextStyle(
        color: Colors.black,
        fontSize: _fontSize,
        fontFamily: "RobotoMono",
      ),
    );
  }
}
