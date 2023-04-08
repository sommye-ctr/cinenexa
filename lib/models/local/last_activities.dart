import 'package:isar/isar.dart';

part 'last_activities.g.dart';

@Collection()
class LastActivities {
  Id? id;

  DateTime? movieWatchedAt;
  DateTime? movieCollectedAt;

  DateTime? epWatchedAt;
  DateTime? epCollectedAt;

  DateTime? extensionsSyncedAt;

  DateTime? listsUpdatedAt;
}
