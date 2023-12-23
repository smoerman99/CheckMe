import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class CategoryContainer extends StatefulWidget {
  final int openDoings;
  final Icon icon;
  final String title;

  const CategoryContainer(
      {Key key,
      @required this.openDoings,
      @required this.icon,
      @required this.title})
      : super(key: key);

  @override
  State<CategoryContainer> createState() => _CategoryContainerState();
}

class _CategoryContainerState extends State<CategoryContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.height / 100 * 15,
      height: MediaQuery.of(context).size.width / 100 * 25,
      child: Card(
        color: widget.openDoings > 0
            ? Color.fromRGBO(150, 90, 90, 1)
            : Colors.white.withOpacity(1.0),
        child: Column(
          children: [
            Row(
              children: [
                widget.icon,
                Text(
                  widget.title,
                  style: TextStyle(fontSize: 25),
                )
              ],
            ),
            Row(
              children: [Text('To Do: ' + widget.openDoings.toString())],
            )
          ],
        ),
      ),
    );
  }
}
