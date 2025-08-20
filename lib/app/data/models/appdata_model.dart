import 'package:japbusi/app/data/models/carousel_model.dart';
import 'package:japbusi/app/data/models/city_model.dart';
import 'package:japbusi/app/data/models/federation_model.dart';
import 'package:japbusi/app/data/models/province_model.dart';

class AppData {
  final List<Province> provinces;
  final List<City> cities;
  final List<Federation> federations;
  final List<Carousel> carousels;

  AppData({
    required this.provinces,
    required this.cities,
    required this.federations,
    required this.carousels,
  });

  Map<String, dynamic> toJson() {
    return {
      'provinces': provinces.map((e) => e.toJson()).toList(),
      'cities': cities.map((e) => e.toJson()).toList(),
      'federations': federations.map((e) => e.toJson()).toList(),
      'carousels': carousels.map((e) => e.toJson()).toList(),
    };
  }
}
