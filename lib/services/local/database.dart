import 'package:isar/isar.dart';
import 'package:watrix/models/local/favorites.dart';
import 'package:watrix/models/local/last_activities.dart';
import 'package:watrix/models/local/progress.dart';
import 'package:watrix/models/local/search_history.dart';
import 'package:watrix/models/local/show_history.dart';
import 'package:watrix/models/network/base_model.dart';
import 'package:watrix/models/network/trakt/trakt_show_history_season.dart';
import 'package:watrix/models/network/trakt/trakt_show_history_season_ep.dart';
import 'package:watrix/utils/date_time_formatter.dart';

import '../../models/network/trakt/trakt_progress.dart';

class Database {
  late Isar isar;

  Database() {
    isar = Isar.getInstance()!;
  }

  Future<LastActivities?> getLastActivities() async {
    try {
      return (await isar.lastActivities.get(0));
    } catch (e) {
      return null;
    }
  }

  void addLastActivities({required LastActivities lastActivities}) async {
    isar.writeTxn(() async {
      isar.lastActivities.put(lastActivities..id = 0);
    });
  }

  Future updateLastActivities({
    DateTime? movieWatchedAt,
    DateTime? movieCollectedAt,
    DateTime? epWatchedAt,
    DateTime? epCollectedAt,
  }) async {
    LastActivities? lastActivities = await isar.lastActivities.get(0);
    LastActivities newLastActivities = LastActivities()
      ..id = 0
      ..epCollectedAt = epCollectedAt ?? lastActivities!.epCollectedAt
      ..epWatchedAt = epWatchedAt ?? lastActivities!.epWatchedAt
      ..movieCollectedAt = movieCollectedAt ?? lastActivities!.movieCollectedAt
      ..movieWatchedAt = movieWatchedAt ?? lastActivities!.movieWatchedAt;

    await isar.writeTxn(() async {
      await isar.lastActivities.put(newLastActivities);
    });
  }

  Future<bool> addSearchHistory(String term) async {
    SearchHistory? prev = await isar.searchHistorys
        .filter()
        .termEqualTo(
          term,
          caseSensitive: true,
        )
        .findFirst();
    if (prev != null) {
      return false;
    }
    isar.writeTxn(() async {
      await isar.searchHistorys.put(SearchHistory()..term = term);
    });
    return true;
  }

  Future<List<SearchHistory>> getSearchHistory() async {
    return await isar.searchHistorys.where().findAll();
  }

  void deleteSearchHistory(int id) async {
    isar.writeTxn(() async {
      await isar.searchHistorys.delete(id);
    });
  }

  Future<List<BaseModel>> getFavorites() async {
    List<Favorites> list = await isar.favorites.where().findAll();
    return list.map((e) => BaseModel.fromFavorite(e)).toList();
  }

  Future<bool> isAddedInFav(int id) async {
    if (await isar.favorites.get(id) != null) {
      return true;
    }
    return false;
  }

  Future addToFavorites(Favorites favorite) async {
    await isar.writeTxn(() async {
      await isar.favorites.put(favorite);
    });
  }

  void updateFavorites({
    required List<Favorites> favorites,
    required Function(List<BaseModel>) onChange,
  }) {
    isar.writeTxn(() async {
      await isar.favorites.clear();
      await isar.favorites.putAll(favorites);
    }).whenComplete(() async {
      onChange(await getFavorites());
    });
  }

  void removeFromFav(int id) {
    isar.writeTxn(() async {
      await isar.favorites.delete(id);
    });
  }

  Future removeFavs({required List<int> ids}) async {
    await isar.writeTxn(() async {
      await isar.favorites.deleteAll(ids);
    });
  }

  void updateProgress({
    required List<TraktProgress> list,
    required Function(List<TraktProgress>) onChange,
  }) async {
    List<Progress> items = [];
    List<int> ids = [];

    for (var element in list) {
      Progress progress = element.getProgress();

      if (ids.contains(progress.id)) {
        Progress addedProgress =
            items.firstWhere((element1) => element1.id == progress.id);

        if (element.pausedAt!.isAfter(addedProgress.pausedAt!)) {
          items.remove(addedProgress);
          items.add(progress);
        }
      } else {
        ids.add(progress.id!);
        items.add(progress);
      }
    }

    await isar.writeTxn(() async {
//      await isar.progress.clear();
      await isar.progress.putAll(items);
    }).whenComplete(() async {
      onChange(await getAllProgress());
    });
  }

  Future removeProgress({required int tmdbId}) async {
    await isar.writeTxn(() async {
      await isar.progress.delete(tmdbId);
    });
  }

  Future<List<TraktProgress>> getAllProgress() async {
    List<Progress> list =
        await isar.progress.where().sortByPausedAtDesc().findAll();
    return list.map((e) => e.getTraktProgress()).toList();
  }

  Future<TraktProgress?> getProgress({required int id}) async {
    return (await isar.progress.get(id))?.getTraktProgress();
  }

  Future updateShowHistory({required ShowHistory item}) async {
    item;
    Map map = _calculateLastWatchedEp(item.seasons!);
    item = item
      ..lastWatched = map['ep']
      ..lastWatchedSeason = map['seasonNo'];

    await isar.writeTxn(() async {
      await isar.showHistorys.put(item);
    });
  }

  void updateMultiShowHistory({
    required List<ShowHistory> items,
    required DateTime? localLastWatched,
    required DateTime? apiLastWatched,
    required Function(List<ShowHistory>) onChange,
  }) async {
    if (localLastWatched != null && apiLastWatched != null) {
      items = items.where((element) {
        return element.lastUpdatedAt != null &&
            element.lastUpdatedAt!.isAfter(localLastWatched) &&
            (element.lastUpdatedAt!.isBefore(apiLastWatched) ||
                element.lastUpdatedAt!.isAtSameMomentAs(apiLastWatched));
      }).toList();
    }

    for (var element in items) {
      Map map = _calculateLastWatchedEp(element.seasons!);
      element = element
        ..lastWatched = map['ep']
        ..lastWatchedSeason = map['seasonNo'];
    }

    await isar.writeTxn(() async {
      await isar.showHistorys.putAll(items);
    }).whenComplete(() async {
      onChange(await isar.showHistorys.where().findAll());
    });
  }

  Future<List<ShowHistory>> getShowHistories() async {
    return await isar.showHistorys.where().findAll();
  }

  Future<ShowHistory?> getShowHistory({required int id}) async {
    return await isar.showHistorys.get(id);
  }

  Map _calculateLastWatchedEp(List<TraktShowHistorySeason> items) {
    Map<int, TraktShowHistorySeasonEp> latestEps = {};

    for (var season in items) {
      latestEps.putIfAbsent(
          season.number!,
          () => season.episodes!.reduce((value, element) {
                DateTime valueDate =
                    DateTimeFormatter.parseDate(value.lastWatchedAt)!;
                DateTime elementDate =
                    DateTimeFormatter.parseDate(element.lastWatchedAt)!;
                return valueDate.compareTo(elementDate) > 0 ? value : element;
              }));
    }

    latestEps;

    TraktShowHistorySeasonEp t = latestEps.values.reduce((value, element) {
      return DateTimeFormatter.parseDate(value.lastWatchedAt)!
              .isAfter(DateTimeFormatter.parseDate(element.lastWatchedAt)!)
          ? value
          : element;
    });

    return {
      "ep": t,
      "seasonNo":
          latestEps.keys.firstWhere((element) => latestEps[element] == t),
    };
  }
}
