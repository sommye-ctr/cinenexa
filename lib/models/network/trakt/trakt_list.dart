// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cinenexa/models/local/lists_basemodel.dart';
import 'package:cinenexa/models/network/base_model.dart';

import '../../local/lists.dart';

class TraktList {
  final String name;
  final String desc;
  int itemCount;
  final int likes;
  final int traktId;
  final String userName;
  final DateTime createdAt;
  List<BaseModel> items;

  TraktList({
    required this.name,
    required this.desc,
    required this.itemCount,
    required this.likes,
    required this.traktId,
    required this.userName,
    required this.createdAt,
    List<BaseModel>? items,
  }) : this.items = items ?? [];

  void setItems(List<BaseModel> items) {
    this.items = items;
  }

  void addItem(BaseModel item) {
    items.add(item);
    itemCount++;
  }

  void removeItem(BaseModel item) {
    items.removeWhere((element) => element.id == item.id);
    itemCount--;
  }

  TraktList copyWith({
    String? name,
    String? desc,
    int? itemCount,
    int? likes,
    int? traktId,
    String? userName,
    DateTime? createdAt,
  }) {
    return TraktList(
      name: name ?? this.name,
      desc: desc ?? this.desc,
      itemCount: itemCount ?? this.itemCount,
      likes: likes ?? this.likes,
      traktId: traktId ?? this.traktId,
      userName: userName ?? this.userName,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'desc': desc,
      'itemCount': itemCount,
      'likes': likes,
      'traktId': traktId,
      'userName': userName,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory TraktList.fromMap(Map<String, dynamic> map) {
    return TraktList(
      name: map['list']['name'] as String,
      desc: map['list']['description'] as String,
      itemCount: map['list']['item_count'] as int,
      likes: map['list']['likes'] as int,
      traktId: map['list']['ids']['trakt'] as int,
      userName: map['list']['user']['username'] as String,
      createdAt: DateTime.parse(map['list']['created_at'] as String),
    );
  }

  factory TraktList.fromPersonalMap(Map<String, dynamic> map) {
    return TraktList(
      name: map['name'] as String,
      desc: map['description'] as String,
      itemCount: map['item_count'] as int,
      likes: map['likes'] as int,
      traktId: map['ids']['trakt'] as int,
      userName: map['user']['username'] as String,
      createdAt: DateTime.parse(map['created_at'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory TraktList.fromJson(String source) =>
      TraktList.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TraktList(name: $name, desc: $desc, itemCount: $itemCount, likes: $likes, traktId: $traktId, userName: $userName, createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant TraktList other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.desc == desc &&
        other.itemCount == itemCount &&
        other.likes == likes &&
        other.traktId == traktId &&
        other.userName == userName &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        desc.hashCode ^
        itemCount.hashCode ^
        likes.hashCode ^
        traktId.hashCode ^
        userName.hashCode ^
        createdAt.hashCode;
  }
}

extension TraktListConverter on TraktList {
  Lists getList() {
    return Lists()
      ..createdAt = createdAt
      ..desc = desc
      ..id = traktId
      ..itemCount = itemCount
      ..items = items.map((e) => e.getListBaseModel()).toList()
      ..likes = likes
      ..name = name
      ..userName = userName;
  }
}
