import 'dart:convert';

import 'package:watrix/models/network/extensions/extension.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ExtensionStream {
  final double id;

  final String? url;
  final String? ytId;
  final String? magnet;
  final int? fileIndex;
  final String? externalUrl;

  final String? name;
  final int? quality;
  final String? langCountry;
  final bool? dubbed;
  final bool? subbed;
  final bool? torrent;
  final double? size;
  final int? seeds;
  final String? streamGroup;

  Extension? extension;

  ExtensionStream.url({
    required this.id,
    required this.url,
    this.ytId,
    this.magnet,
    this.fileIndex,
    this.externalUrl,
    this.name,
    this.quality,
    this.langCountry,
    this.dubbed,
    this.subbed,
    this.torrent,
    this.size,
    this.seeds,
    this.streamGroup,
  });

  ExtensionStream.ytId({
    required this.id,
    this.url,
    required this.ytId,
    this.magnet,
    this.fileIndex,
    this.externalUrl,
    this.name,
    this.quality,
    this.langCountry,
    this.dubbed,
    this.subbed,
    this.torrent,
    this.size,
    this.seeds,
    this.streamGroup,
  });

  ExtensionStream.magnet({
    required this.id,
    this.url,
    this.ytId,
    required this.magnet,
    this.fileIndex,
    this.externalUrl,
    this.name,
    this.quality,
    this.langCountry,
    this.dubbed,
    this.subbed,
    this.torrent,
    this.size,
    this.seeds,
    this.streamGroup,
  });

  ExtensionStream.externalUrl({
    required this.id,
    this.url,
    this.ytId,
    this.magnet,
    this.fileIndex,
    required this.externalUrl,
    this.name,
    this.quality,
    this.langCountry,
    this.dubbed,
    this.subbed,
    this.torrent,
    this.size,
    this.seeds,
    this.streamGroup,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'url': url,
      'ytId': ytId,
      'magnet': magnet,
      'fileIndex': fileIndex,
      'externalUrl': externalUrl,
      'name': name,
      'quality': quality,
      'lang': langCountry,
      'dubbed': dubbed,
      'subbed': subbed,
      'torrent': torrent,
      'size': size,
      'seeds': seeds,
      'streamGroup': streamGroup,
    };
  }

  factory ExtensionStream.fromMap(Map<String, dynamic> map) {
    if (map['url'] != null) {
      return ExtensionStream.url(
        id: map['id'] as double,
        url: map['url'],
        name: map['name'] != null ? map['name'] as String : null,
        quality: map['quality'] != null ? map['quality'] as int : null,
        langCountry: map['lang'] != null ? map['lang'] as String : null,
        dubbed: map['dubbed'] != null ? map['dubbed'] as bool : null,
        subbed: map['subbed'] != null ? map['subbed'] as bool : null,
        torrent: map['torrent'] != null ? map['torrent'] as bool : null,
        size: map['size'] != null ? map['size'] as double : null,
        seeds: map['seeds'] != null ? map['seeds'] as int : null,
        streamGroup:
            map['streamGroup'] != null ? map['streamGroup'] as String : null,
      );
    } else if (map['ytId'] != null) {
      return ExtensionStream.ytId(
        id: map['id'] as double,
        ytId: map['ytId'],
        name: map['name'] != null ? map['name'] as String : null,
        quality: map['quality'] != null ? map['quality'] as int : null,
        langCountry: map['lang'] != null ? map['lang'] as String : null,
        dubbed: map['dubbed'] != null ? map['dubbed'] as bool : null,
        subbed: map['subbed'] != null ? map['subbed'] as bool : null,
        torrent: map['torrent'] != null ? map['torrent'] as bool : null,
        size: map['size'] != null ? map['size'] as double : null,
        seeds: map['seeds'] != null ? map['seeds'] as int : null,
        streamGroup:
            map['streamGroup'] != null ? map['streamGroup'] as String : null,
      );
    } else if (map['magnet'] != null) {
      return ExtensionStream.magnet(
        id: map['id'] as double,
        magnet: map['magnet'],
        name: map['name'] != null ? map['name'] as String : null,
        quality: map['quality'] != null ? map['quality'] as int : null,
        langCountry: map['lang'] != null ? map['lang'] as String : null,
        fileIndex: map['fileIndex'],
        dubbed: map['dubbed'] != null ? map['dubbed'] as bool : null,
        subbed: map['subbed'] != null ? map['subbed'] as bool : null,
        torrent: map['torrent'] != null ? map['torrent'] as bool : null,
        size: map['size'] != null ? map['size'] as double : null,
        seeds: map['seeds'] != null ? map['seeds'] as int : null,
        streamGroup:
            map['streamGroup'] != null ? map['streamGroup'] as String : null,
      );
    } else if (map['externalUrl'] != null) {
      return ExtensionStream.externalUrl(
        id: map['id'] as double,
        externalUrl: map['externalUrl'],
        name: map['name'] != null ? map['name'] as String : null,
        quality: map['quality'] != null ? map['quality'] as int : null,
        langCountry: map['lang'] != null ? map['lang'] as String : null,
        dubbed: map['dubbed'] != null ? map['dubbed'] as bool : null,
        subbed: map['subbed'] != null ? map['subbed'] as bool : null,
        torrent: map['torrent'] != null ? map['torrent'] as bool : null,
        size: map['size'] != null ? map['size'] as double : null,
        seeds: map['seeds'] != null ? map['seeds'] as int : null,
        streamGroup:
            map['streamGroup'] != null ? map['streamGroup'] as String : null,
      );
    } else {
      throw UnsupportedError(
          "Atleast one of url, ytId, externalUrl, magnet must be non-null");
    }
  }

  String toJson() => json.encode(toMap());

  factory ExtensionStream.fromJson(String source) =>
      ExtensionStream.fromMap(json.decode(source) as Map<String, dynamic>);
}
