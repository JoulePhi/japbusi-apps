import 'dart:convert';

import 'package:japbusi/app/data/models/jam_kerja_model.dart';

class ProvincesByCategory {
  final JamKerja perselisihanHak;
  final JamKerja perselisihanKepentingan;
  final JamKerja perselisihanPemutusanHubunganKerja;
  final JamKerja perselisihanAntarSerikatBuruhDalamSatuPerusahaan;
  final JamKerja jamKerja;
  final JamKerja upah;

  ProvincesByCategory({
    required this.perselisihanHak,
    required this.perselisihanKepentingan,
    required this.perselisihanPemutusanHubunganKerja,
    required this.perselisihanAntarSerikatBuruhDalamSatuPerusahaan,
    required this.jamKerja,
    required this.upah,
  });

  ProvincesByCategory copyWith({
    JamKerja? perselisihanHak,
    JamKerja? perselisihanKepentingan,
    JamKerja? perselisihanPemutusanHubunganKerja,
    JamKerja? perselisihanAntarSerikatBuruhDalamSatuPerusahaan,
    JamKerja? jamKerja,
    JamKerja? upah,
  }) => ProvincesByCategory(
    perselisihanHak: perselisihanHak ?? this.perselisihanHak,
    perselisihanKepentingan:
        perselisihanKepentingan ?? this.perselisihanKepentingan,
    perselisihanPemutusanHubunganKerja:
        perselisihanPemutusanHubunganKerja ??
        this.perselisihanPemutusanHubunganKerja,
    perselisihanAntarSerikatBuruhDalamSatuPerusahaan:
        perselisihanAntarSerikatBuruhDalamSatuPerusahaan ??
        this.perselisihanAntarSerikatBuruhDalamSatuPerusahaan,
    jamKerja: jamKerja ?? this.jamKerja,
    upah: upah ?? this.upah,
  );

  factory ProvincesByCategory.fromRawJson(String str) =>
      ProvincesByCategory.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProvincesByCategory.fromJson(Map<String, dynamic> json) =>
      ProvincesByCategory(
        perselisihanHak: JamKerja.fromJson(json["Perselisihan Hak"]),
        perselisihanKepentingan: JamKerja.fromJson(
          json["Perselisihan Kepentingan"],
        ),
        perselisihanPemutusanHubunganKerja: JamKerja.fromJson(
          json["Perselisihan Pemutusan Hubungan Kerja"],
        ),
        perselisihanAntarSerikatBuruhDalamSatuPerusahaan: JamKerja.fromJson(
          json["Perselisihan Antar Serikat Buruh Dalam Satu Perusahaan"],
        ),
        jamKerja: JamKerja.fromJson(json["Jam Kerja"]),
        upah: JamKerja.fromJson(json["Upah"]),
      );

  Map<String, dynamic> toJson() => {
    "Perselisihan Hak": perselisihanHak.toJson(),
    "Perselisihan Kepentingan": perselisihanKepentingan.toJson(),
    "Perselisihan Pemutusan Hubungan Kerja": perselisihanPemutusanHubunganKerja
        .toJson(),
    "Perselisihan Antar Serikat Buruh Dalam Satu Perusahaan":
        perselisihanAntarSerikatBuruhDalamSatuPerusahaan.toJson(),
    "Jam Kerja": jamKerja.toJson(),
    "Upah": upah.toJson(),
  };
}
