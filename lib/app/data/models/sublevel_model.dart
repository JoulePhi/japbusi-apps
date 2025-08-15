import 'dart:convert';

class SubLevel {
  final int id;
  final int levelParent;
  final int idFederation;
  final int? parentId;
  final String name;

  SubLevel({
    required this.id,
    required this.levelParent,
    required this.idFederation,
    required this.parentId,
    required this.name,
  });

  SubLevel copyWith({
    int? id,
    int? levelParent,
    int? idFederation,
    int? parentId,
    String? name,
  }) => SubLevel(
    id: id ?? this.id,
    levelParent: levelParent ?? this.levelParent,
    idFederation: idFederation ?? this.idFederation,
    parentId: parentId ?? this.parentId,
    name: name ?? this.name,
  );

  factory SubLevel.fromRawJson(String str) =>
      SubLevel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SubLevel.fromJson(Map<String, dynamic> json) => SubLevel(
    id: json["id"] is int ? json["id"] : int.parse(json["id"].toString()),
    levelParent: json["level_parent"] == null
        ? null
        : (json["level_parent"] is int
              ? json["level_parent"]
              : int.parse(json["level_parent"].toString())),
    idFederation: json["id_federation"] == null
        ? null
        : (json["id_federation"] is int
              ? json["id_federation"]
              : int.parse(json["id_federation"].toString())),
    parentId: json["parent_id"] == null
        ? null
        : (json["parent_id"] is int
              ? json["parent_id"]
              : int.parse(json["parent_id"].toString())),
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "level_parent": levelParent,
    "id_federation": idFederation,
    "parent_id": parentId,
    "name": name,
  };
}
