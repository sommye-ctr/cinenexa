import 'package:isar/isar.dart';
part 'search_history.g.dart';

@Collection()
class SearchHistory {
  Id? id;

  late String term;
}
