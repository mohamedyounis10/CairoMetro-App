import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:hive/hive.dart';
import 'package:cairometro/models/station.dart';
import 'package:cairometro/models/line.dart';

class DataSeeder {
  static Future<void> seedFromAssetsIfEmpty() async {
    // 1️⃣ Open Hive boxes for stations and lines
    final stationsBox = await Hive.openBox<Station>('stations');
    final linesBox = await Hive.openBox<Line>('lines');

    // 2️⃣ If data already exists, skip seeding
    if (stationsBox.isNotEmpty && linesBox.isNotEmpty) {
      print('Hive already has data. Skipping seeding.');
      return;
    }

    // 3️⃣ Load JSON data from assets
    final String jsonString = await rootBundle.loadString('assets/data/lines.json');
    final Map<String, dynamic> jsonData = json.decode(jsonString);
    final List<dynamic> linesList = jsonData['lines'];

    // 4️⃣ Create a list of all stations
    final List<Station> allStations = [];
    for (var lineData in linesList) {
      final String lineId = lineData['id'].toString();
      final List<dynamic> stationsData = lineData['stations'];

      for (var stationData in stationsData) {
        final station = Station(
          id: stationData['id'].toString(),
          name: stationData['name'].toString(),
          line: lineId,
          nearbyPlaces: (stationData['nearbyPlaces'] as List?)?.cast<String>() ?? [],
          isInterchange: stationData['isInterchange'] ?? false,
        );
        allStations.add(station);
      }
    }

    // 5️⃣ Store all stations in Hive
    for (var station in allStations) {
      await stationsBox.put(station.id, station);
    }

    // 6️⃣ Create a map from station id -> Station object for easy lookup
    final Map<String, Station> stationById = {};
    for (var station in allStations) {
      stationById[station.id] = station;
    }

    // 7️⃣ Create a list of all lines with their stations
    final List<Line> allLines = [];
    for (var lineData in linesList) {
      final String lineId = lineData['id'].toString();
      final String lineName = lineData['name'].toString();
      final List<dynamic> stationsData = lineData['stations'];

      // Link stations to this line
      final List<Station> lineStations = [];
      for (var stationData in stationsData) {
        final String stationId = stationData['id'].toString();
        final Station station = stationById[stationId]!;
        lineStations.add(station);
      }

      final line = Line(
        id: lineId,
        name: lineName,
        stations: lineStations,
      );
      allLines.add(line);
    }

    // 8️⃣ Store all lines in Hive
    for (var line in allLines) {
      await linesBox.put(line.id, line);
    }

    print('Data seeding completed successfully!');
  }
}
