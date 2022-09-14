import 'package:watrix/models/network/base_model.dart';

enum EntityType {
  movie,
  tv,
  people,
  all,
}

extension EntityTypeConverter on BaseModelType {
  EntityType getEntityType() {
    if (this == BaseModelType.movie) {
      return EntityType.movie;
    }
    if (this == BaseModelType.tv) {
      return EntityType.tv;
    }
    if (this == BaseModelType.people) {
      return EntityType.people;
    }
    throw UnimplementedError();
  }
}
