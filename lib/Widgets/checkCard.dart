import 'package:checkit/Firebase/Firestore.dart';
import 'package:flutter/material.dart';

class CheckCard extends StatefulWidget {
  final ValueChanged<int> update;
  final String id;
  final String title;
  final String categorie;
  final String priority;
  final DateTime dateAdded;
  final int remember;

  const CheckCard({
    Key? key,
    required this.update,
    required this.id,
    required this.title,
    required this.categorie,
    required this.priority,
    required this.dateAdded,
    required this.remember,
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
          title: Text(
            widget.title + '' + widget.priority,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text('Category: ' + widget.categorie),
        )
      ]),
    );
  }
}
