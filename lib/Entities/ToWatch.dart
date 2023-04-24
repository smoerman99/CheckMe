class ToWatch {
  String title;
  String url;
  int remember;
  bool done;

  ToWatch({this.title, this.url, this.remember, this.done});

  ToWatch.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        url = json['url'],
        remember = json['remember'],
        done = json['done'];

  Map<String, dynamic> toJson() =>
      {'title': title, 'url': url, 'remember': remember, 'done': done};
}
