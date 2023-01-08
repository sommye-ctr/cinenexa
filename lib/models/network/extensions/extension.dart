// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:cinenexa/models/local/installed_extensions.dart';

class Extension {
  final String id;
  final String name;
  final String domainId;
  final String endpoint;
  final DateTime createdAt;
  final bool providesMovie;
  final bool providesShow;
  final bool providesAnime;
  final String? description;
  final String? devEmail;
  final String? devName;
  final String? devUrl;
  double? rating;
  int? ratingCount;
  String? icon;
  Extension({
    required this.id,
    required this.name,
    required this.domainId,
    required this.endpoint,
    required this.createdAt,
    required this.providesMovie,
    required this.providesShow,
    required this.providesAnime,
    this.description,
    this.devEmail,
    this.devName,
    this.devUrl,
    this.rating,
    this.ratingCount,
  }) : icon = Supabase.instance.client.storage
            .from('extensions-icons')
            .getPublicUrl("$id.jpg");

  Extension copyWith({
    String? id,
    String? name,
    String? domainId,
    String? endpoint,
    DateTime? createdAt,
    bool? providesMovie,
    bool? providesShow,
    bool? providesAnime,
    String? description,
    String? devEmail,
    String? devName,
    String? devUrl,
    double? rating,
    int? ratingCount,
  }) {
    return Extension(
      id: id ?? this.id,
      name: name ?? this.name,
      domainId: domainId ?? this.domainId,
      endpoint: endpoint ?? this.endpoint,
      createdAt: createdAt ?? this.createdAt,
      providesMovie: providesMovie ?? this.providesMovie,
      providesShow: providesShow ?? this.providesShow,
      providesAnime: providesAnime ?? this.providesAnime,
      description: description ?? this.description,
      devEmail: devEmail ?? this.devEmail,
      devName: devName ?? this.devName,
      devUrl: devUrl ?? this.devUrl,
      rating: rating ?? this.rating,
      ratingCount: ratingCount ?? this.ratingCount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'domain_id': domainId,
      'endpoint': endpoint,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'providesMovie': providesMovie,
      'providesShow': providesShow,
      'providesAnime': providesAnime,
      'description': description,
      'devEmail': devEmail,
      'devName': devName,
      'devUrl': devUrl,
      'rating': rating,
      'ratingCount': ratingCount,
      'icon': icon,
    };
  }

  factory Extension.fromMap(Map<String, dynamic> map) {
    return Extension(
      id: map['id'] as String,
      name: map['name'] as String,
      domainId: map['domain_id'] as String,
      endpoint: map['endpoint'] as String,
      createdAt: DateTime.parse(map['created_at']),
      providesMovie: map['provides_movie'] as bool,
      providesShow: map['provides_show'] as bool,
      providesAnime: map['provides_anime'] as bool,
      description:
          map['description'] != null ? map['description'] as String : null,
      devEmail: map['dev_email'] != null ? map['dev_email'] as String : null,
      devName: map['dev_name'] != null ? map['dev_name'] as String : null,
      devUrl: map['dev_url'] != null ? map['dev_url'] as String : null,
      rating: map['rating'] != null ? (map['rating'] as num).toDouble() : null,
      ratingCount:
          map['rating_count'] != null ? map['rating_count'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Extension.fromJson(String source) =>
      Extension.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Extension(id: $id, name: $name, domainId: $domainId, endpoint: $endpoint, createdAt: $createdAt, providesMovie: $providesMovie, providesShow: $providesShow, providesAnime: $providesAnime, description: $description, devEmail: $devEmail, devName: $devName, devUrl: $devUrl, rating: $rating, ratingCount: $ratingCount, icon: $icon)';
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        domainId.hashCode ^
        endpoint.hashCode ^
        createdAt.hashCode ^
        providesMovie.hashCode ^
        providesShow.hashCode ^
        providesAnime.hashCode ^
        description.hashCode ^
        devEmail.hashCode ^
        devName.hashCode ^
        devUrl.hashCode ^
        rating.hashCode ^
        ratingCount.hashCode ^
        icon.hashCode;
  }

  @override
  bool operator ==(covariant Extension other) {
    if (identical(this, other)) return true;

    return other.id == id;
  }
}

extension ExtensionConverter on Extension {
  InstalledExtensions getInstalled({int? providedRating}) {
    return InstalledExtensions()
      ..createdAt = this.createdAt
      ..description = this.description
      ..devEmail = this.devEmail
      ..devName = this.devName
      ..devUrl = this.devUrl
      ..domainId = this.domainId
      ..endpoint = this.endpoint
      ..icon = this.icon
      ..name = this.name
      ..providesAnime = this.providesAnime
      ..providesMovie = this.providesMovie
      ..providesShow = this.providesShow
      ..rating = this.rating
      ..ratingCount = this.ratingCount
      ..stId = this.id
      ..providedRating = providedRating;
  }
}

extension ExtensionConverter1 on InstalledExtensions {
  Extension getExtension() {
    return Extension(
      id: this.stId,
      name: this.name,
      domainId: this.domainId,
      endpoint: this.endpoint,
      createdAt: this.createdAt,
      providesMovie: this.providesMovie,
      providesShow: this.providesShow,
      providesAnime: this.providesAnime,
      description: this.description,
      devEmail: this.devEmail,
      devName: this.devName,
      devUrl: this.devUrl,
      rating: this.rating,
      ratingCount: this.ratingCount,
    );
  }
}
