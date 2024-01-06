import 'package:checkit/Entities/Category.dart';

import 'Enums/Priority.dart';

class Check {
  String? title;
  String? category;
  Priorities? priority;
  DateTime? dateTime;
  int? remember;
  bool? done;

  Check(
      {String? title,
      String? category,
      Priorities? priority,
      DateTime? dateTime,
      int? rembember,
      bool? done}) {
    this.title = title;
    this.category = category;
    this.priority = priority;
    this.dateTime = dateTime;
    this.remember = rembember;
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
}
