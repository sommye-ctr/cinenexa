import 'dart:convert';

class Certification {
  String certification;
  String meaning;
  Certification({
    required this.certification,
    required this.meaning,
  });

  Certification copyWith({
    String? certification,
    String? meaning,
  }) {
    return Certification(
      certification: certification ?? this.certification,
      meaning: meaning ?? this.meaning,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'certification': certification,
      'meaning': meaning,
    };
  }

  factory Certification.fromMap(Map<String, dynamic> map) {
    return Certification(
      certification: map['certification'] ?? '',
      meaning: map['meaning'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Certification.fromJson(String source) =>
      Certification.fromMap(json.decode(source));

  @override
  String toString() =>
      'Certification(certification: $certification, meaning: $meaning)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Certification &&
        other.certification == certification &&
        other.meaning == meaning;
  }

  @override
  int get hashCode => certification.hashCode ^ meaning.hashCode;
}
