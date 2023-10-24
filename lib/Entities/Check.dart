import 'Enums/Priority.dart';

class Check {
  String title;
  String project;
  Priorities priority;
  DateTime dateTime;
  int remember;
  bool done;

  Check(
      {String title,
      String project,
      Priorities priority,
      DateTime dateTime,
      int rembember,
      bool done}) {
    this.title = title;
    this.project = project;
    this.priority = priority;
    this.dateTime = dateTime;
    this.remember = rembember;
    this.done = done;
  }

  Check.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        project = json['project'],
        priority = json['priority'],
        dateTime = json['dateTime'],
        remember = json['remember'],
        done = json['done'];

  Map<String, dynamic> toJson() => {
        'title': title,
        'project': project,
        'priority': priority,
        'dateTime': dateTime,
        'remember': remember,
        'done': done
      };
}
