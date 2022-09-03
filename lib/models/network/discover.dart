import 'package:flutter/material.dart';
import 'package:watrix/models/network/enums/languages.dart';

import '../local/enums/sort_movies.dart';
import '../local/enums/sort_tv.dart';
import 'genre.dart';

class Discover {
  String? certification;
  SortMoviesBy? sortMoviesBy;
  SortTvBy? sortTvBy;
  DateTimeRange? releaseDateRange;
  RangeValues? voteAverage;
  List<Genre> genres;
  List<Languages> languages;
  Discover({
    this.certification,
    this.sortMoviesBy,
    this.sortTvBy,
    this.releaseDateRange,
    this.voteAverage,
    List<Genre>? genres,
    List<Languages>? languages,
  })  : this.genres = genres ?? [],
        this.languages = languages ?? [];

  set setCertification(String string) {
    certification = string;
  }

  set setSortMoviesBy(SortMoviesBy sortMoviesBy) {
    this.sortMoviesBy = sortMoviesBy;
  }

  set setSortTvBy(SortTvBy sortTvBy) {
    this.sortTvBy = sortTvBy;
  }

  set setReleaseDateRange(DateTimeRange range) {
    releaseDateRange = range;
  }

  set setVoteAverage(RangeValues rangeValues) {
    voteAverage = rangeValues;
  }

  set setGenres(List<Genre> genres) {
    this.genres = genres;
  }
}
