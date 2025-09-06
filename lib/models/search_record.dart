import 'package:hive/hive.dart';

part 'search_record.g.dart';

@HiveType(typeId: 10)
class SearchRecord {
  @HiveField(0)
  String id;

  @HiveField(1)
  String query;

  @HiveField(2)
  String? matchedStationId;

  @HiveField(3)
  String? matchedStationName;

  @HiveField(4)
  bool hasMatch;

  @HiveField(5)
  DateTime timestamp;

  // New fields for ticket and route information
  @HiveField(6)
  String? fromStationId;

  @HiveField(7)
  String? fromStationName;

  @HiveField(8)
  String? toStationId;

  @HiveField(9)
  String? toStationName;

  @HiveField(10)
  int? ticketPrice;

  @HiveField(11)
  int? numStations;

  @HiveField(12)
  int? durationMinutes;

  @HiveField(13)
  List<String>? routePath;

  SearchRecord({
    required this.id,
    required this.query,
    required this.hasMatch,
    required this.timestamp,
    this.matchedStationId,
    this.matchedStationName,
    this.fromStationId,
    this.fromStationName,
    this.toStationId,
    this.toStationName,
    this.ticketPrice,
    this.numStations,
    this.durationMinutes,
    this.routePath,
  });
}



