// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:isar/isar.dart';

import 'package:watrix/models/local/show_history_season.dart';
import 'package:watrix/models/network/tv.dart';
import 'package:watrix/services/local/show_type_converter.dart';
import 'package:watrix/utils/date_time_formatter.dart';

part 'show_history.g.dart';

@Collection()
class ShowHistory {
  ShowHistory();

  @Id()
  late int id;

  @ShowTypeConverter()
  late Tv? show;

  var seasons = IsarLinks<ShowHistorySeason>();

  @Index()
  late DateTime? lastUpdatedAt;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'show': show?.toMap(),
      'seasons': seasons.map((x) => x.toMap()).toList(),
      'lastUpdatedAt': lastUpdatedAt,
    };
  }

  factory ShowHistory.fromMap(Map<String, dynamic> map) {
    Tv show = Tv.fromMap(map['show'] as Map<String, dynamic>);
    return ShowHistory()
      ..show = show
      ..lastUpdatedAt =
          DateTimeFormatter.parseDate(map['last_updated_at']) ?? null
      ..id = show.id
      ..seasons = (IsarLinks()
        ..addAll(
          List<ShowHistorySeason>.from(
            (map['seasons'] as List).map<ShowHistorySeason>(
              (x) => ShowHistorySeason.fromMap(x as Map<String, dynamic>),
            ),
          ),
        ));
  }

  String toJson() => json.encode(toMap());

  factory ShowHistory.fromJson(String source) =>
      ShowHistory.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return "id:$id lastUpdated:${lastUpdatedAt.toString()}  show:${show.toString()} seasons:${seasons.toString()}";
  }
}
