import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:watrix/models/discover.dart';

import '../../models/base_model.dart';
import '../../screens/details_page.dart';
import '../../services/entity_type.dart';
import '../../services/requests.dart';

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

  @observable
  bool isMovieFilterApplied = false;
  @observable
  bool isTvFilterApplied = false;

  @observable
  int tabIndex = 0;

  @observable
  Discover? moviesDiscover;
  @observable
  Discover? tvDiscover;

  @observable
  List<BaseModel> filterMovies = [];
  @observable
  List<BaseModel> filterTv = [];

  @computed
  bool get isFilterApplied =>
      (tabIndex == defaultMovieIndex && isMovieFilterApplied) ||
      (tabIndex == defaultTvIndex && isTvFilterApplied);

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
      isMovieFilterApplied = true;
    } else if (tabIndex == defaultTvIndex) {
      tvDiscover = discover;
      isTvFilterApplied = true;
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
      ),
    );
  }

  @action
  void onFilterReset() {
    if (tabIndex == defaultMovieIndex) {
      //_movieFilterPage = 1;
      isMovieFilterApplied = false;
      moviesDiscover = null;
      filterMovies.clear();
    } else if (tabIndex == 2) {
//      _tvFilterPage = 1;
      isTvFilterApplied = false;
      tvDiscover = null;
      filterTv.clear();
    }
  }

  void _fetchFilteredItems(String value) async {
    List<BaseModel> list = await Requests.discoverFuture(
      type: tabIndex == defaultMovieIndex ? EntityType.movie : EntityType.tv,
      query: value,
      //page: tabIndex == 1 ? _movieFilterPage : _tvFilterPage, //TODO FIX this
      page: 1,
    );
    if (tabIndex == defaultMovieIndex) {
      filterMovies = [
        ...filterMovies,
      ];
      filterMovies.clear();
      filterMovies.addAll(list);
    } else if (tabIndex == defaultTvIndex) {
      filterTv = [
        ...filterTv,
      ];
      filterTv.clear();
      filterTv.addAll(list);
    }
  }

  @action
  void onItemClicked(BuildContext context, BaseModel baseModel) {
    Navigator.pushNamed(
      context,
      DetailsPage.routeName,
      arguments: baseModel,
    );
  }
}
