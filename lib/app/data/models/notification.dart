import 'dart:convert';

class Notification {
  final String id;
  final String idData;
  final String userId;
  final String type;
  final String typeNotif;
  final String message;
  final String link;
  final String isRead;
  final DateTime createdAt;
  final DateTime updatedAt;

  Notification({
    required this.id,
    required this.idData,
    required this.userId,
    required this.type,
    required this.typeNotif,
    required this.message,
    required this.link,
    required this.isRead,
    required this.createdAt,
    required this.updatedAt,
  });

  Notification copyWith({
    String? id,
    String? idData,
    String? userId,
    String? type,
    String? typeNotif,
    String? message,
    String? link,
    String? isRead,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Notification(
    id: id ?? this.id,
    idData: idData ?? this.idData,
    userId: userId ?? this.userId,
    type: type ?? this.type,
    typeNotif: typeNotif ?? this.typeNotif,
    message: message ?? this.message,
    link: link ?? this.link,
    isRead: isRead ?? this.isRead,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );

  factory Notification.fromRawJson(String str) =>
      Notification.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
    id: json["id"],
    idData: json["id_data"],
    userId: json["user_id"],
    type: json["type"],
    typeNotif: json["type_notif"],
    message: json["message"],
    link: json["link"],
    isRead: json["is_read"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "id_data": idData,
    "user_id": userId,
    "type": type,
    "type_notif": typeNotif,
    "message": message,
    "link": link,
    "is_read": isRead,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
