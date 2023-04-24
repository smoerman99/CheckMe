class Settings {
  String name;
  String mood;
  int tasksEverCompleted;

  Settings({
    this.name,
    this.mood,
    this.tasksEverCompleted,
  });

  Settings.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        mood = json['mood'],
        tasksEverCompleted = json['tasksEverCompleted'];

  Map<String, dynamic> toJson() =>
      {'name': name, 'mood': mood, 'tasksEverCompleted': tasksEverCompleted};
}
