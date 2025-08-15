import 'dart:convert';

class Federation {
  final String id;
  final String slug;
  final String idFederation;
  final String nameFederation;

  Federation({
    required this.id,
    required this.slug,
    required this.idFederation,
    required this.nameFederation,
  });

  Federation copyWith({
    String? id,
    String? slug,
    String? idFederation,
    String? nameFederation,
  }) => Federation(
    id: id ?? this.id,
    slug: slug ?? this.slug,
    idFederation: idFederation ?? this.idFederation,
    nameFederation: nameFederation ?? this.nameFederation,
  );

  factory Federation.fromRawJson(String str) =>
      Federation.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Federation.fromJson(Map<String, dynamic> json) => Federation(
    id: json["id"],
    slug: json["slug"],
    idFederation: json["id_federation"],
    nameFederation: json["name_federation"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "slug": slug,
    "id_federation": idFederation,
    "name_federation": nameFederation,
  };
}
