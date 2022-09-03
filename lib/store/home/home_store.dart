import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import '../../models/network/base_model.dart';
import '../../models/network/discover.dart';
import '../../screens/actor_details_page.dart';
import '../../screens/details_page.dart';
import '../../models/network/enums/entity_type.dart';
import '../../services/network/repository.dart';
import '../../services/network/requests.dart';

part 'home_store.g.dart';

class HomeStore extends _HomeStore with _$HomeStore {
  HomeStore({required int defaultMovieIndex, required int defaultTvIndex})
      : super(
            defaultMovieIndex: defaultMovieIndex,
            defaultTvIndex: defaultTvIndex);
}

abstract class _HomeStore with Store {
  final int defaultMovieIndex, defaultTvIndex;

  _HomeStore({required this.defaultMovieIndex, required this.defaultTvIndex});

  static ObservableFuture<List<BaseModel>> emptyResponse =
      ObservableFuture.value([]);

  @observable
  int tabIndex = 0;
  @observable
  int filterMoviePage = 1;
  @observable
  int filterTvPage = 1;

  @observable
  Discover? moviesDiscover;
  @observable
  Discover? tvDiscover;

  @observable
  ObservableFuture<List<BaseModel>> currentFilterMovieFuture = emptyResponse;
  @observable
  ObservableFuture<List<BaseModel>> currentFilterTvFuture = emptyResponse;

  @observable
  ObservableList<BaseModel> filterMovies = <BaseModel>[].asObservable();
  @observable
  ObservableList<BaseModel> filterTv = <BaseModel>[].asObservable();

  @computed
  bool get isFilterApplied =>
      (tabIndex == defaultMovieIndex && isMovieFilterApplied) ||
      (tabIndex == defaultTvIndex && isTvFilterApplied);

  @computed
  bool get isMovieFilterApplied => currentFilterMovieFuture != emptyResponse;
  @computed
  bool get isTvFilterApplied => currentFilterTvFuture != emptyResponse;

  @computed
  EntityType? get currentType {
    if (tabIndex == defaultMovieIndex) {
      return EntityType.movie;
    } else if (tabIndex == defaultTvIndex) {
      return EntityType.tv;
    }
    return null;
  }

  @action
  void tabChanged(int index) {
    tabIndex = index;
  }

  @action
  void onFilterApplied(Discover discover) {
    if (tabIndex == defaultMovieIndex) {
      moviesDiscover = discover;
    } else if (tabIndex == defaultTvIndex) {
      tvDiscover = discover;
    }
    _fetchFilteredItems(
      Requests.discover(
        type: tabIndex == defaultMovieIndex ? EntityType.movie : EntityType.tv,
        certification: discover.certification,
        releaseDateLessThan: discover.releaseDateRange?.end,
        releaseDateMoreThan: discover.releaseDateRange?.start,
        voteAverageGreaterThan: discover.voteAverage?.start.toInt(),
        voteAverageLessThan: discover.voteAverage?.end.toInt(),
        withGenres: discover.genres,
        sortMoviesBy: discover.sortMoviesBy,
        sortTvBy: discover.sortTvBy,
        withLanguages: discover.languages,
      ),
    );
  }

  @action
  void onFilterReset() {
    if (tabIndex == defaultMovieIndex) {
      filterMoviePage = 1;
      moviesDiscover = null;
      currentFilterMovieFuture = emptyResponse;
    } else if (tabIndex == 2) {
      filterTvPage = 1;
      tvDiscover = null;
      currentFilterTvFuture = emptyResponse;
    }
  }

  @action
  void onFilterPageEndReached() {
    late Discover discover;
    if (tabIndex == defaultMovieIndex) {
      discover = moviesDiscover!;
      filterMoviePage++;
    } else {
      discover = tvDiscover!;
      filterTvPage++;
    }
    _fetchFilteredItems(
      Requests.discover(
        type: tabIndex == defaultMovieIndex ? EntityType.movie : EntityType.tv,
        certification: discover.certification,
        releaseDateLessThan: discover.releaseDateRange?.end,
        releaseDateMoreThan: discover.releaseDateRange?.start,
        voteAverageGreaterThan: discover.voteAverage?.start.toInt(),
        voteAverageLessThan: discover.voteAverage?.end.toInt(),
        withGenres: discover.genres,
        sortMoviesBy: discover.sortMoviesBy,
        sortTvBy: discover.sortTvBy,
        withLanguages: discover.languages,
      ),
      pageEndReached: true,
    );
  }

  @action
  Future _fetchFilteredItems(
    String value, {
    bool pageEndReached = false,
  }) async {
    if (tabIndex == defaultMovieIndex) {
      currentFilterMovieFuture = ObservableFuture(
        Repository.discover(
          type: EntityType.movie,
          query: value,
          page: filterMoviePage,
        ),
      );
      currentFilterMovieFuture.then((value) {
        _onFilterProcessed(pageEndReached);
      });
    } else if (tabIndex == defaultTvIndex) {
      currentFilterTvFuture = ObservableFuture(
        Repository.discover(
          type: EntityType.tv,
          query: value,
          page: filterTvPage,
        ),
      );
      currentFilterTvFuture.then((value) {
        _onFilterProcessed(pageEndReached);
      });
    }
  }

  @action
  void _onFilterProcessed(bool endPage) {
    if (endPage) {
      if (tabIndex == defaultMovieIndex &&
          currentFilterMovieFuture.status == FutureStatus.fulfilled) {
        filterMovies.addAll(currentFilterMovieFuture.value!);
        return;
      } else if (tabIndex == defaultTvIndex &&
          currentFilterTvFuture.status == FutureStatus.fulfilled) {
        filterTv.addAll(currentFilterTvFuture.value!.asObservable());
        return;
      }
    }
    if (tabIndex == defaultMovieIndex &&
        currentFilterMovieFuture.status == FutureStatus.fulfilled) {
      filterMovies.clear();
      filterMovies.addAll(currentFilterMovieFuture.value!);
      return;
    } else if (tabIndex == defaultTvIndex &&
        currentFilterTvFuture.status == FutureStatus.fulfilled) {
      filterTv.clear();
      filterTv.addAll(currentFilterTvFuture.value!);
      return;
    }
  }

  @action
  void onItemClicked(BuildContext context, BaseModel baseModel) {
    String name;
    if (baseModel.type == BaseModelType.people) {
      name = ActorDetailsPage.routeName;
    } else {
      name = DetailsPage.routeName;
    }
    Navigator.pushNamed(
      context,
      name,
      arguments: baseModel,
    );
  }
}
