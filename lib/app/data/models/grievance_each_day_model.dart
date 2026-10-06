import 'dart:convert';

class GrievancesEachDay {
  final DateTime grievanceDate;
  final String grievanceCount;

  GrievancesEachDay({
    required this.grievanceDate,
    required this.grievanceCount,
  });

  GrievancesEachDay copyWith({
    DateTime? grievanceDate,
    String? grievanceCount,
  }) => GrievancesEachDay(
    grievanceDate: grievanceDate ?? this.grievanceDate,
    grievanceCount: grievanceCount ?? this.grievanceCount,
  );

  factory GrievancesEachDay.fromRawJson(String str) =>
      GrievancesEachDay.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GrievancesEachDay.fromJson(Map<String, dynamic> json) =>
      GrievancesEachDay(
        grievanceDate: DateTime.parse(json["grievance_date"]),
        grievanceCount: json["grievance_count"],
      );

  Map<String, dynamic> toJson() => {
    "grievance_date":
        "${grievanceDate.year.toString().padLeft(4, '0')}-${grievanceDate.month.toString().padLeft(2, '0')}-${grievanceDate.day.toString().padLeft(2, '0')}",
    "grievance_count": grievanceCount,
  };
}
