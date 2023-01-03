import 'package:country_picker/country_picker.dart';
import 'package:isar/isar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:watrix/models/local/favorites.dart';
import 'package:watrix/models/local/installed_extensions.dart';
import 'package:watrix/models/local/last_activities.dart';
import 'package:watrix/models/local/progress.dart';
import 'package:watrix/models/local/search_history.dart';
import 'package:watrix/models/local/show_history.dart';
import 'package:watrix/models/network/base_model.dart';
import 'package:watrix/models/network/extensions/extension.dart';
import 'package:watrix/models/network/trakt/trakt_show_history_season.dart';
import 'package:watrix/models/network/trakt/trakt_show_history_season_ep.dart';
import 'package:watrix/utils/date_time_formatter.dart';

import '../../models/network/trakt/trakt_progress.dart';

class Database {
  static const String _TRAKT_LOGGED_IN = "TRAKT_LOGGED_IN";
  static const String _PROVIDER_COUNTRY = "PROVIDER_COUNTRY";
  static const String _ALWAYS_EXTERNAL_PLAYER = "ALWAYS_EXTERNAL_PLAYER";
  static const String _AUTO_SUBTITLE = "AUTO_SUBTITLE";
  static const String _SEEK_DURATION = "SEEK_DURATION";

  late Isar isar;

  Database() {
    isar = Isar.getInstance()!;
  }

  Future clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    isar.writeTxn(() {
      return Future.wait([
        isar.clear(),
        prefs.clear(),
      ]);
    });
  }

  Future addUserTraktStatus(bool status) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_TRAKT_LOGGED_IN, status);
  }

  Future addAlwaysExternalPlayer(bool status) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_ALWAYS_EXTERNAL_PLAYER, status);
  }

  Future addAutoSelectSubtitle(bool status) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_AUTO_SUBTITLE, status);
  }

  Future addSeekDuration(int seconds) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_SEEK_DURATION, seconds);
  }

  Future<bool> getUserTraktStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return (prefs.getBool(_TRAKT_LOGGED_IN) ?? false);
  }

  Future<bool> getAlwaysExternalPlayer() async {
    final prefs = await SharedPreferences.getInstance();
    return (prefs.getBool(_ALWAYS_EXTERNAL_PLAYER) ?? false);
  }

  Future<bool> getAutoSelectSubtitle() async {
    final prefs = await SharedPreferences.getInstance();
    return (prefs.getBool(_AUTO_SUBTITLE) ?? false);
  }

  Future<int> getSeekDuration() async {
    final prefs = await SharedPreferences.getInstance();
    return (prefs.getInt(_SEEK_DURATION) ?? 30);
  }

  Future addProviderCountry(Country country) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_PROVIDER_COUNTRY, country.countryCode);
  }

  Future<Country?> getProviderCountry() async {
    final prefs = await SharedPreferences.getInstance();
    return Country.tryParse(prefs.getString(_PROVIDER_COUNTRY) ?? "");
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
    DateTime? extensionSyncedAt,
  }) async {
    LastActivities? lastActivities = await isar.lastActivities.get(0);
    LastActivities newLastActivities = LastActivities()
      ..id = 0
      ..epCollectedAt = epCollectedAt ?? lastActivities?.epCollectedAt
      ..epWatchedAt = epWatchedAt ?? lastActivities?.epWatchedAt
      ..movieCollectedAt = movieCollectedAt ?? lastActivities?.movieCollectedAt
      ..movieWatchedAt = movieWatchedAt ?? lastActivities?.movieWatchedAt
      ..extensionsSyncedAt =
          extensionSyncedAt ?? lastActivities?.extensionsSyncedAt;

    await isar.writeTxn(() async {
      await isar.lastActivities.put(newLastActivities);
    });
  }

  Future addInstalledExtension(Extension extension) {
    return isar.writeTxn(() async {
      await isar.installedExtensions.put(extension.getInstalled());
    });
  }

  //adds all the extensions assuming that this is to be called when all the extensions provided are installed
  Future updateAllInstalledExtensions(List<Extension> extensions) async {
    return isar.writeTxn(() async {
      await isar.installedExtensions.clear();
      await isar.installedExtensions
          .putAll(extensions.map((e) => e.getInstalled()).toList());
    });
  }

  Future updateInstalledExtensions(List<Extension> extensions) async {
    List<InstalledExtensions> installed =
        (await isar.installedExtensions.where().findAll());

    List<InstalledExtensions> newExt = installed
        .where((element) => extensions
            .where((element1) => element1.id == element.stId)
            .isNotEmpty)
        .toList();

    for (var i = 0; i < newExt.length; i++) {
      Extension ext =
          extensions.singleWhere((element) => element.id == newExt[i].stId);

      int? id = newExt[i].id;
      int? providedRating = newExt[i].providedRating;
      newExt[i] = ext.getInstalled()
        ..id = id
        ..providedRating = providedRating;
    }

    return isar.writeTxn(() async {
      isar.installedExtensions.putAll(newExt);
    });
  }

  Future removeInstalledExtension(Extension extension) {
    return isar.writeTxn(() async {
      await isar.installedExtensions
          .where()
          .stIdEqualTo(extension.id)
          .deleteFirst();
    });
  }

  Future<InstalledExtensions?> rateExtension(Extension extension, int rating) {
    return isar.writeTxn(() async {
      InstalledExtensions? ext = await isar.installedExtensions
          .where()
          .stIdEqualTo(extension.id)
          .findFirst();

      if (ext != null) {
        ext.providedRating = rating;
        int id = await isar.installedExtensions.put(ext);
        return isar.installedExtensions.get(id);
      }
    });
  }

  Stream watchInstalledExtensions() {
    return isar.installedExtensions.watchLazy(fireImmediately: true);
  }

  Future<List<InstalledExtensions>> getInstalledExtensions() async {
    var list = await isar.installedExtensions.where().findAll();
    return list;
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
      await isar.progress.putAll(items);
    }).whenComplete(() async {
      onChange(await getAllProgress());
    });
  }

  Stream watchProgress() {
    return isar.progress.watchLazy(fireImmediately: true);
  }

  Future addProgress({required Progress progress}) async {
    await isar.writeTxn(() async {
      isar.progress.put(progress);
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
