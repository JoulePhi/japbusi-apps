import 'dart:convert';

class Article {
  final String title;
  final String author;
  final DateTime createdAt;
  final int id;
  final String thumbnail;
  final String? content;

  Article({
    required this.title,
    required this.author,
    required this.createdAt,
    required this.id,
    required this.thumbnail,
    this.content,
  });

  Article copyWith({
    String? title,
    String? author,
    DateTime? createdAt,
    int? id,
    String? thumbnail,
    String? content,
  }) => Article(
    title: title ?? this.title,
    author: author ?? this.author,
    createdAt: createdAt ?? this.createdAt,
    id: id ?? this.id,
    thumbnail: thumbnail ?? this.thumbnail,
    content: content ?? this.content,
  );

  factory Article.fromRawJson(String str) => Article.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Article.fromJson(Map<String, dynamic> json) => Article(
    title: json["title"],
    author: json["author"],
    createdAt: DateTime.parse(json["created_at"]),
    id: json["id"],
    thumbnail: json["thumbnail"],
    content: json["content"], // Optional field, can be null
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "author": author,
    "created_at": createdAt.toIso8601String(),
    "id": id,
    "thumbnail": thumbnail,
    "content": content, // Optional field, can be null
  };
}
