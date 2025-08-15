import 'package:japbusi/app/data/models/level_model.dart';
import 'package:japbusi/app/data/models/sublevel_model.dart';

class DpcResponse {
  Level level;
  List<SubLevel> subLevels;

  DpcResponse({required this.level, required this.subLevels});

  factory DpcResponse.fromJson(Map<String, dynamic> json) => DpcResponse(
    level: Level.fromJson(json['level']),
    subLevels: List<SubLevel>.from(
      json['sub_levels'].map((x) => SubLevel.fromJson(x)),
    ),
  );
}
