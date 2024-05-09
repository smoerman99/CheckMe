class DailyVerse {
  String? id;
  String? bookId;
  String? reference;
  String? content;

  DailyVerse({this.id, this.bookId, this.reference, this.content});

  DailyVerse.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        bookId = json['bookId'],
        reference = json['reference'],
        content = json['content'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'bookId': bookId,
        'reference': reference,
        'content': content,
      };
}
