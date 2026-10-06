import 'dart:convert';

class JamKerja {
  final String provinceName;
  final String totalGrievances;

  JamKerja({required this.provinceName, required this.totalGrievances});

  JamKerja copyWith({String? provinceName, String? totalGrievances}) =>
      JamKerja(
        provinceName: provinceName ?? this.provinceName,
        totalGrievances: totalGrievances ?? this.totalGrievances,
      );

  factory JamKerja.fromRawJson(String str) =>
      JamKerja.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory JamKerja.fromJson(Map<String, dynamic> json) => JamKerja(
    provinceName: json["province_name"],
    totalGrievances: json["total_grievances"],
  );

  Map<String, dynamic> toJson() => {
    "province_name": provinceName,
    "total_grievances": totalGrievances,
  };
}
