import 'package:mobx/mobx.dart';
import 'package:watrix/models/base_model.dart';
import 'package:watrix/models/movie.dart';
import 'package:watrix/models/tv.dart';
import 'package:watrix/store/details/details_page1_store.dart';

import '../../services/requests.dart';

part 'details_store.g.dart';

class DetailsStore extends _DetailsStore with _$DetailsStore {
  DetailsStore({required BaseModel baseModel}) : super(baseModel: baseModel);
}

abstract class _DetailsStore with Store {
  final BaseModel baseModel;
  final DetailsPage1Store page1 = DetailsPage1Store();

  _DetailsStore({required this.baseModel}) {
    page1.setReleaseDate(baseModel.releaseDate);
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
  ObservableList<BaseModel> recommendedMovies = <BaseModel>[].asObservable();

  @action
  void onPageChanged(int index) {
    pageIndex = index;
  }

  void _fetchDetails() async {
    if (baseModel.type == BaseModelType.movie) {
      Map map = await Requests.getMovieDetails(id: baseModel.id!);
      movie = map['movie'];
      credits.addAll(map['credits']);
      recommendedMovies.addAll(map['recommended']);
      page1.setGenres(movie?.genres ?? []);
      page1.setRuntime(movie?.runtime);
    } else if (baseModel.type == BaseModelType.tv) {
      tv = await Requests.findTv(id: baseModel.id!);
      page1.setGenres(tv?.genres ?? []);
      page1.setTvShowEndTime(tv?.lastAirDate);
    }
  }
}
