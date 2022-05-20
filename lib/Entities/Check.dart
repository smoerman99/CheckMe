class Check {
  String title;
  bool done;

  Check(String title, bool done) {
    this.title = title;
    this.done = done;
  }

  Check.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        done = json['done'];

  Map<String, dynamic> toJson() => {'title': title, 'done': done};
}
