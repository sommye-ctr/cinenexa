import 'package:isar/isar.dart';
part 'search_history.g.dart';

@Collection()
class SearchHistory {
  @Id()
  int id = Isar.autoIncrement;

  late String term;
}
