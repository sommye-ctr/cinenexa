import 'package:isar/isar.dart';
part 'installed_extensions.g.dart';

@Collection()
class InstalledExtensions {
  Id? id;

  @Index()
  late String? stId;

  late String? name;
  late String? domainId;
  late String? endpoint;
  late DateTime? createdAt;
  late bool? providesMovie;
  late bool? providesShow;
  late bool? providesAnime;
  late String? description;
  late String? devEmail;
  late String? devName;
  late String? devUrl;
  late double? rating;
  late int? ratingCount;
  late String? icon;

  late int? providedRating;
}
