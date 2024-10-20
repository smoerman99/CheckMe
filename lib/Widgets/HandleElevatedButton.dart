import 'package:flutter/material.dart';

class HandleElevatedButton extends StatefulWidget {
  final String title;
  final TextEditingController textController;
  // final Function executeMethod;
  final bool closePage;

  const HandleElevatedButton(
      {Key? key,
      required this.title,
      required this.textController,
      required this.closePage})
      : super(key: key);

  @override
  State<HandleElevatedButton> createState() => _HandleElevatedButtonState();
}

class _HandleElevatedButtonState extends State<HandleElevatedButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(
            Color.fromRGBO(150, 90, 90, 0.5),
          ),
        ),
        onPressed: () {
          if (widget.textController.text.isNotEmpty ||
              widget.textController.text != "") {
            // _wrapper.writeTask(
            //   new Check(
            //     title: widget.textController.text,
            //     done: false,
            //   ),
            // );

            widget.textController.text = "";

            if (widget.closePage) {
              Navigator.pop(context, false);
              print('clicked');
            }
          } else {}
        },
        child: Text(
          widget.title,
          style: TextStyle(
            color: Color.fromRGBO(150, 90, 90, 1),
            fontWeight: FontWeight.bold,
          ),
        ));
  }
}
