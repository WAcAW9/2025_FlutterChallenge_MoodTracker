class Article {
  final String id; // 문서 ID 추가
  final String mood;
  final String description;
  final int date;

  Article({
    required this.id,
    required this.mood,
    required this.description,
    required this.date,
  });

  Map<String, dynamic> toJson() {
    return {"mood": mood, "description": description, "date": date};
  }

  factory Article.fromJson(String id, Map<String, dynamic> json) {
    return Article(
      id: id,
      mood: json['mood'] as String,
      description: json['description'] as String,
      date: json['date'] as int,
    );
  }
}
