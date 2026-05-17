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
  State<CheckCard> createState() => _CheckCardState();
}

class _CheckCardState extends State<CheckCard> {
  final FireStore _fireStore = FireStore();

  void updateTask() {
    _fireStore.update('Check', widget.id, {"done": true});

    widget.update(1);
  }

  Color getPriorityColor() {
    switch (widget.priority.toLowerCase()) {
      case 'high':
        return Colors.red;
      case 'medium':
        return Colors.orange;
      default:
        return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 5,
          ),

          // CHECK BUTTON
          leading: GestureDetector(
            onTap: updateTask,
            child: Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                border: Border.all(
                  color: getPriorityColor(),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Icon(
                Icons.check,
                size: 18,
                color: Colors.grey,
              ),
            ),
          ),

          // TITLE + CATEGORY
          title: Text(
            widget.title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),

          subtitle: Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Row(
              children: [
                const Icon(
                  Icons.folder_outlined,
                  size: 16,
                  color: Colors.grey,
                ),
                const SizedBox(width: 4),
                Text(
                  widget.categorie,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          // PRIORITY TAG
          trailing: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: getPriorityColor().withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              widget.priority,
              style: TextStyle(
                color: getPriorityColor(),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
