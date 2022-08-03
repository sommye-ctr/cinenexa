import 'package:isar/isar.dart';
part 'favorites.g.dart';

@Collection()
class Favorites {
  @Id()
  late int id;

  late String type;
  late String title;
  late String posterPath;
  late String backdropPath;
  late String overview;
  late String releaseDate;
  late List<int> genreIds;
  late double voteAverage;
}
