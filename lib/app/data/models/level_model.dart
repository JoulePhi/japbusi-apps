import 'dart:convert';

class Level {
  final int id;
  final int idFederation;
  final String name;
  final int level;

  Level({
    required this.id,
    required this.idFederation,
    required this.name,
    required this.level,
  });

  Level copyWith({int? id, int? idFederation, String? name, int? level}) =>
      Level(
        id: id ?? this.id,
        idFederation: idFederation ?? this.idFederation,
        name: name ?? this.name,
        level: level ?? this.level,
      );

  factory Level.fromRawJson(String str) => Level.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Level.fromJson(Map<String, dynamic> json) => Level(
    id: json["id"] is int ? json["id"] : int.parse(json["id"].toString()),
    idFederation: json["id_federation"] is int
        ? json["id_federation"]
        : int.parse(json["id_federation"].toString()),
    name: json["name"],
    level: json["level"] is int
        ? json["level"]
        : int.parse(json["level"].toString()),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "id_federation": idFederation,
    "name": name,
    "level": level,
  };
}
