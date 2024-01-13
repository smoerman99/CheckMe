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
      width: MediaQuery.of(context).size.height / 100 * 13,
      height: MediaQuery.of(context).size.width / 100 * 22,
      child: Card(
        color: widget.openDoings > 0
            ? Color.fromRGBO(150, 90, 90, 1)
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
                        style: TextStyle(color: Colors.black, fontSize: 12),
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.end,
                  )
                : Text(
                    '',
                    style: TextStyle(color: Colors.black, fontSize: 12),
                  )
          ]),
        ),
      ),
    );
  }
}
