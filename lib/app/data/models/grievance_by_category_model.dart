import 'dart:convert';

class GrievancesByCategory {
  final int perselisihanHak;
  final int perselisihanKepentingan;
  final int perselisihanPemutusanHubunganKerja;
  final int perselisihanAntarSerikatBuruhDalamSatuPerusahaan;
  final int jamKerja;
  final int upah;

  GrievancesByCategory({
    required this.perselisihanHak,
    required this.perselisihanKepentingan,
    required this.perselisihanPemutusanHubunganKerja,
    required this.perselisihanAntarSerikatBuruhDalamSatuPerusahaan,
    required this.jamKerja,
    required this.upah,
  });

  GrievancesByCategory copyWith({
    int? perselisihanHak,
    int? perselisihanKepentingan,
    int? perselisihanPemutusanHubunganKerja,
    int? perselisihanAntarSerikatBuruhDalamSatuPerusahaan,
    int? jamKerja,
    int? upah,
  }) => GrievancesByCategory(
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

  factory GrievancesByCategory.fromRawJson(String str) =>
      GrievancesByCategory.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GrievancesByCategory.fromJson(Map<String, dynamic> json) =>
      GrievancesByCategory(
        perselisihanHak: json["Perselisihan Hak"],
        perselisihanKepentingan: json["Perselisihan Kepentingan"],
        perselisihanPemutusanHubunganKerja:
            json["Perselisihan Pemutusan Hubungan Kerja"],
        perselisihanAntarSerikatBuruhDalamSatuPerusahaan:
            json["Perselisihan Antar Serikat Buruh Dalam Satu Perusahaan"],
        jamKerja: json["Jam Kerja"],
        upah: json["Upah"],
      );

  Map<String, dynamic> toJson() => {
    "Perselisihan Hak": perselisihanHak,
    "Perselisihan Kepentingan": perselisihanKepentingan,
    "Perselisihan Pemutusan Hubungan Kerja": perselisihanPemutusanHubunganKerja,
    "Perselisihan Antar Serikat Buruh Dalam Satu Perusahaan":
        perselisihanAntarSerikatBuruhDalamSatuPerusahaan,
    "Jam Kerja": jamKerja,
    "Upah": upah,
  };
}
