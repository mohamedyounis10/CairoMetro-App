import 'package:hive/hive.dart';
part 'route.g.dart';

@HiveType(typeId: 1)
class RouteModel {
  @HiveField(0)
  String startStation;

  @HiveField(1)
  String endStation;

  @HiveField(2)
  List<String> path;

  @HiveField(3)
  int durationMinutes;

  RouteModel({
    required this.startStation,
    required this.endStation,
    required this.path,
    required this.durationMinutes,
  });
}
