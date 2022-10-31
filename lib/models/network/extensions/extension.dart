import 'dart:convert';

import 'package:watrix/models/network/enums/extension_provider_type.dart';

class Extension {
  final String name;
  final String id;
  final String icon;
  final String endpoint;
  final ExtensionProviderType provider;
  final String? description;
  final String? devEmail;
  final String? externalUrl;
  final String? devName;
  final String? devUrl;

  Extension({
    required this.name,
    required this.id,
    required this.icon,
    required this.endpoint,
    required this.provider,
    this.description,
    this.devEmail,
    this.externalUrl,
    this.devName,
    this.devUrl,
  });

  Extension copyWith({
    String? name,
    String? id,
    String? icon,
    String? endpoint,
    ExtensionProviderType? provider,
    String? description,
    String? devEmail,
    String? externalUrl,
    String? devName,
    String? devUrl,
  }) {
    return Extension(
      name: name ?? this.name,
      id: id ?? this.id,
      icon: icon ?? this.icon,
      endpoint: endpoint ?? this.endpoint,
      provider: provider ?? this.provider,
      description: description ?? this.description,
      devEmail: devEmail ?? this.devEmail,
      externalUrl: externalUrl ?? this.externalUrl,
      devName: devName ?? this.devName,
      devUrl: devUrl ?? this.devUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'id': id,
      'icon': icon,
      'endpoint': endpoint,
      'provider': provider.getString(),
      'description': description,
      'devEmail': devEmail,
      'externalUrl': externalUrl,
      'devName': devName,
      'devUrl': devUrl,
    };
  }

  factory Extension.fromMap(Map<String, dynamic> map) {
    return Extension(
      name: map['name'] as String,
      id: map['id'] as String,
      icon: map['icon'] as String,
      endpoint: map['endpoint'] as String,
      provider: (map['provider'] as String).getProviderType(),
      description:
          map['description'] != null ? map['description'] as String : null,
      devEmail: map['devEmail'] != null ? map['devEmail'] as String : null,
      externalUrl:
          map['externalUrl'] != null ? map['externalUrl'] as String : null,
      devName: map['devName'] != null ? map['devName'] as String : null,
      devUrl: map['devUrl'] != null ? map['devUrl'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Extension.fromJson(String source) =>
      Extension.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Extension(name: $name, id: $id, icon: $icon, endpoint: $endpoint, provider: $provider, description: $description, devEmail: $devEmail, externalUrl: $externalUrl, devName: $devName, devUrl: $devUrl)';
  }

  @override
  bool operator ==(covariant Extension other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.id == id &&
        other.icon == icon &&
        other.endpoint == endpoint &&
        other.provider == provider &&
        other.description == description &&
        other.devEmail == devEmail &&
        other.externalUrl == externalUrl &&
        other.devName == devName &&
        other.devUrl == devUrl;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        id.hashCode ^
        icon.hashCode ^
        endpoint.hashCode ^
        provider.hashCode ^
        description.hashCode ^
        devEmail.hashCode ^
        externalUrl.hashCode ^
        devName.hashCode ^
        devUrl.hashCode;
  }
}
