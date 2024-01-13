import 'package:checkit/Firebase/Firestore.dart';
import 'package:flutter/material.dart';

class CheckCard extends StatefulWidget {
  final String categorie;
  final DateTime dateAdded;
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
  FireStore _fireStore = FireStore();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        ListTile(
          onTap: () => print(widget.title),
          title:
              Text(widget.title, style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text('Category: ' + widget.categorie),
        )
      ]),
    );
  }
}
