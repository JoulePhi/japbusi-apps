import 'dart:convert';

import 'package:japbusi/app/data/models/user_model.dart';

class Reply {
  final String id;
  final String grievanceId;
  final String titleReply;
  final String tagIdReply;
  final String answer;
  final String read;
  final String worker;
  final String step;
  final String stepDetail;
  final String feedback;
  final String createdBy;
  final DateTime createdAt;
  final String updatedBy;
  final DateTime updatedAt;
  final String rgid;
  final String uid;
  final String roleId;
  final String name;
  final String roleName;
  final String feedbackCount;
  final dynamic rd;
  final dynamic rfid;
  final String feedbackFileCount;

  final User? user;

  Reply({
    required this.id,
    required this.grievanceId,
    required this.titleReply,
    required this.tagIdReply,
    required this.answer,
    required this.read,
    required this.worker,
    required this.step,
    required this.stepDetail,
    required this.feedback,
    required this.createdBy,
    required this.createdAt,
    required this.updatedBy,
    required this.updatedAt,
    required this.rgid,
    required this.uid,
    required this.roleId,
    required this.name,
    required this.roleName,
    required this.feedbackCount,
    required this.rd,
    required this.rfid,
    required this.feedbackFileCount,
    required this.user,
  });

  Reply copyWith({
    String? id,
    String? grievanceId,
    String? titleReply,
    String? tagIdReply,
    String? answer,
    String? read,
    String? worker,
    String? step,
    String? stepDetail,
    String? feedback,
    String? createdBy,
    DateTime? createdAt,
    String? updatedBy,
    DateTime? updatedAt,
    String? rgid,
    String? uid,
    String? roleId,
    String? name,
    String? roleName,
    String? feedbackCount,
    dynamic rd,
    dynamic rfid,
    String? feedbackFileCount,
  }) => Reply(
    id: id ?? this.id,
    grievanceId: grievanceId ?? this.grievanceId,
    titleReply: titleReply ?? this.titleReply,
    tagIdReply: tagIdReply ?? this.tagIdReply,
    answer: answer ?? this.answer,
    read: read ?? this.read,
    worker: worker ?? this.worker,
    step: step ?? this.step,
    stepDetail: stepDetail ?? this.stepDetail,
    feedback: feedback ?? this.feedback,
    createdBy: createdBy ?? this.createdBy,
    createdAt: createdAt ?? this.createdAt,
    updatedBy: updatedBy ?? this.updatedBy,
    updatedAt: updatedAt ?? this.updatedAt,
    rgid: rgid ?? this.rgid,
    uid: uid ?? this.uid,
    roleId: roleId ?? this.roleId,
    name: name ?? this.name,
    roleName: roleName ?? this.roleName,
    feedbackCount: feedbackCount ?? this.feedbackCount,
    rd: rd ?? this.rd,
    rfid: rfid ?? this.rfid,
    feedbackFileCount: feedbackFileCount ?? this.feedbackFileCount,
    user: user ?? user,
  );

  factory Reply.fromRawJson(String str) => Reply.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Reply.fromJson(Map<String, dynamic> json) => Reply(
    id: json["id"],
    grievanceId: json["grievance_id"],
    titleReply: json["title_reply"],
    tagIdReply: json["tag_id_reply"],
    answer: json["answer"],
    read: json["read"],
    worker: json["worker"],
    step: json["step"],
    stepDetail: json["step_detail"],
    feedback: json["feedback"],
    createdBy: json["created_by"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedBy: json["updated_by"],
    updatedAt: DateTime.parse(json["updated_at"]),
    rgid: json["rgid"],
    uid: json["uid"],
    roleId: json["roleId"],
    name: json["name"],
    roleName: json["role_name"],
    feedbackCount: json["feedback_count"],
    rd: json["rd"],
    rfid: json["rfid"],
    feedbackFileCount: json["feedback_file_count"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "grievance_id": grievanceId,
    "title_reply": titleReply,
    "tag_id_reply": tagIdReply,
    "answer": answer,
    "read": read,
    "worker": worker,
    "step": step,
    "step_detail": stepDetail,
    "feedback": feedback,
    "created_by": createdBy,
    "created_at": createdAt.toIso8601String(),
    "updated_by": updatedBy,
    "updated_at": updatedAt.toIso8601String(),
    "rgid": rgid,
    "uid": uid,
    "roleId": roleId,
    "name": name,
    "role_name": roleName,
    "feedback_count": feedbackCount,
    "rd": rd,
    "rfid": rfid,
    "feedback_file_count": feedbackFileCount,
    "user": user?.toJson(),
  };
}
