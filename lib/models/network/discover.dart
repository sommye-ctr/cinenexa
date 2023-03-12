import 'package:flutter/material.dart';
import 'package:cinenexa/models/network/enums/languages.dart';

import '../local/enums/sort_movies.dart';
import '../local/enums/sort_tv.dart';
import 'genre.dart';

class Discover {
  String? certification;
  SortMoviesBy? sortMoviesBy;
  SortTvBy? sortTvBy;

  List<int> releaseYears;

  RangeValues? voteAverage;
  List<Genre> genres;
  List<Languages> languages;
  Discover({
    this.certification,
    this.sortMoviesBy,
    this.sortTvBy,
    this.voteAverage,
    List<Genre>? genres,
    List<Languages>? languages,
    List<int>? releaseYears,
  })  : this.genres = genres ?? [],
        this.languages = languages ?? [],
        this.releaseYears = releaseYears ?? [];

  set setCertification(String string) {
    certification = string;
  }

  set setSortMoviesBy(SortMoviesBy sortMoviesBy) {
    this.sortMoviesBy = sortMoviesBy;
  }

  set setSortTvBy(SortTvBy sortTvBy) {
    this.sortTvBy = sortTvBy;
  }

  set setVoteAverage(RangeValues rangeValues) {
    voteAverage = rangeValues;
  }

  set setGenres(List<Genre> genres) {
    this.genres = genres;
  }

  set setReleaseYears(List<int> years) {
    this.releaseYears = releaseYears;
  }
}
