import 'dart:async';

import 'package:mobx/mobx.dart';
import 'package:cinenexa/models/network/extensions/extension_stream.dart';
import 'package:cinenexa/models/network/review.dart';
import 'package:cinenexa/models/network/trakt/trakt_show_history_season.dart';
import 'package:cinenexa/models/network/trakt/trakt_show_history_season_ep.dart';
import 'package:cinenexa/models/network/watch_provider.dart';
import 'package:cinenexa/services/local/database.dart';
import 'package:cinenexa/services/network/requests.dart';
import 'package:cinenexa/services/network/trakt_oauth_client.dart';
import 'package:cinenexa/services/network/trakt_repository.dart';

import '../../models/local/progress.dart';
import '../../models/local/show_history.dart';
import '../../models/network/base_model.dart';
import '../../models/network/extensions/extension.dart';
import '../../models/network/genre.dart';
import '../../models/network/movie.dart';
import '../../models/network/trakt/trakt_progress.dart';
import '../../models/network/tv.dart';
import '../../models/network/tv_episode.dart';
import '../../models/network/video.dart';
import '../../services/network/extensions_repository.dart';
import '../../services/network/repository.dart';
import '../favorites/favorites_store.dart';
import '../user/user_store.dart';

part 'details_store.g.dart';

class DetailsStore extends _DetailsStore with _$DetailsStore {
  DetailsStore(
      {required BaseModel baseModel,
      required int noOfExtensions,
      required List<Extension> installedExtensions})
      : super(
            baseModel: baseModel,
            noOfExtensions: noOfExtensions,
            installedExtensions: installedExtensions);
}

abstract class _DetailsStore with Store {
  final BaseModel baseModel;
  Database database = Database();

  _DetailsStore({
    required this.baseModel,
    required this.noOfExtensions,
    required this.installedExtensions,
  }) {
    _fetchDetails();
    fetchReviews();
  }

  @observable
  int pageIndex = 0;

  @observable
  Movie? movie;

  @observable
  Tv? tv;

  @observable
  ObservableList<BaseModel> credits = <BaseModel>[].asObservable();

  @observable
  ObservableList<BaseModel> recommended = <BaseModel>[].asObservable();

  @observable
  ObservableList<TvEpisode> episodes = <TvEpisode>[].asObservable();

  @observable
  ObservableFuture<Map> reviews = ObservableFuture.value({});

  @observable
  ObservableList<WatchProvider> watchProviders =
      <WatchProvider>[].asObservable();

  @observable
  int? chosenSeason;

  @observable
  bool isAddedToFav = false;

  @observable
  bool isStreamLoading = true;

  @observable
  Video? video;

  @observable
  int? chosenEpisode;

  @observable
  int totalReviews = 0;

  @observable
  ObservableList<Review> reviewList = <Review>[].asObservable();

  @observable
  ObservableList<ExtensionStream> loadedStreams =
      <ExtensionStream>[].asObservable();

  @observable
  ShowHistory? showHistory;

  @observable
  Progress? progress;

  int reviewPage = 1;
  int noOfExtensions;
  bool isReviewNextPageLoading = false;
  int traktId = -1;
  String imdbId = "";
  TraktRepository repository = TraktRepository(client: TraktOAuthClient());
  StreamSubscription? streamSubscription;
  List<Extension> installedExtensions;

  bool isStreamLoadingDelayed = false;
  bool isReviewsLoadingDelayed = false;

  bool isProvidersEnabled = true;

  @computed
  List<Genre>? get genres {
    if (baseModel.type == BaseModelType.movie) {
      return movie?.genres;
    }
    return tv?.genres;
  }

  @action
  void onPageChanged(int index) {
    pageIndex = index;
  }

  @action
  Future addToListClicked(FavoritesStore store, UserStore userStore) async {
    store
        .addFavorite(baseModel, userStore)
        .whenComplete(() => isAddedToFav = true);
  }

