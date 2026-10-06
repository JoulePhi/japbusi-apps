import 'dart:convert';

class VisitorStat {
  final DateTime visitDate;
  final String visitCount;

  VisitorStat({required this.visitDate, required this.visitCount});

  VisitorStat copyWith({DateTime? visitDate, String? visitCount}) =>
      VisitorStat(
        visitDate: visitDate ?? this.visitDate,
        visitCount: visitCount ?? this.visitCount,
      );

  factory VisitorStat.fromRawJson(String str) =>
      VisitorStat.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory VisitorStat.fromJson(Map<String, dynamic> json) => VisitorStat(
    visitDate: DateTime.parse(json["visit_date"]),
    visitCount: json["visit_count"],
  );

  Map<String, dynamic> toJson() => {
    "visit_date":
        "${visitDate.year.toString().padLeft(4, '0')}-${visitDate.month.toString().padLeft(2, '0')}-${visitDate.day.toString().padLeft(2, '0')}",
    "visit_count": visitCount,
  };
}
