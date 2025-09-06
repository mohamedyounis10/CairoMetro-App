import 'package:hive/hive.dart';
import 'search_record.dart';
part 'app_user.g.dart';

@HiveType(typeId: 11)
class AppUser {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  List<SearchRecord> history;

  AppUser({
    required this.id,
    required this.name,
    required this.history,
  });
}





