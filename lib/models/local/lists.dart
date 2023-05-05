import 'package:isar/isar.dart';

import '../network/trakt/trakt_list.dart';
import 'lists_basemodel.dart';
part 'lists.g.dart';

@Collection()
class Lists {
  Id? id;

  String? name;
  String? desc;
  int? itemCount;
  int? likes;
  String? userName;
  DateTime? createdAt;

  List<ListsBaseModel>? items;
  bool? liked = false;
}

extension ListsConverter on Lists {
  TraktList getTraktList() {
    return TraktList(
      name: name ?? "",
      desc: desc ?? "",
      itemCount: itemCount ?? 0,
      likes: likes ?? 0,
      traktId: id ?? 0,
      userName: userName ?? "",
      createdAt: createdAt ?? DateTime.now(),
      items: items?.map((e) => e.getBaseModel()).toList(),
    );
  }
}
