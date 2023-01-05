// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cinenexa/services/network/utils.dart';

class WatchProvider {
  final String name;
  final String logo;
  WatchProvider({
    required this.name,
    required this.logo,
  });

  WatchProvider copyWith({
    String? name,
    String? logo,
  }) {
    return WatchProvider(
      name: name ?? this.name,
      logo: logo ?? this.logo,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'provider_name': name,
      'logo_path': logo,
    };
  }

  factory WatchProvider.fromMap(Map<String, dynamic> map) {
    return WatchProvider(
      name: map['provider_name'] as String,
      logo: Utils.getWatchProviderUrl(map['logo_path'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory WatchProvider.fromJson(String source) =>
      WatchProvider.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'WatchProvider(name: $name, logo: $logo)';

  @override
  bool operator ==(covariant WatchProvider other) {
    if (identical(this, other)) return true;

    return other.name == name && other.logo == logo;
  }

  @override
  int get hashCode => name.hashCode ^ logo.hashCode;
}