  @action
  void removeFromListCLicked(FavoritesStore store, UserStore userStore) {
    store
        .removeFavorite(baseModel, userStore)
        .whenComplete(() => isAddedToFav = false);
  }

  @action
  Future markWatchedClicked({required int epIndex}) async {
    TraktShowHistorySeasonEp ep = TraktShowHistorySeasonEp(
      lastWatchedAt: DateTime.now().toUtc().toIso8601String(),
      number: episodes[epIndex].episodeNumber,
      plays: 1,
    );

    int seasonIndex = showHistory!.seasons!.indexWhere((element) =>
        element.number == tv!.seasons![chosenSeason!].seasonNumber);
    List<TraktShowHistorySeason> seasons = showHistory!.seasons!;

    if (seasonIndex > 0) {
      List<TraktShowHistorySeasonEp> eps = List.of(
        showHistory!.seasons![seasonIndex].episodes!,
        growable: true,
      )..add(ep);

      seasons[seasonIndex].episodes = eps;
    } else {
      List<TraktShowHistorySeasonEp> eps = List.of([ep], growable: true);

      TraktShowHistorySeason season = TraktShowHistorySeason(
        number: tv!.seasons![chosenSeason!].seasonNumber,
        episodes: eps,
      );
      List<TraktShowHistorySeason> newSeasons = List.of(seasons, growable: true)
        ..add(season);
      seasons = newSeasons;
    }

    ShowHistory newshowHistory = showHistory!;
    showHistory = ShowHistory()
      ..id = newshowHistory.id
      ..lastUpdatedAt = DateTime.now().toUtc()
      ..lastWatched = newshowHistory.lastWatched
      ..lastWatchedSeason = newshowHistory.lastWatchedSeason
      ..show = newshowHistory.show
      ..seasons = seasons;
    await Future.wait([
      repository.addToWatched(tmdbEpId: episodes[epIndex].id),
      database.updateLastActivities(epWatchedAt: DateTime.now().toUtc()),
      database.updateShowHistory(item: showHistory!),
    ]);
  }

  @action
  Future markUnwatchedClicked({required int epIndex}) async {
    int seasonIndex = showHistory!.seasons!.indexWhere((element) =>
        element.number == tv!.seasons![chosenSeason!].seasonNumber);

    List<TraktShowHistorySeasonEp> eps =
        List.of(showHistory!.seasons![seasonIndex].episodes!, growable: true)
          ..removeWhere(
              (element) => element.number == episodes[epIndex].episodeNumber);

    List<TraktShowHistorySeason> seasons = showHistory!.seasons!;
    seasons[seasonIndex].episodes = eps;

    ShowHistory newshowHistory = showHistory!;
    showHistory = ShowHistory()
      ..id = newshowHistory.id
      ..lastUpdatedAt = DateTime.now().toUtc()
      ..lastWatched = newshowHistory.lastWatched
      ..lastWatchedSeason = newshowHistory.lastWatchedSeason
      ..show = newshowHistory.show
      ..seasons = seasons;

    await Future.wait([
      database.updateShowHistory(item: showHistory!),
      database.updateLastActivities(epWatchedAt: DateTime.now().toUtc()),
      repository.removeFromWatched(tmdbEpId: episodes[epIndex].id),
    ]);
  }

  @action
  void onSeasonChanged(int index) {
    chosenSeason = index;
    _fetchEpisodes();
  }

  @action
  void onEpiodeClicked(int index) {
    chosenEpisode = index;
  }

  @action
  void onEpBackClicked() {
    chosenEpisode = null;
    streamSubscription?.cancel();
    loadedStreams.clear();
    isStreamLoading = true;
  }

  @action
  void onReviewEndReached() {
    if (!isReviewNextPageLoading && totalReviews != reviewList.length) {
      reviewPage++;
      isReviewNextPageLoading = true;
      fetchReviews();
    }
  }

  void _fetchEpisodes() async {
    List<TvEpisode> latest = await Repository.getSeasonEpisodes(
      tvId: baseModel.id!,
      seasonNo: tv!.seasons![chosenSeason!].seasonNumber!,
    );
    episodes.clear();
    episodes.addAll(latest);
  }

