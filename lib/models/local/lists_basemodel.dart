import 'package:isar/isar.dart';

import '../network/base_model.dart';
part 'lists_basemodel.g.dart';

@embedded
class ListsBaseModel {
  int? id;

  @enumerated
  late BaseModelType type;

  String? title;

  String? posterPath;
  String? backdropPath;
  String? overview;
  String? releaseDate;
  List<int>? genreIds;
  double? voteAverage;
}

extension BaseModelConverter on ListsBaseModel {
  BaseModel getBaseModel() {
    return BaseModel(
      backdropPath: backdropPath,
      genreIds: genreIds,
      id: id,
      overview: overview,
      posterPath: posterPath,
      releaseDate: releaseDate,
      title: title,
      type: type,
      voteAverage: voteAverage,
    );
  }
}

extension RevBaseModelConverter on BaseModel {
  ListsBaseModel getListBaseModel() {
    return ListsBaseModel()
      ..backdropPath = backdropPath
      ..genreIds = genreIds
      ..id = id
      ..overview = overview
      ..posterPath = posterPath
      ..releaseDate = releaseDate
      ..title = title
      ..type = type ?? BaseModelType.movie
      ..voteAverage = voteAverage;
  }
}
