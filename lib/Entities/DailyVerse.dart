class DailyVerse {
  String text;
  String book;
  String chapter;
  String beginVerse;
  String endVerse;

  DailyVerse(
      {this.text, this.book, this.chapter, this.beginVerse, this.endVerse});

  DailyVerse.fromJson(Map<String, dynamic> json)
      : text = json['text'],
        book = json['book'],
        chapter = json['chapter'],
        beginVerse = json['beginVerse'],
        endVerse = json['endVerse'];

  Map<String, dynamic> toJson() => {
        'text': text,
        'book': book,
        'chapter': chapter,
        'beginVerse': beginVerse,
        'endVerse': endVerse
      };
}
