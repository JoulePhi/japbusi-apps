import 'dart:convert';

class Carousel {
  final String id;
  final String judul;
  final String judulEn;
  final String deskripsi;
  final String deskripsiEn;
  final String foto;
  final String video;
  final String choice;
  final String color;
  final String orderNumber;

  Carousel({
    required this.id,
    required this.judul,
    required this.judulEn,
    required this.deskripsi,
    required this.deskripsiEn,
    required this.foto,
    required this.video,
    required this.choice,
    required this.color,
    required this.orderNumber,
  });

  Carousel copyWith({
    String? id,
    String? judul,
    String? judulEn,
    String? deskripsi,
    String? deskripsiEn,
    String? foto,
    String? video,
    String? choice,
    String? color,
    String? orderNumber,
  }) => Carousel(
    id: id ?? this.id,
    judul: judul ?? this.judul,
    judulEn: judulEn ?? this.judulEn,
    deskripsi: deskripsi ?? this.deskripsi,
    deskripsiEn: deskripsiEn ?? this.deskripsiEn,
    foto: foto ?? this.foto,
    video: video ?? this.video,
    choice: choice ?? this.choice,
    color: color ?? this.color,
    orderNumber: orderNumber ?? this.orderNumber,
  );

  factory Carousel.fromRawJson(String str) =>
      Carousel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Carousel.fromJson(Map<String, dynamic> json) => Carousel(
    id: json["id"],
    judul: json["judul"],
    judulEn: json["judul_en"],
    deskripsi: json["deskripsi"],
    deskripsiEn: json["deskripsi_en"],
    foto: json["foto"],
    video: json["video"],
    choice: json["choice"],
    color: json["color"],
    orderNumber: json["order_number"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "judul": judul,
    "judul_en": judulEn,
    "deskripsi": deskripsi,
    "deskripsi_en": deskripsiEn,
    "foto": foto,
    "video": video,
    "choice": choice,
    "color": color,
    "order_number": orderNumber,
  };
}
