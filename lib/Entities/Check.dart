import 'package:cloud_firestore/cloud_firestore.dart';

class Check {
  String? id;
  String? title;
  String? category;
  String? priority;
  DateTime? dateTime;
  int? remember;
  bool? done;
  String? userid;

  Check(
      {String? id,
      String? title,
      String? category,
      String? priority,
      DateTime? dateTime,
      int? remember,
      bool? done,
      String? userid}) {
    this.id = id;
    this.title = title;
    this.category = category;
    this.priority = priority;
    this.dateTime = dateTime;
    this.remember = remember;
    this.done = done;
    this.userid = userid;
  }

  Check.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        category = json['category'],
        priority = json['priority'],
        dateTime = json['dateTime'],
        remember = json['remember'],
        done = json['done'],
        userid = json['userid'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'category': category,
        'priority': priority,
        'dateTime': dateTime,
        'remember': remember,
        'done': done,
        'userid': userid
      };

  factory Check.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Check(
        id: data?['id'],
        title: data?['title'],
        category: data?['category'],
        priority: data?['priority'],
        dateTime: data?['dateTime'],
        remember: data?['remember'],
        done: data?['done'],
        userid: data?['userid']);
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (id != null) "id": id,
      if (title != null) "title": title,
      if (category != null) "category": category,
      if (priority != null) "priority": priority,
      if (dateTime != null) "dateTime": dateTime,
      if (remember != null) "remember": remember,
      if (done != null) "done": done,
      if (userid != null) "userid": userid,
    };
  }
}
