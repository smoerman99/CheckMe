import 'package:cloud_firestore/cloud_firestore.dart';

class Check {
  String? title;
  String? category;
  String? priority;
  DateTime? dateTime;
  int? remember;
  bool? done;

  Check(
      {String? title,
      String? category,
      String? priority,
      DateTime? dateTime,
      int? remember,
      bool? done}) {
    this.title = title;
    this.category = category;
    this.priority = priority;
    this.dateTime = dateTime;
    this.remember = remember;
    this.done = done;
  }

  Check.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        category = json['category'],
        priority = json['priority'],
        dateTime = json['dateTime'],
        remember = json['remember'],
        done = json['done'];

  Map<String, dynamic> toJson() => {
        'title': title,
        'category': category,
        'priority': priority,
        'dateTime': dateTime,
        'remember': remember,
        'done': done
      };

  factory Check.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Check(
      title: data?['title'],
      category: data?['category'],
      priority: data?['priority'],
      dateTime: data?['dateTime'],
      remember: data?['remember'],
      done: data?['done'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (title != null) "title": title,
      if (category != null) "category": category,
      if (priority != null) "priority": priority,
      if (dateTime != null) "dateTime": dateTime,
      if (remember != null) "remember": remember,
      if (done != null) "done": done,
    };
  }
}
