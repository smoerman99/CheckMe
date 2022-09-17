class User {
  String name;
  String mood;
  int tasksEverCompleted;

  User({
    this.name,
    this.mood,
    this.tasksEverCompleted,
  });

  User.sampleUserData(String name, String mood, int tasksEverCompleted) {
    this.name = name;
    this.mood = mood;
    this.tasksEverCompleted = tasksEverCompleted;
  }

  User.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        mood = json['mood'],
        tasksEverCompleted = json['tasksEverCompleted'];

  Map<String, dynamic> toJson() =>
      {'name': name, 'mood': mood, 'tasksEverCompleted': tasksEverCompleted};
}
