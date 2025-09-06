import 'package:cairometro/models/station.dart';
import 'package:hive/hive.dart';

part 'line.g.dart';

@HiveType(typeId: 0)
class Line {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  List<Station> stations;

  Line({
    required this.id,
    required this.name,
    required this.stations,
  });
}