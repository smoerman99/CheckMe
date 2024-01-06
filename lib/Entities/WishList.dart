import 'Enums/Priority.dart';

class WishList {
  String? title;
  Priorities? priority;
  int? remember;
  bool? done;

  WishList({this.title, this.priority, this.remember, this.done});

  WishList.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        priority = json['priority'],
        remember = json['remember'],
        done = json['done'];

  Map<String, dynamic> toJson() => {
        'title': title,
        'priority': priority,
        'remember': remember,
        'done': done
      };
}
