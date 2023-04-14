import 'package:cinenexa/models/local/lists.dart';
import 'package:cinenexa/models/network/tv.dart';
import 'package:cinenexa/services/network/trakt_repository.dart';
import 'package:country_picker/country_picker.dart';
import 'package:isar/isar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cinenexa/models/local/favorites.dart';
import 'package:cinenexa/models/local/installed_extensions.dart';
import 'package:cinenexa/models/local/last_activities.dart';
import 'package:cinenexa/models/local/progress.dart';
import 'package:cinenexa/models/local/search_history.dart';
import 'package:cinenexa/models/local/show_history.dart';
import 'package:cinenexa/models/network/base_model.dart';
import 'package:cinenexa/models/network/extensions/extension.dart';
import 'package:cinenexa/models/network/trakt/trakt_show_history_season.dart';
import 'package:cinenexa/models/network/trakt/trakt_show_history_season_ep.dart';

import '../../models/network/trakt/trakt_list.dart';
import '../../models/network/trakt/trakt_progress.dart';
import '../../utils/show_episodes_utils.dart';

class Database {
  static const String _TRAKT_LOGGED_IN = "TRAKT_LOGGED_IN";
  static const String _PROVIDER_COUNTRY = "PROVIDER_COUNTRY";
  static const String _AUTO_SUBTITLE = "AUTO_SUBTITLE";
  static const String _SEEK_DURATION = "SEEK_DURATION";
  static const String _JUSTWATCH_PROVIDERS_ENABLED =
      "JUSTWATCH_PROVIDERS_ENABLED";
  static const String _TMDB_REGION = "TMDB_REGION";
  static const String _MAX_CACHE_SIZE = "MAX_CACHE_SIZE";
  static const String _DEFAULT_FIT = "DEFAULT_FIT";
  static const String _NEXT_EP_DURATION = "NEXT_EP_DURATION";
  static const String _AUTOPLAY = "AUTOPLAY";
  static const String _GUEST_SIGNUP = "GUEST_SIGNUP";

  static const String _SUBTITLE_FONT_SIZE = "SUBTITLE_FONT_SIZE";
  static const String _SUBTITLE_POSITION = "SUBTITLE_POSITION";
  static const String _SUBTITLE_BG = "SUBTITLE_BG";

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

