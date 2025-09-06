import 'package:hive/hive.dart';

part 'station.g.dart';

@HiveType(typeId: 2)
class Station {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String line;

  @HiveField(3)
  List<String> nearbyPlaces;

  @HiveField(4)
  bool isInterchange;

  Station({
    required this.id,
    required this.name,
    required this.line,
    required this.nearbyPlaces,
    required this.isInterchange,
  });
}