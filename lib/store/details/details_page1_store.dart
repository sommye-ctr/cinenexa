import 'package:mobx/mobx.dart';

import '../../models/genre.dart';

part 'details_page1_store.g.dart';

class DetailsPage1Store extends _DetailsPage1Store with _$DetailsPage1Store {}

abstract class _DetailsPage1Store with Store {
  @observable
  List<Genre> genres = [];

  @observable
  String? releaseDate;

  @observable
  String? tvShowEndTime;

  @observable
  int? runtime;

  @action
  void setGenres(List<Genre> data) {
    genres = data;
  }

  @action
  void setReleaseDate(String? releaseDate) {
    this.releaseDate = releaseDate;
  }

  @action
  void setTvShowEndTime(String? date) {
    tvShowEndTime = date;
  }

  @action
  void setRuntime(int? runtime) {
    this.runtime = runtime;
  }
}
