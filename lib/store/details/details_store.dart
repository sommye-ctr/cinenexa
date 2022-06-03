import 'package:mobx/mobx.dart';
import 'package:watrix/models/base_model.dart';
import 'package:watrix/models/genre.dart';
import 'package:watrix/models/movie.dart';
import 'package:watrix/models/tv.dart';

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
  ObservableList<BaseModel> recommendedMovies = <BaseModel>[].asObservable();

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

  void _fetchDetails() async {
    if (baseModel.type == BaseModelType.movie) {
      Map map = await Requests.getMovieDetails(id: baseModel.id!);
      movie = map['movie'];
      credits.addAll(map['credits']);
      recommendedMovies.addAll(map['recommended']);
    } else if (baseModel.type == BaseModelType.tv) {
      tv = await Requests.findTv(id: baseModel.id!);
    }
  }
}
