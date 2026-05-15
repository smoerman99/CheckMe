import 'package:flutter/material.dart';

class CategoryContainer extends StatefulWidget {
  final Icon icon;
  final String title;
  final int openDoings;

  const CategoryContainer(
      {Key? key,
      required this.icon,
      required this.title,
      required this.openDoings})
      : super(key: key);

  @override
  State<CategoryContainer> createState() => _CategoryContainerState();
}

class _CategoryContainerState extends State<CategoryContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.height / 100 * 12,
      height: MediaQuery.of(context).size.width / 100 * 20,
      child: Card(
        elevation: 0.0,
        color: widget.openDoings > 0
            ? Color.fromRGBO(32, 39, 26, 0.212)
            : Colors.white.withOpacity(1.0),
        child: Container(
          child: Column(children: [
            Padding(padding: EdgeInsets.fromLTRB(0, 16, 0, 0)),
            Row(
                children: [widget.icon],
                mainAxisAlignment: MainAxisAlignment.center),
            widget.openDoings > 0
                ? Row(
                    children: [
                      Text(
                        widget.openDoings.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 27, 41, 30),
                          fontSize: 15,
                        ),
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  )
                : Text(
                    '',
                    style: TextStyle(color: Colors.yellow, fontSize: 15),
                  )
          ]),
        ),
      ),
    );
  }
}
