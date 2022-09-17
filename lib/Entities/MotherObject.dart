import 'package:checkit/Entities/CheckList.dart';

class MotherObject {
  String name;
  String mood;
  int tasksEverCompleted;
  CheckList checkList;

  MotherObject({this.name, this.mood, this.tasksEverCompleted, this.checkList});

  MotherObject.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        mood = json['mood'],
        tasksEverCompleted = json['tasksEverCompleted'],
        checkList = json['checkList'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'mood': mood,
        'tasksEverCompleted': tasksEverCompleted,
        'checkList': checkList
      };
}
