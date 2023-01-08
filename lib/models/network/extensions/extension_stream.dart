import 'dart:convert';
import 'dart:math';

import 'package:cinenexa/models/network/extensions/extension.dart';
import 'package:cinenexa/models/network/extensions/subtitle.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ExtensionStream {
  final double id = Random().nextInt(9000000) + 100000;

  final String? url;
  final String? ytId;
  final String? magnet;
  final int? fileIndex;
  final String? external;

  final String? name;
  final String? quality;
  final String? country;
  final bool? dubbed;
  final bool? subbed;
  final bool? torrent;
  final double? size;
  final int? seeds;
  final String? streamGroup;
  final List<Subtitle>? subtitles;

  Extension? extension;

  ExtensionStream.url({
    required this.url,
    this.ytId,
    this.magnet,
    this.fileIndex,
    this.external,
    this.name,
    this.quality,
    this.country,
    this.dubbed,
    this.subbed,
    this.torrent,
    this.size,
    this.seeds,
    this.streamGroup,
    this.subtitles,
  });

  ExtensionStream.ytId({
    this.url,
    required this.ytId,
    this.magnet,
    this.fileIndex,
    this.external,
    this.name,
    this.quality,
    this.country,
    this.dubbed,
    this.subbed,
    this.torrent,
    this.size,
    this.seeds,
    this.streamGroup,
    this.subtitles,
  });

  ExtensionStream.magnet({
    this.url,
    this.ytId,
    required this.magnet,
    this.fileIndex,
    this.external,
    this.name,
    this.quality,
    this.country,
    this.dubbed,
    this.subbed,
    this.torrent,
    this.size,
    this.seeds,
    this.streamGroup,
    this.subtitles,
  });

  ExtensionStream.external({
    this.url,
    this.ytId,
    this.magnet,
    this.fileIndex,
    required this.external,
    this.name,
    this.quality,
    this.country,
    this.dubbed,
    this.subbed,
    this.torrent,
    this.size,
    this.seeds,
    this.streamGroup,
    this.subtitles,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'url': url,
      'ytId': ytId,
      'magnet': magnet,
      'fileIndex': fileIndex,
      'externalUrl': external,
      'name': name,
      'quality': quality,
      'lang': country,
      'dubbed': dubbed,
      'subbed': subbed,
      'torrent': torrent,
      'size': size,
      'seeds': seeds,
      'streamGroup': streamGroup,
      'subtitles': subtitles,
    };
  }

  factory ExtensionStream.fromMap(Map<String, dynamic> map) {
    if (map['url'] != null) {
      return ExtensionStream.url(
        url: map['url'],
        name: map['name'] != null ? map['name'] as String : null,
        quality: map['quality'] != null ? map['quality'] as String : null,
        country: map['lang'] != null ? map['lang'] as String : null,
        dubbed: map['dubbed'] != null ? map['dubbed'] as bool : null,
        subbed: map['subbed'] != null ? map['subbed'] as bool : null,
        torrent: map['torrent'] != null ? map['torrent'] as bool : null,
        size: map['size'] != null ? map['size'] as double : null,
        seeds: map['seeds'] != null ? map['seeds'] as int : null,
        streamGroup:
            map['streamGroup'] != null ? map['streamGroup'] as String : null,
        subtitles: map['subtitles'] != null
            ? List<Subtitle>.from(
                map['subtitles']?.map((x) => Subtitle.fromMap(x)))
            : null,
      );
    } else if (map['ytId'] != null) {
      return ExtensionStream.ytId(
        ytId: map['ytId'],
        name: map['name'] != null ? map['name'] as String : null,
        quality: map['quality'] != null ? map['quality'] as String : null,
        country: map['lang'] != null ? map['lang'] as String : null,
        dubbed: map['dubbed'] != null ? map['dubbed'] as bool : null,
        subbed: map['subbed'] != null ? map['subbed'] as bool : null,
        torrent: map['torrent'] != null ? map['torrent'] as bool : null,
        size: map['size'] != null ? map['size'] as double : null,
        seeds: map['seeds'] != null ? map['seeds'] as int : null,
        streamGroup:
            map['streamGroup'] != null ? map['streamGroup'] as String : null,
        subtitles: map['subtitles'] != null
            ? List<Subtitle>.from(
                map['subtitles']?.map((x) => Subtitle.fromMap(x)))
            : null,
      );
    } else if (map['magnet'] != null) {
      return ExtensionStream.magnet(
        magnet: map['magnet'],
        name: map['name'] != null ? map['name'] as String : null,
        quality: map['quality'] != null ? map['quality'] as String : null,
        country: map['lang'] != null ? map['lang'] as String : null,
        fileIndex: map['fileIndex'],
        dubbed: map['dubbed'] != null ? map['dubbed'] as bool : null,
        subbed: map['subbed'] != null ? map['subbed'] as bool : null,
        torrent: map['torrent'] != null ? map['torrent'] as bool : null,
        size: map['size'] != null ? map['size'] as double : null,
        seeds: map['seeds'] != null ? map['seeds'] as int : null,
        streamGroup:
            map['streamGroup'] != null ? map['streamGroup'] as String : null,
        subtitles: map['subtitles'] != null
            ? List<Subtitle>.from(
                map['subtitles']?.map((x) => Subtitle.fromMap(x)))
            : null,
      );
    } else if (map['externalUrl'] != null) {
      return ExtensionStream.external(
        external: map['externalUrl'],
        name: map['name'] != null ? map['name'] as String : null,
        quality: map['quality'] != null ? map['quality'] as String : null,
        country: map['lang'] != null ? map['lang'] as String : null,
        dubbed: map['dubbed'] != null ? map['dubbed'] as bool : null,
        subbed: map['subbed'] != null ? map['subbed'] as bool : null,
        torrent: map['torrent'] != null ? map['torrent'] as bool : null,
        size: map['size'] != null ? map['size'] as double : null,
        seeds: map['seeds'] != null ? map['seeds'] as int : null,
        streamGroup:
            map['streamGroup'] != null ? map['streamGroup'] as String : null,
        subtitles: map['subtitles'] != null
            ? List<Subtitle>.from(
                map['subtitles']?.map((x) => Subtitle.fromMap(x)))
            : null,
      );
    } else {
      throw UnsupportedError(
          "Atleast one of url, ytId, externalUrl, magnet must be non-null");
    }
  }

  String toJson() => json.encode(toMap());

  factory ExtensionStream.fromJson(String source) {
    return ExtensionStream.fromMap(json.decode(source) as Map<String, dynamic>);
  }

  factory ExtensionStream.fromString(String source) {
    return ExtensionStream.fromMap(source as Map<String, dynamic>);
  }

  @override
  String toString() {
    return 'ExtensionStream(url: $url, ytId: $ytId, magnet: $magnet, fileIndex: $fileIndex, external: $external, name: $name, quality: $quality, country: $country, dubbed: $dubbed, subbed: $subbed, torrent: $torrent, size: $size, seeds: $seeds, streamGroup: $streamGroup, subtitles: $subtitles, extension: $extension)';
  }
}
