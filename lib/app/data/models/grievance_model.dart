import 'dart:convert';

import 'package:japbusi/app/data/models/reply_model.dart';
import 'package:japbusi/app/data/models/user_model.dart';

class Griveance {
  final int id;
  final int nomor;
  final int idFederation;
  final String title;
  final DateTime date;
  final String detail;
  final int status;
  final int step;
  final int stepDetail;
  final int level;
  final int subLevel;
  final User? user;
  final int companyCityId;
  final int readed;
  final String createdBy;
  final DateTime createdAt;
  final String updatedBy;
  final DateTime updatedAt;
  final String categoryName;
  final String levelName;
  final String subLevelName;
  final List<String> files;
  final List<Reply>? replies;

  Griveance({
    required this.id,
    required this.nomor,
    required this.idFederation,
    required this.title,
    required this.date,
    required this.detail,
    required this.status,
    required this.step,
    required this.stepDetail,
    required this.level,
    required this.subLevel,
    required this.user,
    required this.companyCityId,
    required this.readed,
    required this.createdBy,
    required this.createdAt,
    required this.updatedBy,
    required this.updatedAt,
    required this.categoryName,
    required this.files,
    required this.levelName,
    required this.subLevelName,
    required this.replies,
  });

  Griveance copyWith({
    int? id,
    int? nomor,
    int? idFederation,
    String? title,
    DateTime? date,
    String? detail,
    int? status,
    int? step,
    int? stepDetail,
    int? level,
    int? subLevel,
    User? user,
    int? companyCityId,
    int? readed,
    String? createdBy,
    DateTime? createdAt,
    String? updatedBy,
    DateTime? updatedAt,
    String? categoryName,
    List<String>? files,
    String? levelName,
    String? subLevelName,
    List<Reply>? replies,
  }) => Griveance(
    id: id ?? this.id,
    nomor: nomor ?? this.nomor,
    idFederation: idFederation ?? this.idFederation,
    title: title ?? this.title,
    date: date ?? this.date,
    detail: detail ?? this.detail,
    status: status ?? this.status,
    step: step ?? this.step,
    stepDetail: stepDetail ?? this.stepDetail,
    level: level ?? this.level,
    subLevel: subLevel ?? this.subLevel,
    user: user ?? this.user,
    companyCityId: companyCityId ?? this.companyCityId,
    readed: readed ?? this.readed,
    createdBy: createdBy ?? this.createdBy,
    createdAt: createdAt ?? this.createdAt,
    updatedBy: updatedBy ?? this.updatedBy,
    updatedAt: updatedAt ?? this.updatedAt,
    categoryName: categoryName ?? this.categoryName,
    files: files ?? this.files,
    levelName: levelName ?? this.levelName,
    subLevelName: subLevelName ?? this.subLevelName,
    replies: replies ?? this.replies,
  );

  factory Griveance.fromRawJson(String str) =>
      Griveance.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Griveance.fromJson(Map<String, dynamic> json) => Griveance(
    id: json["id"],
    nomor: json["nomor"],
    idFederation: json["id_federation"],
    title: json["title"] ?? '',
    date: DateTime.parse(json["date"]),
    detail: json["detail"] ?? '',
    status: json["status"],
    step: json["step"],
    stepDetail: json["step_detail"],
    level: json["level"],
    subLevel: json["sub_level"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    companyCityId: json["company_city_id"],
    readed: json["readed"],
    createdBy: json["created_by"] ?? '',
    createdAt: DateTime.parse(json["created_at"]),
    updatedBy: json["updated_by"] ?? '',
    updatedAt: DateTime.parse(json["updated_at"]),
    categoryName: json["category_name"] ?? '',
    levelName: json["level_name"] ?? '',
    subLevelName: json["sublevel_name"] ?? '',
    files: json["files"] == null
        ? <String>[]
        : List<String>.from(json["files"].map((x) => x ?? '')),
    replies: json["replies"] == null
        ? null
        : List<Reply>.from(json["replies"].map((x) => Reply.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nomor": nomor,
    "id_federation": idFederation,
    "title": title,
    "date":
        "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "detail": detail,
    "status": status,
    "step": step,
    "step_detail": stepDetail,
    "level": level,
    "sub_level": subLevel,
    "user": user?.toJson(),
    "company_city_id": companyCityId,
    "readed": readed,
    "created_by": createdBy,
    "created_at": createdAt.toIso8601String(),
    "updated_by": updatedBy,
    "updated_at": updatedAt.toIso8601String(),
    "category_name": categoryName,
    'level_name': levelName,
    'sublevel_name': subLevelName,
    "files": List<dynamic>.from(files.map((x) => x)),
    "replies": replies == null
        ? null
        : List<dynamic>.from(replies!.map((x) => x.toJson())),
  };
}
