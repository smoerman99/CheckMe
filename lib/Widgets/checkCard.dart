import 'package:checkit/Firebase/Firestore.dart';
import 'package:flutter/material.dart';

class CheckCard extends StatefulWidget {
  final ValueChanged<int> update;
  final String id;
  final String categorie;
  final DateTime dateAdded;
  final String priority;
  final int remember;
  final String title;

  const CheckCard({
    Key? key,
    required this.update,
    required this.id,
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

  void updateTask() {
    _fireStore.update('Check', widget.id, {"done": true});

    widget.update(1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        ListTile(
          onLongPress: () => updateTask(),
          title:
              Text(widget.title, style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text('Category: ' + widget.id),
        )
      ]),
    );
  }
}
