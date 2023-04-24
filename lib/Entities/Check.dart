import 'Enums/Priority.dart';

class Check {
  String title;
  String project;
  Priorities priority;
  DateTime dateTime;
  int remember;
  bool done;

  Check({String title, bool done}) {
    this.title = title;
    this.done = done;
  }

  Check.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        done = json['done'];

  Map<String, dynamic> toJson() => {'title': title, 'done': done};
}
