import 'dart:convert';

class Province {
  final String id;
  final String provinceId;
  final String name;

  Province({required this.id, required this.provinceId, required this.name});

  Province copyWith({String? id, String? provinceId, String? name}) => Province(
    id: id ?? this.id,
    provinceId: provinceId ?? this.provinceId,
    name: name ?? this.name,
  );

  factory Province.fromRawJson(String str) =>
      Province.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Province.fromJson(Map<String, dynamic> json) => Province(
    id: json["id"],
    provinceId: json["province_id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "province_id": provinceId,
    "name": name,
  };
}
