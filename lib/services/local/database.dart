import 'package:isar/isar.dart';
import 'package:watrix/models/local/favorites.dart';
import 'package:watrix/models/local/last_activities.dart';
import 'package:watrix/models/local/progress.dart';
import 'package:watrix/models/local/search_history.dart';
import 'package:watrix/models/local/show_history.dart';
import 'package:watrix/models/network/base_model.dart';

import '../../models/network/trakt/trakt_progress.dart';

class Database {
  late Isar isar;

  Database() {
    isar = Isar.getInstance()!;
  }

  Future<LastActivities?> getLastActivities() async {
    try {
      return (await isar.lastActivitiess.get(0));
    } catch (e) {
      return null;
    }
  }

  void addLastActivities({required LastActivities lastActivities}) async {
    isar.writeTxn((isar) async {
      isar.lastActivitiess.put(lastActivities..id = 0);
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
    isar.writeTxn((isar) async {
      await isar.searchHistorys.put(SearchHistory()..term = term);
    });
    return true;
  }

  Future<List<SearchHistory>> getSearchHistory() async {
    return await isar.searchHistorys.where().findAll();
  }

  void deleteSearchHistory(int id) async {
    isar.writeTxn((isar) async {
      await isar.searchHistorys.delete(id);
    });
  }

  Future<List<BaseModel>> getFavorites() async {
    List<Favorites> list = await isar.favoritess.where().findAll();
    return list.map((e) => BaseModel.fromFavorite(e)).toList();
  }

  Future<bool> isAddedInFav(int id) async {
    if (await isar.favoritess.get(id) != null) {
      return true;
    }
    return false;
  }

  void addToFavorites(Favorites favorite) {
    isar.writeTxn((isar) async {
      await isar.favoritess.put(favorite);
    });
  }

  void updateFavorites({
    required List<Favorites> favorites,
    required Function(List<BaseModel>) onChange,
  }) {
    isar.writeTxn((isar) async {
      await isar.favoritess.clear();
      await isar.favoritess.putAll(favorites);
    }).whenComplete(() async {
      onChange(await getFavorites());
    });
  }

  void removeFromFav(int id) {
    isar.writeTxn((isar) async {
      await isar.favoritess.delete(id);
    });
  }

  void updateProgress({
    required List<TraktProgress> list,
    required Function(List<TraktProgress>) onChange,
  }) async {
    List<Progress> items = list.map((e) => e.getProgress()).toList();

    await isar.writeTxn((isar) async {
      await isar.progresss.clear();
      await isar.progresss.putAll(items);
    }).whenComplete(() async {
      onChange(await getProgress());
    });
  }

  Future<List<TraktProgress>> getProgress() async {
    List<Progress> list = await isar.progresss.where().findAll();
    return list.map((e) => e.getTraktProgress()).toList();
  }

  void updateShowHistory({
    required List<ShowHistory> items,
    required DateTime? localLastWatched,
    required DateTime? apiLastWatched,
    required Function(List<ShowHistory>) onChange,
  }) async {
    if (localLastWatched != null && apiLastWatched != null) {
      items = items
          .where((element) =>
              element.lastUpdatedAt != null &&
              element.lastUpdatedAt!.isAfter(localLastWatched) &&
              (element.lastUpdatedAt!.isBefore(apiLastWatched) ||
                  element.lastUpdatedAt!.isAtSameMomentAs(apiLastWatched)))
          .toList();
    }

    await isar.writeTxn((isar) async {
      await isar.showHistorys.putAll(items);
    }).whenComplete(() async {
      onChange(await getShowHistory());
    });
  }

  Future<List<ShowHistory>> getShowHistory() async {
    return await isar.showHistorys.where().findAll();
  }
}
