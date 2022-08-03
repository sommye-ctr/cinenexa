import 'dart:convert';

class TvSeason {
  final int id;
  final String name;
  final String overview;
  final int seasonNumber;

  TvSeason({
    required this.id,
    required this.name,
    required this.overview,
    required this.seasonNumber,
  });

  TvSeason copyWith({
    int? id,
    String? name,
    String? overview,
    int? seasonNumber,
  }) {
    return TvSeason(
      id: id ?? this.id,
      name: name ?? this.name,
      overview: overview ?? this.overview,
      seasonNumber: seasonNumber ?? this.seasonNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'overview': overview,
      'season_number': seasonNumber,
    };
  }

  factory TvSeason.fromMap(Map<String, dynamic> map) {
    return TvSeason(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      overview: map['overview'] ?? '',
      seasonNumber: map['season_number']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory TvSeason.fromJson(String source) =>
      TvSeason.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TvSeason(id: $id, name: $name, overview: $overview, seasonNumber: $seasonNumber)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TvSeason &&
        other.id == id &&
        other.name == name &&
        other.overview == overview &&
        other.seasonNumber == seasonNumber;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        overview.hashCode ^
        seasonNumber.hashCode;
  }
}
