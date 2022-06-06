// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'details_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$DetailsStore on _DetailsStore, Store {
  Computed<List<Genre>?>? _$genresComputed;

  @override
  List<Genre>? get genres =>
      (_$genresComputed ??= Computed<List<Genre>?>(() => super.genres,
              name: '_DetailsStore.genres'))
          .value;

  final _$pageIndexAtom = Atom(name: '_DetailsStore.pageIndex');

  @override
  int get pageIndex {
    _$pageIndexAtom.reportRead();
    return super.pageIndex;
  }

  @override
  set pageIndex(int value) {
    _$pageIndexAtom.reportWrite(value, super.pageIndex, () {
      super.pageIndex = value;
    });
  }

  final _$movieAtom = Atom(name: '_DetailsStore.movie');

  @override
  Movie? get movie {
    _$movieAtom.reportRead();
    return super.movie;
  }

  @override
  set movie(Movie? value) {
    _$movieAtom.reportWrite(value, super.movie, () {
      super.movie = value;
    });
  }

  final _$tvAtom = Atom(name: '_DetailsStore.tv');

  @override
  Tv? get tv {
    _$tvAtom.reportRead();
    return super.tv;
  }

  @override
  set tv(Tv? value) {
    _$tvAtom.reportWrite(value, super.tv, () {
      super.tv = value;
    });
  }

  final _$creditsAtom = Atom(name: '_DetailsStore.credits');

  @override
  ObservableList<BaseModel> get credits {
    _$creditsAtom.reportRead();
    return super.credits;
  }

  @override
  set credits(ObservableList<BaseModel> value) {
    _$creditsAtom.reportWrite(value, super.credits, () {
      super.credits = value;
    });
  }

  final _$recommendedAtom = Atom(name: '_DetailsStore.recommended');

  @override
  ObservableList<BaseModel> get recommended {
    _$recommendedAtom.reportRead();
    return super.recommended;
  }

  @override
  set recommended(ObservableList<BaseModel> value) {
    _$recommendedAtom.reportWrite(value, super.recommended, () {
      super.recommended = value;
    });
  }

  final _$episodesAtom = Atom(name: '_DetailsStore.episodes');

  @override
  ObservableList<TvEpisode> get episodes {
    _$episodesAtom.reportRead();
    return super.episodes;
  }

  @override
  set episodes(ObservableList<TvEpisode> value) {
    _$episodesAtom.reportWrite(value, super.episodes, () {
      super.episodes = value;
    });
  }

  final _$chosenSeasonAtom = Atom(name: '_DetailsStore.chosenSeason');

  @override
  TvSeason? get chosenSeason {
    _$chosenSeasonAtom.reportRead();
    return super.chosenSeason;
  }

  @override
  set chosenSeason(TvSeason? value) {
    _$chosenSeasonAtom.reportWrite(value, super.chosenSeason, () {
      super.chosenSeason = value;
    });
  }

  final _$_DetailsStoreActionController =
      ActionController(name: '_DetailsStore');

  @override
  void onPageChanged(int index) {
    final _$actionInfo = _$_DetailsStoreActionController.startAction(
        name: '_DetailsStore.onPageChanged');
    try {
      return super.onPageChanged(index);
    } finally {
      _$_DetailsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onSeasonChanged(TvSeason tvSeason) {
    final _$actionInfo = _$_DetailsStoreActionController.startAction(
        name: '_DetailsStore.onSeasonChanged');
    try {
      return super.onSeasonChanged(tvSeason);
    } finally {
      _$_DetailsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
pageIndex: ${pageIndex},
movie: ${movie},
tv: ${tv},
credits: ${credits},
recommended: ${recommended},
episodes: ${episodes},
chosenSeason: ${chosenSeason},
genres: ${genres}
    ''';
  }
}
