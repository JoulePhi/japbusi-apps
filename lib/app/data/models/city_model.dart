import 'dart:convert';

class City {
  final String id;
  final String provinceId;
  final dynamic provinceCode;
  final String province;
  final String type;
  final String name;
  final String postcode;

  City({
    required this.id,
    required this.provinceId,
    required this.provinceCode,
    required this.province,
    required this.type,
    required this.name,
    required this.postcode,
  });

  City copyWith({
    String? id,
    String? provinceId,
    dynamic provinceCode,
    String? province,
    String? type,
    String? name,
    String? postcode,
  }) => City(
    id: id ?? this.id,
    provinceId: provinceId ?? this.provinceId,
    provinceCode: provinceCode ?? this.provinceCode,
    province: province ?? this.province,
    type: type ?? this.type,
    name: name ?? this.name,
    postcode: postcode ?? this.postcode,
  );

  factory City.fromRawJson(String str) => City.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory City.fromJson(Map<String, dynamic> json) => City(
    id: json["id"],
    provinceId: json["province_id"],
    provinceCode: json["province_code"],
    province: json["province"],
    type: json["type"],
    name: json["name"],
    postcode: json["postcode"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "province_id": provinceId,
    "province_code": provinceCode,
    "province": province,
    "type": type,
    "name": name,
    "postcode": postcode,
  };
}
