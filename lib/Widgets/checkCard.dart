import 'package:flutter/material.dart';

class CheckCard extends StatefulWidget {
  final String categorie;
  final String dateAdded;
  final String priority;
  final int remember;
  final String title;

  const CheckCard({
    Key? key,
    required this.categorie,
    required this.dateAdded,
    required this.priority,
    required this.remember,
    required this.title,
  }) : super(key: key);

  @override
  State<CheckCard> createState() => __CheckCardStateState();
}

class __CheckCardStateState extends State<CheckCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        ListTile(
          title: Text(widget.title),
          subtitle: Text(widget.priority),
        )
      ]),
    );
  }
}