  Future addGuestSignupStatus(bool status) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_GUEST_SIGNUP, status);
  }

  Future addJustwatchProvidersEnabled(bool status) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_JUSTWATCH_PROVIDERS_ENABLED, status);
  }

  Future addAutoSelectSubtitle(bool status) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_AUTO_SUBTITLE, status);
  }

  Future addAutoPlay(bool status) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_AUTOPLAY, status);
  }

  Future addSeekDuration(int seconds) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_SEEK_DURATION, seconds);
  }

  Future addNextEpDuration(int seconds) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_NEXT_EP_DURATION, seconds);
  }

  Future addMaxCache(int index) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_MAX_CACHE_SIZE, index);
  }

  Future addSubFontSize(int size) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_SUBTITLE_FONT_SIZE, size);
  }

  Future addSubPosition(int position) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_SUBTITLE_POSITION, position);
  }

  Future addSubBgEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_SUBTITLE_BG, enabled);
  }

  Future addDefaultFit(int indexFit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_DEFAULT_FIT, indexFit);
  }

  Future<bool> getUserTraktStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return (prefs.getBool(_TRAKT_LOGGED_IN) ?? false);
  }

  Future<bool> getGuestSignupStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return (prefs.getBool(_GUEST_SIGNUP) ?? false);
  }

  Future<bool> getJustwatchProvidersStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return (prefs.getBool(_JUSTWATCH_PROVIDERS_ENABLED) ?? false);
  }

  Future<bool> getAutoSelectSubtitle() async {
    final prefs = await SharedPreferences.getInstance();
    return (prefs.getBool(_AUTO_SUBTITLE) ?? false);
  }

  Future<bool> getAutoPlay() async {
    final prefs = await SharedPreferences.getInstance();
    return (prefs.getBool(_AUTOPLAY) ?? false);
  }

  Future<int> getSeekDuration() async {
    final prefs = await SharedPreferences.getInstance();
    return (prefs.getInt(_SEEK_DURATION) ?? 30);
  }

  Future<int> getNextEpDuration() async {
    final prefs = await SharedPreferences.getInstance();
    return (prefs.getInt(_NEXT_EP_DURATION) ?? 30);
  }

  Future<int> getMaxCache() async {
    final prefs = await SharedPreferences.getInstance();
    return (prefs.getInt(_MAX_CACHE_SIZE) ?? 0);
  }

  Future<int> getSubPosition() async {
    final prefs = await SharedPreferences.getInstance();
    return (prefs.getInt(_SUBTITLE_POSITION) ?? 20);
  }

  Future<int> getSubFontSize() async {
    final prefs = await SharedPreferences.getInstance();
    return (prefs.getInt(_SUBTITLE_FONT_SIZE) ?? 14);
  }

  Future<bool> getSubBg() async {
    final prefs = await SharedPreferences.getInstance();
    return (prefs.getBool(_SUBTITLE_BG) ?? false);
  }

  Future<int> getDefaultFit() async {
    final prefs = await SharedPreferences.getInstance();
    return (prefs.getInt(_DEFAULT_FIT) ?? 0);
  }

  Future addProviderCountry(Country country) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_PROVIDER_COUNTRY, country.countryCode);
  }

  Future addTmdbRegion(Country country) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_TMDB_REGION, country.countryCode);
  }

  Future removeProviderCountry() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_PROVIDER_COUNTRY);
  }

  Future<Country?> getTmdbRegion() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      return Country.tryParse(prefs.getString(_TMDB_REGION) ?? "");
    } catch (e) {
      return null;
    }
  }

  Future removeTmdbRegion() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_TMDB_REGION);
  }

  Future<Country?> getProviderCountry() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      return Country.tryParse(prefs.getString(_PROVIDER_COUNTRY) ?? "");
    } catch (e) {
      return null;
    }
  }

  Future<LastActivities?> getLastActivities() async {
    try {
      return (await isar.lastActivities.get(0));
    } catch (e) {
      return null;
    }
  }

  Future clearTraktInfo() async {
    isar.writeTxn(() async {
      return Future.wait([
        isar.favorites.clear(),
        isar.progress.clear(),
        isar.showHistorys.clear(),
      ]);
    });
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

  Future addInstalledExtension(Extension extension, {String? userData}) {
    return isar.writeTxn(() async {
      await isar.installedExtensions.put(extension.getInstalled(
        userData: userData,
      ));
    });
  }

  //adds all the extensions assuming that this is to be called when all the extensions provided are installed
  Future updateAllInstalledExtensions(
      List<InstalledExtensions> extensions) async {
    return isar.writeTxn(() async {
      await isar.installedExtensions.clear();
      await isar.installedExtensions.putAll(extensions);
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
      String? userData = newExt[i].userData;
      newExt[i] = ext.getInstalled()
        ..id = id
        ..providedRating = providedRating
        ..userData = userData;
    }

    return isar.writeTxn(() async {
      isar.installedExtensions.putAll(newExt);
    });
  }

  Future removeInstalledExtension(Extension extension) {
    return isar.writeTxn(() async {
      return await isar.installedExtensions
          .where()
          .stIdEqualTo(extension.id!)
          .deleteFirst();
    });
  }

  Future<InstalledExtensions?> rateExtension(Extension extension, int rating) {
    return isar.writeTxn(() async {
      InstalledExtensions? ext = await isar.installedExtensions
          .where()
          .stIdEqualTo(extension.id!)
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
    List<Progress> items = await isar.progress.where().findAll();
    List<int?> ids = items.map((e) => e.id).toList();

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

  Future<Progress?> getProgress({required int id}) async {
    return (await isar.progress.get(id));
  }

  Future updateShowHistory({required ShowHistory item}) async {
    Map map = ShowEpisodesUtils.calculateLastWatchedEp(item.seasons!);
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
      Map map = ShowEpisodesUtils.calculateLastWatchedEp(element.seasons!);
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

  Future<ShowHistory> unwatchEp({
    required int episodeNumber,
    required int episodeId,
    required int? seasonNumber,
    required ShowHistory showHistory,
    required bool isTraktLogged,
    required TraktRepository repository,
  }) async {
    int seasonIndex = showHistory.seasons!
        .indexWhere((element) => element.number == seasonNumber);

    List<TraktShowHistorySeasonEp> eps =
        List.of(showHistory.seasons![seasonIndex].episodes!, growable: true)
          ..removeWhere((element) => element.number == episodeNumber);

    List<TraktShowHistorySeason> seasons = List.of(showHistory.seasons!);
    seasons[seasonIndex].episodes = eps;

    if (seasons[seasonIndex].episodes!.isEmpty) {
      seasons.removeAt(seasonIndex);
    }

    ShowHistory newshowHistory = showHistory;
    showHistory = ShowHistory()
      ..id = newshowHistory.id
      ..lastUpdatedAt = DateTime.now().toUtc()
      ..lastWatched = newshowHistory.lastWatched
      ..lastWatchedSeason = newshowHistory.lastWatchedSeason
      ..show = newshowHistory.show
      ..seasons = seasons;

    List<Future> futures = [];
    futures.add(updateShowHistory(item: showHistory));
    if (isTraktLogged) {
      futures.addAll([
        updateLastActivities(epWatchedAt: DateTime.now().toUtc()),
        repository.removeFromWatched(tmdbEpId: episodeId),
      ]);
    }
    await Future.wait(futures);
    return showHistory;
  }

  Future<ShowHistory> watchEp({
    required int episodeNumber,
    required int episodeId,
    required int? seasonNo,
    required ShowHistory? showHistory,
    required int baseModelId,
    required Tv tv,
    required bool isTraktLogged,
    required TraktRepository repository,
  }) async {
    TraktShowHistorySeasonEp ep = TraktShowHistorySeasonEp(
      lastWatchedAt: DateTime.now().toUtc().toIso8601String(),
      number: episodeNumber,
      plays: 1,
    );

    ShowHistory tempHistory;
    if (showHistory == null) {
      tempHistory = ShowHistory()
        ..id = baseModelId
        ..lastWatched = ep
        ..show = tv
        ..seasons = null
        ..lastWatched = ep
        ..lastWatchedSeason = seasonNo;
    } else {
      tempHistory = showHistory;
    }

    int? seasonIndex = tempHistory.seasons
        ?.indexWhere((element) => element.number == seasonNo);
    List<TraktShowHistorySeason>? seasons = tempHistory.seasons;

    if (seasonIndex != null && seasonIndex >= 0 && seasons != null) {
      //check if history already exists
      if (tempHistory.seasons![seasonIndex].episodes!
              .indexWhere((element) => element.number == episodeNumber) >=
          0) {
        int plays = ep.plays ?? 1;
        ep.plays = plays + 1;
      } else {
        List<TraktShowHistorySeasonEp> eps = List.of(
          tempHistory.seasons![seasonIndex].episodes!,
          growable: true,
        )..add(ep);

        seasons[seasonIndex].episodes = eps;
      }
    } else {
      List<TraktShowHistorySeasonEp> eps = List.of([ep], growable: true);

      TraktShowHistorySeason season = TraktShowHistorySeason(
        number: seasonNo,
        episodes: eps,
      );
      List<TraktShowHistorySeason> newSeasons =
          List.of(seasons ?? [], growable: true)..add(season);
      seasons = newSeasons;
    }

    showHistory = ShowHistory()
      ..id = tempHistory.id
      ..lastUpdatedAt = DateTime.now().toUtc()
      ..lastWatched = tempHistory.lastWatched
      ..lastWatchedSeason = tempHistory.lastWatchedSeason
      ..show = tempHistory.show
      ..seasons = seasons;

    List<Future> futures = [];
    futures.add(updateShowHistory(item: showHistory));
    if (isTraktLogged) {
      futures.addAll([
        repository.addToWatched(tmdbEpId: episodeId),
        updateLastActivities(epWatchedAt: DateTime.now().toUtc())
      ]);
    }
    await Future.wait(futures);
    return showHistory;
  }

  Future<List<TraktList>> getLists() async {
    return (await isar.lists.filter().likedEqualTo(false).findAll())
        .map((e) => e.getTraktList())
        .toList();
  }

  Future<List<TraktList>> getLikedLists() async {
    List<Lists> list = await isar.lists.filter().likedEqualTo(true).findAll();

    return list.map((e) => e.getTraktList()).toList();
  }

  Future updateLists(
      {required List<TraktList> lists, bool liked = false}) async {
    await isar.writeTxn(() async {
      await isar.lists
          .putAll(lists.map((e) => e.getList()..liked = liked).toList());
    });
  }
}