  @action
  void fetchStreams() {
    if (noOfExtensions == 0) {
      isStreamLoading = false;
      return;
    }

    if (traktId == -1 || imdbId.isEmpty) {
      isStreamLoadingDelayed = true;
      return;
    }

    ExtensionsRepository extensionsRepository =
        ExtensionsRepository(installedExtensions: installedExtensions);

    streamSubscription = extensionsRepository
        .loadStreams(
      baseModel: baseModel,
      episode: chosenEpisode != null
          ? (episodes[chosenEpisode!].episodeNumber)
          : null,
      season: chosenSeason != null
          ? (tv?.seasons?[chosenSeason!].seasonNumber)
          : null,
      imdbId: imdbId,
      traktId: traktId,
    )
        .listen(
      (event) {
        loadedStreams.addAll(event);

        var seen = Set<String>();
        List list = loadedStreams
            .where((element) => seen.add(element.extension!.id!))
            .toList();

        if (list.length == noOfExtensions) {
          isStreamLoading = false;
          streamSubscription?.cancel();
        }
      },
      onDone: () {
        isStreamLoading = false;
        streamSubscription?.cancel();
      },
    );
  }

  @action
  Future fetchReviews() async {
    if (traktId == -1) {
      isReviewsLoadingDelayed = true;
      return;
    }
    reviews = ObservableFuture(Repository.getReviews(
      query: Requests.reviews(baseModel.type!, traktId),
      page: reviewPage,
    ));
    reviews.then((value) {
      if (reviews.status == FutureStatus.fulfilled) {
        if (reviews.value != null && reviews.value!['results'] != null) {
          reviewList.addAll(reviews.value!['results']);
          totalReviews = reviews.value!['total'];
        }
        if (isReviewNextPageLoading) isReviewNextPageLoading = false;
      }
    });
  }

  @action
  Future fetchWatchHistory() async {
    showHistory = await database.getShowHistory(id: baseModel.id!);
    if (showHistory != null) {
      onSeasonChanged(tv!.seasons!.indexWhere(
          (element) => element.seasonNumber == showHistory!.lastWatchedSeason));
    }
  }

  @action
  Future fetchProgress() async {
    progress = await database.getProgress(id: baseModel.id!);
  }

  void _fetchDetails() async {
    isAddedToFav = await database.isAddedInFav(baseModel.id!);
    isProvidersEnabled = await database.getJustwatchProvidersStatus();

    if (traktId == -1) {
      var map = await Repository.getTraktIdFromTmdb(
        tmdbId: baseModel.id!,
        type: baseModel.type!.getString(),
      );
      traktId = map['trakt'];
      imdbId = map['imdb'];
      if (isStreamLoadingDelayed) {
        fetchStreams();
        isStreamLoadingDelayed = false;
      }
      if (isReviewsLoadingDelayed) {
        fetchReviews();
        isReviewsLoadingDelayed = true;
      }
    }

    if (baseModel.type == BaseModelType.movie) {
      Map map = await Repository.getMovieDetailsWithExtras(id: baseModel.id!);
      movie = map['movie'];
      credits.addAll(map['credits']);
      recommended.addAll(map['recommended']);
      video = map['video'];

      if (isProvidersEnabled)
        watchProviders.addAll(map['providers'] as List<WatchProvider>);

      fetchProgress();
    } else if (baseModel.type == BaseModelType.tv) {
      Map map = await Repository.getTvDetailsWithExtras(id: baseModel.id!);
      tv = map['tv'];
      credits.addAll(map['credits']);
      recommended.addAll(map['recommended']);
      video = map['video'];
      chosenSeason = 0;

      if (isProvidersEnabled)
        watchProviders.addAll(map['providers'] as List<WatchProvider>);

      fetchProgress();
      _fetchEpisodes();
      fetchWatchHistory();
    }
  }
}
