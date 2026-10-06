import 'dart:convert';

class Feedback {
  final String id;
  final String replyId;
  final String description;
  final String createdBy;
  final DateTime createdAt;
  final List<FileElement> files;

  Feedback({
    required this.id,
    required this.replyId,
    required this.description,
    required this.createdBy,
    required this.createdAt,
    required this.files,
  });

  Feedback copyWith({
    String? id,
    String? replyId,
    String? description,
    String? createdBy,
    DateTime? createdAt,
    List<FileElement>? files,
  }) => Feedback(
    id: id ?? this.id,
    replyId: replyId ?? this.replyId,
    description: description ?? this.description,
    createdBy: createdBy ?? this.createdBy,
    createdAt: createdAt ?? this.createdAt,
    files: files ?? this.files,
  );

  factory Feedback.fromRawJson(String str) =>
      Feedback.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Feedback.fromJson(Map<String, dynamic> json) => Feedback(
    id: json["id"],
    replyId: json["reply_id"],
    description: json["description"],
    createdBy: json["created_by"],
    createdAt: DateTime.parse(json["created_at"]),
    files: List<FileElement>.from(
      json["files"].map((x) => FileElement.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "reply_id": replyId,
    "description": description,
    "created_by": createdBy,
    "created_at": createdAt.toIso8601String(),
    "files": List<dynamic>.from(files.map((x) => x.toJson())),
  };
}

class FileElement {
  final String id;
  final String rfId;
  final String file;
  final String url;

  FileElement({
    required this.id,
    required this.rfId,
    required this.file,
    required this.url,
  });

  FileElement copyWith({String? id, String? rfId, String? file, String? url}) =>
      FileElement(
        id: id ?? this.id,
        rfId: rfId ?? this.rfId,
        file: file ?? this.file,
        url: url ?? this.url,
      );

  factory FileElement.fromRawJson(String str) =>
      FileElement.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FileElement.fromJson(Map<String, dynamic> json) => FileElement(
    id: json["id"],
    rfId: json["rf_id"],
    file: json["file"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "rf_id": rfId,
    "file": file,
    "url": url,
  };
}
