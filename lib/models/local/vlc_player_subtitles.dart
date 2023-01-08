// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

class VlcPlayerSubtitle {
  final int id = Random().nextInt(100000);
  final int? vlcId;
  final String? source;
  final String name;
  VlcPlayerSubtitle({
    this.vlcId,
    this.source,
    required this.name,
  });
}
