import 'package:isar/isar.dart';

part 'last_activities.g.dart';

@Collection()
class LastActivities {
  @Id()
  int id = 0;

  late DateTime movieWatchedAt;
  late DateTime movieCollectedAt;

  late DateTime epWatchedAt;
  late DateTime epCollectedAt;
}
