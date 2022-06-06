import 'package:mobx/mobx.dart';
import 'package:watrix/models/base_model.dart';
import 'package:watrix/models/genre.dart';
import 'package:watrix/models/movie.dart';
import 'package:watrix/models/tv.dart';
import 'package:watrix/models/tv_episode.dart';
import 'package:watrix/models/tv_season.dart';

import '../../services/requests.dart';

part 'details_store.g.dart';

class DetailsStore extends _DetailsStore with _$DetailsStore {
  DetailsStore({required BaseModel baseModel}) : super(baseModel: baseModel);
}

abstract class _DetailsStore with Store {
  final BaseModel baseModel;

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
    if (baseModel.type == BaseModelType.movie) {
      Map map = await Requests.getMovieDetails(id: baseModel.id!);
      movie = map['movie'];
      credits.addAll(map['credits']);
      recommended.addAll(map['recommended']);
    } else if (baseModel.type == BaseModelType.tv) {
      Map map = await Requests.getTvDetails(id: baseModel.id!);
      tv = map['tv'];
      credits.addAll(map['credits']);
      recommended.addAll(map['recommended']);
      chosenSeason = tv!.seasons![0];
      _fetchEpisodes();
    }
  }
}
