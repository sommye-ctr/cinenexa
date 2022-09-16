import 'package:isar/isar.dart';
import 'package:watrix/models/network/movie.dart';

class MovieTypeConverter extends TypeConverter<Movie?, String?> {
  const MovieTypeConverter();

  @override
  Movie? fromIsar(String? object) {
    return Movie.fromJson(object);
  }

  @override
  String? toIsar(Movie? object) {
    return object?.toJson();
  }
}
