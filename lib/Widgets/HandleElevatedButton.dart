import 'package:checkit/JsonThings/wrapper.dart';
import 'package:flutter/material.dart';

import '../Entities/Check.dart';

class HandleElevatedButton extends StatefulWidget {
  final String title;
  final TextEditingController textController;
  final bool closePage;

  const HandleElevatedButton(
      {Key key,
      @required this.title,
      @required this.textController,
      @required this.closePage})
      : super(key: key);

  @override
  State<HandleElevatedButton> createState() => _HandleElevatedButtonState();
}

class _HandleElevatedButtonState extends State<HandleElevatedButton> {
  final _wrapper = new Wrapper();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all(Theme.of(context).buttonColor)),
        onPressed: () {
          if (widget.textController.text != "" ||
              widget.textController.text.isNotEmpty) {
            _wrapper.executeWrite(
              new Check(
                widget.textController.text,
                false,
              ),
            );

            widget.textController.text == "";

            if (widget.closePage) {
              Navigator.pop(context, false);
            }
          } else {}
        },
        child: Text(
          widget.title,
          style: TextStyle(color: Colors.black),
        ));
  }
}
