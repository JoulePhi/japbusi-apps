import 'dart:convert';

class ArticleCategory {
  final String id;
  final String namaKategori;
  final DateTime createdAt;
  final DateTime updatedAt;

  ArticleCategory({
    required this.id,
    required this.namaKategori,
    required this.createdAt,
    required this.updatedAt,
  });

  ArticleCategory copyWith({
    String? id,
    dynamic idFederation,
    String? namaKategori,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => ArticleCategory(
    id: id ?? this.id,
    namaKategori: namaKategori ?? this.namaKategori,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );

  factory ArticleCategory.fromRawJson(String str) =>
      ArticleCategory.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ArticleCategory.fromJson(Map<String, dynamic> json) =>
      ArticleCategory(
        id: json["id"],
        namaKategori: json["nama_kategori"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nama_kategori": namaKategori,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
