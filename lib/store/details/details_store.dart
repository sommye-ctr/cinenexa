import 'package:mobx/mobx.dart';
import 'package:watrix/models/network/review.dart';
import 'package:watrix/services/local/database.dart';
import 'package:watrix/services/network/requests.dart';

import '../../models/network/base_model.dart';
import '../../models/network/genre.dart';
import '../../models/network/movie.dart';
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

  _DetailsStore({required this.baseModel}) {
    _fetchDetails();
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

  @computed
  int get totalReviews {
    if (reviews.status == FutureStatus.fulfilled && reviews.value != null) {
      return reviews.value!['total'];
    }
    return 0;
  }

  @computed
  List<Review> get reviewList {
    if (reviews.status == FutureStatus.fulfilled &&
        reviews.value != null &&
        reviews.value!['results'] != null) {
      return reviews.value!['results'];
    }
    return [];
  }

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
  void addToListClicked(FavoritesStore store) {
    database.addToFavorites(baseModel.toFavorite());
    isAddedToFav = true;
    store.addFavorite(baseModel);
  }

  @action
  void removeFromListCLicked(FavoritesStore store) {
    database.removeFromFav(baseModel.id!);
    isAddedToFav = false;
    store.removeFavorite(baseModel);
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

  void _fetchEpisodes() async {
    List<TvEpisode> latest = await Repository.getSeasonEpisodes(
      tvId: baseModel.id!,
      seasonNo: tv!.seasons![chosenSeason!].seasonNumber,
    );
    episodes.clear();
    episodes.addAll(latest);
  }

  @action
  Future fetchReviews() async {
    reviews = Repository.getReviews(
      query: Requests.reviews(baseModel.type!, baseModel.id!),
    ).asObservable();
  }

  void _fetchDetails() async {
    isAddedToFav = await database.isAddedInFav(baseModel.id!);
    if (baseModel.type == BaseModelType.movie) {
      Map map = await Repository.getMovieDetails(id: baseModel.id!);
      movie = map['movie'];
      credits.addAll(map['credits']);
      recommended.addAll(map['recommended']);
      video = map['video'];
    } else if (baseModel.type == BaseModelType.tv) {
      Map map = await Repository.getTvDetails(id: baseModel.id!);
      tv = map['tv'];
      credits.addAll(map['credits']);
      recommended.addAll(map['recommended']);
      video = map['video'];
      chosenSeason = 0;
      _fetchEpisodes();
    }
  }
}
