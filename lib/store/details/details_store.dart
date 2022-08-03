import 'package:mobx/mobx.dart';
import 'package:watrix/services/local/database.dart';

import '../../models/network/base_model.dart';
import '../../models/network/genre.dart';
import '../../models/network/movie.dart';
import '../../models/network/tv.dart';
import '../../models/network/tv_episode.dart';
import '../../models/network/tv_season.dart';
import '../../models/network/video.dart';
import '../../services/network/requests.dart';
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
  TvSeason? chosenSeason;

  @observable
  bool isAddedToFav = false;

  @observable
  Video? video;

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
  void onSeasonChanged(TvSeason tvSeason) {
    chosenSeason = tvSeason;
    _fetchEpisodes();
  }

  void _fetchEpisodes() async {
    List<TvEpisode> latest = await Requests.getSeasonEpisodes(
      tvId: baseModel.id!,
      seasonNo: chosenSeason!.seasonNumber,
    );
    episodes.clear();
    episodes.addAll(latest);
  }

  void _fetchDetails() async {
    isAddedToFav = await database.isAddedInFav(baseModel.id!);
    if (baseModel.type == BaseModelType.movie) {
      Map map = await Requests.getMovieDetails(id: baseModel.id!);
      movie = map['movie'];
      credits.addAll(map['credits']);
      recommended.addAll(map['recommended']);
      video = map['video'];
    } else if (baseModel.type == BaseModelType.tv) {
      Map map = await Requests.getTvDetails(id: baseModel.id!);
      tv = map['tv'];
      credits.addAll(map['credits']);
      recommended.addAll(map['recommended']);
      video = map['video'];
      chosenSeason = tv!.seasons![0];
      _fetchEpisodes();
    }
  }
}
