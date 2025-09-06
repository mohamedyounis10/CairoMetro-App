import 'package:cairometro/features/home/cubit/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../../models/line.dart';
import '../../../models/station.dart';
import '../../../models/search_record.dart';
import '../../../models/app_user.dart';

class HomeCubit extends Cubit<HomeState>{
  HomeCubit():super(InitState());

  // Variables
  int selectedIndex = 0;
  Station? from;
  Station? to;
  List<Station> path = [];
  int numStations = 0;
  int durationMinutes = 0;
  
  // Search variables
  String searchQuery = '';
  List<Station> searchResults = [];
  
  // User / history
  AppUser? currentUser;

  void changePage(int index){
    selectedIndex = index;
    emit(ChangePage());
  }

  void mapPage(){
    emit(MapPage());
  }

  void ticketPage(){
    emit(TicketPage());
  }

  void nextPage(){
    emit(NextPage());
  }

  void emptyFiled(){
    emit(EmptyFiled());
  }

  Future<void> initUser() async {
    final userBox = await Hive.openBox<AppUser>('user');
    if (userBox.isEmpty) {
      final newUser = AppUser(id: 'local', name: 'User', history: []);
      await userBox.put('local', newUser);
    }
    currentUser = userBox.get('local');
  }

  // Start station
  void setFrom(Station? station) {
    from = station;
    to = null; // reset TO when FROM changes
    emit(StationsUpdated()); // emit state to update UI
    _recalculate();
  }

  // End station
  void setTo(Station? station) {
    to = station;
    emit(StationsUpdated()); // emit state to update UI
    _recalculate();
  }

  void _recalculate() {
    if (from == null || to == null) return;

    final stationsBox = Hive.box<Station>('stations');
    final linesBox = Hive.box<Line>('lines');

    final stations = stationsBox.values.toList();
    final stationById = {for (final s in stations) s.id: s};

    final Map<String, Set<String>> graph = {
      for (final s in stations) s.id: <String>{},
    };
    for (final line in linesBox.values) {
      final list = line.stations;
      for (int i = 0; i < list.length - 1; i++) {
        final a = list[i].id;
        final b = list[i + 1].id;
        graph[a]!.add(b);
        graph[b]!.add(a);
      }
    }

    final Map<String, List<Station>> byName = {};
    for (final s in stations) {
      byName.putIfAbsent(s.name, () => []).add(s);
    }
    for (final sameName in byName.values) {
      if (sameName.length < 2) continue;
      for (int i = 0; i < sameName.length; i++) {
        for (int j = i + 1; j < sameName.length; j++) {
          final a = sameName[i].id;
          final b = sameName[j].id;
          graph[a]!.add(b);
          graph[b]!.add(a);
        }
      }
    }

    // BFS shortest path
    final idsPath = _shortestPathBfs(
      startId: from!.id,
      endId: to!.id,
      neighbors: (id) => graph[id]?.toList() ?? const <String>[],
    );

    path = idsPath.map((id) => stationById[id]!).toList();
    numStations = path.isNotEmpty ? path.length - 1 : 0;
    const minutesPerHop = 2;
    durationMinutes = numStations * minutesPerHop;

    emit(TicketUpdated());
  }

  List<String> _shortestPathBfs({
    required String startId,
    required String endId,
    required List<String> Function(String) neighbors,
  }) {
    if (startId == endId) return [startId];

    final queue = <String>[startId];
    final visited = <String>{startId};
    final parent = <String, String>{};
    int head = 0;

    while (head < queue.length) {
      final current = queue[head++];
      for (final n in neighbors(current)) {
        if (visited.contains(n)) continue;
        visited.add(n);
        parent[n] = current;
        if (n == endId) return _reconstruct(parent, startId, endId);
        queue.add(n);
      }
    }
    return [];
  }

  List<String> _reconstruct(Map<String, String> parent, String startId, String endId) {
    final path = <String>[endId];
    var cur = endId;
    while (cur != startId) {
      final p = parent[cur];
      if (p == null) return [];
      path.add(p);
      cur = p;
    }
    return path.reversed.toList();
  }

  String get ticketImage {
    if (numStations <= 9) return 'assets/images/Cairo_Metro_ticket_1.webp';
    if (numStations <= 16) return 'assets/images/Cairo_Metro_ticket_2.png';
    if (numStations <= 23) return 'assets/images/Cairo_Metro_ticket_3.png';
    return 'assets/images/Cairo_Metro_ticket_4.png';
  }

  int get ticketPrice {
    if (numStations <= 9) return 8;
    if (numStations <= 16) return 10;
    if (numStations <= 23) return 15;
    return 20;
  }

  // Search functionality
  void searchStations(String query) {
    searchQuery = query.toLowerCase().trim();
    
    if (searchQuery.isEmpty) {
      searchResults = [];
      emit(SearchResultsUpdated());
      return;
    }

    final stationsBox = Hive.box<Station>('stations');
    final allStations = stationsBox.values.toList();
    
    // Search only in nearby places (not by station name)
    searchResults = allStations.where((station) {
      for (final place in station.nearbyPlaces) {
        if (place.toLowerCase().contains(searchQuery)) {
          return true;
        }
      }
      return false;
    }).toList();
    
    // Sort by station name for stable display
    searchResults.sort((a, b) => a.name.compareTo(b.name));
    
    emit(SearchResultsUpdated());
  }

  void clearSearch() {
    searchQuery = '';
    searchResults = [];
    emit(SearchResultsUpdated());
  }

  Future<void> saveSearchResult({required String query, Station? matched}) async {
    final userBox = await Hive.openBox<AppUser>('user');
    currentUser ??= userBox.get('local');
    if (currentUser == null) return;

    // Calculate ticket information if we have both from and to stations
    int? ticketPrice;
    int? numStations;
    int? durationMinutes;
    List<String>? routePath;

    if (from != null && to != null) {
      // Recalculate to get current path and price
      _recalculate();
      ticketPrice = this.ticketPrice;
      numStations = this.numStations;
      durationMinutes = this.durationMinutes;
      routePath = path.map((s) => s.id).toList();
    }

    final record = SearchRecord(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      query: query,
      hasMatch: matched != null,
      timestamp: DateTime.now(),
      matchedStationId: matched?.id,
      matchedStationName: matched?.name,
      fromStationId: from?.id,
      fromStationName: from?.name,
      toStationId: to?.id,
      toStationName: to?.name,
      ticketPrice: ticketPrice,
      numStations: numStations,
      durationMinutes: durationMinutes,
      routePath: routePath,
    );

    final updated = AppUser(
      id: currentUser!.id,
      name: currentUser!.name,
      history: [record, ...currentUser!.history].take(50).toList(),
    );

    await userBox.put(updated.id, updated);
    currentUser = updated;
  }

  Future<void> clearHistory() async {
    final userBox = await Hive.openBox<AppUser>('user');
    currentUser ??= userBox.get('local');
    if (currentUser == null) return;
    final updated = AppUser(id: currentUser!.id, name: currentUser!.name, history: []);
    await userBox.put(updated.id, updated);
    currentUser = updated;
    emit(SearchResultsUpdated());
  }

  Future<void> removeHistoryItem(String recordId) async {
    final userBox = await Hive.openBox<AppUser>('user');
    currentUser ??= userBox.get('local');
    if (currentUser == null) return;
    final updated = AppUser(
      id: currentUser!.id,
      name: currentUser!.name,
      history: currentUser!.history.where((r) => r.id != recordId).toList(),
    );
    await userBox.put(updated.id, updated);
    currentUser = updated;
    emit(SearchResultsUpdated());
  }
}