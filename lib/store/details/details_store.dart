import 'package:mobx/mobx.dart';
import 'package:watrix/models/network/review.dart';
import 'package:watrix/models/network/trakt/trakt_show_history_season.dart';
import 'package:watrix/models/network/trakt/trakt_show_history_season_ep.dart';
import 'package:watrix/services/local/database.dart';
import 'package:watrix/services/network/requests.dart';
import 'package:watrix/services/network/trakt_oauth_client.dart';
import 'package:watrix/services/network/trakt_repository.dart';

import '../../models/local/show_history.dart';
import '../../models/network/base_model.dart';
import '../../models/network/genre.dart';
import '../../models/network/movie.dart';
import '../../models/network/trakt/trakt_progress.dart';
import '../../models/network/tv.dart';
import '../../models/network/tv_episode.dart';
import '../../models/network/video.dart';
import '../../services/network/repository.dart';
import '../favorites/favorites_store.dart';

part 'details_store.g.dart';

class DetailsStore extends _DetailsStore with _$DetailsStore {
  DetailsStore({required BaseModel baseModel}) : super(baseModel: baseModel);
}

abstract class _DetailsStore with Store {
  final BaseModel baseModel;
  Database database = Database();

  _DetailsStore({
    required this.baseModel,
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
  int? chosenSeason;

  @observable
  bool isAddedToFav = false;

  @observable
  Video? video;

  @observable
  int? chosenEpisode;

  @observable
  int totalReviews = 0;

  @observable
  ObservableList<Review> reviewList = <Review>[].asObservable();

  @observable
  ShowHistory? showHistory;

  @observable
  TraktProgress? progress;

  int reviewPage = 1;
  bool isReviewNextPageLoading = false;
  int traktId = -1;
  TraktRepository repository = TraktRepository(client: TraktOAuthClient());

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
  void addToListClicked(FavoritesStore store) async {
    store.addFavorite(baseModel).whenComplete(() => isAddedToFav = true);
  }

  @action
  void removeFromListCLicked(FavoritesStore store) {
    store.removeFavorite(baseModel).whenComplete(() => isAddedToFav = false);
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
  Future fetchReviews() async {
    if (traktId == -1) {
      traktId = await Repository.getTraktIdFromTmdb(
        tmdbId: baseModel.id!,
        type: baseModel.type! == BaseModelType.movie ? "movie" : "show",
      );
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
  Future _fetchProgress() async {
    progress = await database.getProgress(id: baseModel.id!);
  }

  void _fetchDetails() async {
    isAddedToFav = await database.isAddedInFav(baseModel.id!);
    if (baseModel.type == BaseModelType.movie) {
      Map map = await Repository.getMovieDetailsWithExtras(id: baseModel.id!);
      movie = map['movie'];
      credits.addAll(map['credits']);
      recommended.addAll(map['recommended']);
      video = map['video'];
      _fetchProgress();
    } else if (baseModel.type == BaseModelType.tv) {
      Map map = await Repository.getTvDetailsWithExtras(id: baseModel.id!);
      tv = map['tv'];
      credits.addAll(map['credits']);
      recommended.addAll(map['recommended']);
      video = map['video'];
      chosenSeason = 0;
      _fetchProgress();
      _fetchEpisodes();
      fetchWatchHistory();
    }
  }
}
