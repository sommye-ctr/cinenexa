import 'package:isar/isar.dart';
import 'package:watrix/models/network/tv.dart';

class ShowTypeConverter extends TypeConverter<Tv?, String?> {
  const ShowTypeConverter();

  @override
  Tv? fromIsar(String? object) {
    return Tv.fromJson(object);
  }

  @override
  String? toIsar(Tv? object) {
    return object?.toJson();
  }
}
