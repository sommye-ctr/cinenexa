import 'package:mobx/mobx.dart';
import 'package:watrix/models/local/last_activities.dart';
import 'package:watrix/models/local/show_history.dart';
import 'package:watrix/models/network/base_model.dart';
import 'package:watrix/models/network/enums/entity_type.dart';
import 'package:watrix/models/network/extensions/extension.dart';
import 'package:watrix/models/network/trakt/trakt_progress.dart';
import 'package:watrix/models/network/user.dart';
import 'package:watrix/models/network/user_stats.dart';
import 'package:watrix/services/local/database.dart';
import 'package:watrix/services/network/extensions_repository.dart';
import 'package:watrix/services/network/trakt_oauth_client.dart';
import 'package:watrix/services/network/trakt_repository.dart';
import 'package:watrix/store/favorites/favorites_store.dart';
part 'user_store.g.dart';

class UserStore = _UserStoreBase with _$UserStore;

abstract class _UserStoreBase with Store {
  @observable
  UserStats? userStats;

  @observable
  User? user;

  @observable
  ObservableList<TraktProgress> progress = <TraktProgress>[].asObservable();

  @observable
  ObservableList<BaseModel> movieRecommendations = <BaseModel>[].asObservable();

  @observable
  ObservableList<BaseModel> showRecommendations = <BaseModel>[].asObservable();

  @observable
  ObservableList<ShowHistory> showHistory = <ShowHistory>[].asObservable();

  @observable
  ObservableList<Extension> extensions = <Extension>[].asObservable();

  TraktRepository repository = TraktRepository(client: TraktOAuthClient());
  Database localDb = Database();

  _UserStoreBase({FavoritesStore? favoritesStore}) {
    init(favoritesStore: favoritesStore);
    localDb.watchProgress().listen((event) {
      fetchUserProgress(fromApi: false);
    });
    //localDb.clear();
  }

  @action
  Future init({FavoritesStore? favoritesStore}) async {
    fetchUserProfile();
    fetchUserStats();
    fetchUserRecommendations();
    fetchUserProgress();
    fetchUserExtensions();
    List futures = await Future.wait([
      repository.getUserLastActivity(),
      localDb.getLastActivities(),
    ]);
    LastActivities lastActivities = futures[0];
    LastActivities? localLast = futures[1];

    List<Future> listFutures = [];

    if (localLast != null) {
      if (lastActivities.epWatchedAt.isAfter(localLast.epWatchedAt)) {
        listFutures.add(fetchUserWatchedShows(
            api: lastActivities, local: localLast, fromApi: true));
      } else {
        listFutures
            .add(fetchUserWatchedShows(api: lastActivities, local: localLast));
      }
      if (lastActivities.movieCollectedAt.isAfter(localLast.movieCollectedAt) ||
          lastActivities.epCollectedAt.isAfter(localLast.epCollectedAt)) {
        listFutures.add(
            favoritesStore?.fetchFavorites(fromApi: true) ?? Future.value());
      } else {
        listFutures.add(favoritesStore?.fetchFavorites() ?? Future.value());
      }
    } else {
      futures.addAll([
        fetchUserWatchedShows(
            api: lastActivities, local: localLast, fromApi: true),
        favoritesStore?.fetchFavorites(fromApi: true),
      ]);
    }
    Future.wait(listFutures).whenComplete(
        () => localDb.addLastActivities(lastActivities: lastActivities));
  }

  @action
  Future fetchUserExtensions() async {
    extensions.addAll(await ExtensionsRepository.getUserExtensions());
  }

  @action
  Future fetchUserProfile() async {
    user = await repository.getUserProfile();
  }

  @action
  Future fetchUserStats() async {
    userStats = await repository.getUserStats();
  }

  @action
  Future fetchUserProgress({bool fromApi = true}) async {
    progress
      ..clear()
      ..addAll(await localDb.getAllProgress());
    if (fromApi)
      localDb.updateProgress(
          list: await repository.getUserProgress(),
          onChange: (list) {
            progress
              ..clear()
              ..addAll(list);
          });
  }

  @action
  Future removeProgress(TraktProgress traktProgress) async {
    progress.remove(traktProgress);
    await Future.wait([
      localDb.removeProgress(
          tmdbId: traktProgress.movie?.id ?? traktProgress.show!.id!),
      _removeProgressFromApi(traktProgress),
    ]);
  }

  Future _removeProgressFromApi(TraktProgress traktProgress) async {
    if (traktProgress.playbackId != null) {
      return repository.removeProgress(progressId: traktProgress.playbackId!);
    }

    Iterable<TraktProgress> progresses =
        (await repository.getUserProgress()).where((element) {
      int id = element.movie?.id ?? element.show!.id!;
      return id == (traktProgress.movie?.id ?? traktProgress.show!.id!);
    });
    if (progresses.isNotEmpty) {
      return repository.removeProgress(
          progressId: progresses.first.playbackId!);
    }
  }

  @action
  Future fetchUserWatchedShows(
      {LastActivities? local,
      LastActivities? api,
      bool fromApi = false}) async {
    showHistory.addAll(await localDb.getShowHistories());
    if (fromApi) {
      localDb.updateMultiShowHistory(
        items: await repository.getUserWatched(),
        localLastWatched: local?.epWatchedAt,
        apiLastWatched: api?.epWatchedAt,
        onChange: (p0) {
          showHistory
            ..clear()
            ..addAll(p0);
        },
      );
    }
  }

  @action
  Future fetchUserRecommendations() async {
    List list = await Future.wait([
      repository.getRecommendations(type: EntityType.movie),
      repository.getRecommendations(type: EntityType.tv)
    ]);
    movieRecommendations.addAll(list[0]);
    showRecommendations.addAll(list[1]);
  }
}
