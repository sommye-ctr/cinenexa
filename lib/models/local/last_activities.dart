import 'package:isar/isar.dart';

part 'last_activities.g.dart';

@Collection()
class LastActivities {
  Id? id;

  late DateTime movieWatchedAt;
  late DateTime movieCollectedAt;

  late DateTime epWatchedAt;
  late DateTime epCollectedAt;

  late DateTime extensionsSyncedAt;
}
