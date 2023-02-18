import 'package:mobx/mobx.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:cinenexa/models/local/last_activities.dart';
import 'package:cinenexa/models/local/show_history.dart';
import 'package:cinenexa/models/network/base_model.dart';
import 'package:cinenexa/models/network/enums/entity_type.dart';
import 'package:cinenexa/models/network/trakt/trakt_progress.dart';
import 'package:cinenexa/models/network/cinenexa_user.dart';
import 'package:cinenexa/models/network/trakt_user.dart';
import 'package:cinenexa/models/network/user_stats.dart';
import 'package:cinenexa/services/local/database.dart';
import 'package:cinenexa/services/network/trakt_oauth_client.dart';
import 'package:cinenexa/services/network/trakt_repository.dart';
import 'package:cinenexa/store/favorites/favorites_store.dart';
part 'user_store.g.dart';

class UserStore = _UserStoreBase with _$UserStore;

abstract class _UserStoreBase with Store {
  @observable
  UserStats? userStats;

  @observable
  CineNexaUser? user;

  @observable
  ObservableList<TraktProgress> progress = <TraktProgress>[].asObservable();

  @observable
  ObservableList<BaseModel> movieRecommendations = <BaseModel>[].asObservable();

  @observable
  ObservableList<BaseModel> showRecommendations = <BaseModel>[].asObservable();

  @observable
  ObservableList<ShowHistory> showHistory = <ShowHistory>[].asObservable();

  bool get isTraktLogged => traktStatus;

  TraktRepository repository = TraktRepository(client: TraktOAuthClient());
  Database localDb = Database();
  SupabaseClient supabaseClient = Supabase.instance.client;
  bool traktStatus = false;
  bool guestLogin = false;

  _UserStoreBase({FavoritesStore? favoritesStore}) {
    init(favoritesStore: favoritesStore);
    localDb.watchProgress().listen((event) {
      fetchUserProgress(fromApi: false);
    });
  }

  @action
  Future init({FavoritesStore? favoritesStore}) async {
    traktStatus = await localDb.getUserTraktStatus();
    guestLogin = await localDb.getGuestSignupStatus();

    if (supabaseClient.auth.currentUser != null) {
      user = CineNexaUser(
        id: supabaseClient.auth.currentUser!.id,
        name: supabaseClient.auth.currentUser!.userMetadata?['name'],
        email: supabaseClient.auth.currentUser!.email!,
      );
    }

    if (isTraktLogged) {
      fetchUserStats();
      fetchUserRecommendations();
      fetchUserProgress();

      List futures = await Future.wait([
        repository.getUserLastActivity(),
        localDb.getLastActivities(),
      ]);
      LastActivities lastActivities = futures[0];
      LastActivities? localLast = futures[1];

      List<Future> listFutures = [];

      if (localLast != null && localLast.movieCollectedAt != null) {
        if (lastActivities.epWatchedAt!.isAfter(localLast.epWatchedAt!)) {
          listFutures.add(fetchUserWatchedShows(
              api: lastActivities, local: localLast, fromApi: true));
        } else {
          listFutures.add(
              fetchUserWatchedShows(api: lastActivities, local: localLast));
        }
        if (lastActivities.movieCollectedAt!
                .isAfter(localLast.movieCollectedAt!) ||
            lastActivities.epCollectedAt!.isAfter(localLast.epCollectedAt!)) {
          listFutures.add(
              favoritesStore?.fetchFavorites(fromApi: true) ?? Future.value());
        } else {
          listFutures.add(favoritesStore?.fetchFavorites() ?? Future.value());
        }
      } else {
        futures.addAll([
          fetchUserWatchedShows(
            api: lastActivities,
            local: localLast,
            fromApi: true,
          ),
          favoritesStore?.fetchFavorites(fromApi: true),
        ]);
      }
      Future.wait(listFutures).whenComplete(() => localDb.addLastActivities(
          lastActivities: lastActivities
            ..extensionsSyncedAt = localLast?.extensionsSyncedAt));
    } else {
      favoritesStore?.fetchFavorites(fromApi: false);
    }
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
    if (!isTraktLogged) {
      return;
    }

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
  Future<TraktUser> fetchUserTraktProfile() async {
    return repository.getUserProfile();
  }

  @action
  Future logout() async {
    return Future.wait([
      supabaseClient.auth.signOut(),
      localDb.clearAll(),
    ]);
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

  @action
  Future disconnectTrakt() async {
    traktStatus = false;
    return Database().addUserTraktStatus(false);
  }
}
