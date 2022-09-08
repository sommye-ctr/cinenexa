// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'details_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DetailsStore on _DetailsStore, Store {
  Computed<int>? _$totalReviewsComputed;

  @override
  int get totalReviews =>
      (_$totalReviewsComputed ??= Computed<int>(() => super.totalReviews,
              name: '_DetailsStore.totalReviews'))
          .value;
  Computed<List<Genre>?>? _$genresComputed;

  @override
  List<Genre>? get genres =>
      (_$genresComputed ??= Computed<List<Genre>?>(() => super.genres,
              name: '_DetailsStore.genres'))
          .value;

  late final _$pageIndexAtom =
      Atom(name: '_DetailsStore.pageIndex', context: context);

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

  late final _$movieAtom = Atom(name: '_DetailsStore.movie', context: context);

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

  late final _$tvAtom = Atom(name: '_DetailsStore.tv', context: context);

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

  late final _$creditsAtom =
      Atom(name: '_DetailsStore.credits', context: context);

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

  late final _$recommendedAtom =
      Atom(name: '_DetailsStore.recommended', context: context);

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

  late final _$episodesAtom =
      Atom(name: '_DetailsStore.episodes', context: context);

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

  late final _$reviewsAtom =
      Atom(name: '_DetailsStore.reviews', context: context);

  @override
  ObservableFuture<Map<dynamic, dynamic>> get reviews {
    _$reviewsAtom.reportRead();
    return super.reviews;
  }

  @override
  set reviews(ObservableFuture<Map<dynamic, dynamic>> value) {
    _$reviewsAtom.reportWrite(value, super.reviews, () {
      super.reviews = value;
    });
  }

  late final _$chosenSeasonAtom =
      Atom(name: '_DetailsStore.chosenSeason', context: context);

  @override
  int? get chosenSeason {
    _$chosenSeasonAtom.reportRead();
    return super.chosenSeason;
  }

  @override
  set chosenSeason(int? value) {
    _$chosenSeasonAtom.reportWrite(value, super.chosenSeason, () {
      super.chosenSeason = value;
    });
  }

  late final _$isAddedToFavAtom =
      Atom(name: '_DetailsStore.isAddedToFav', context: context);

  @override
  bool get isAddedToFav {
    _$isAddedToFavAtom.reportRead();
    return super.isAddedToFav;
  }

  @override
  set isAddedToFav(bool value) {
    _$isAddedToFavAtom.reportWrite(value, super.isAddedToFav, () {
      super.isAddedToFav = value;
    });
  }

  late final _$videoAtom = Atom(name: '_DetailsStore.video', context: context);

  @override
  Video? get video {
    _$videoAtom.reportRead();
    return super.video;
  }

  @override
  set video(Video? value) {
    _$videoAtom.reportWrite(value, super.video, () {
      super.video = value;
    });
  }

  late final _$chosenEpisodeAtom =
      Atom(name: '_DetailsStore.chosenEpisode', context: context);

  @override
  int? get chosenEpisode {
    _$chosenEpisodeAtom.reportRead();
    return super.chosenEpisode;
  }

  @override
  set chosenEpisode(int? value) {
    _$chosenEpisodeAtom.reportWrite(value, super.chosenEpisode, () {
      super.chosenEpisode = value;
    });
  }

  late final _$reviewListAtom =
      Atom(name: '_DetailsStore.reviewList', context: context);

  @override
  ObservableList<Review> get reviewList {
    _$reviewListAtom.reportRead();
    return super.reviewList;
  }

  @override
  set reviewList(ObservableList<Review> value) {
    _$reviewListAtom.reportWrite(value, super.reviewList, () {
      super.reviewList = value;
    });
  }

  late final _$fetchReviewsAsyncAction =
      AsyncAction('_DetailsStore.fetchReviews', context: context);

  @override
  Future<dynamic> fetchReviews() {
    return _$fetchReviewsAsyncAction.run(() => super.fetchReviews());
  }

  late final _$_DetailsStoreActionController =
      ActionController(name: '_DetailsStore', context: context);

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
  void addToListClicked(FavoritesStore store) {
    final _$actionInfo = _$_DetailsStoreActionController.startAction(
        name: '_DetailsStore.addToListClicked');
    try {
      return super.addToListClicked(store);
    } finally {
      _$_DetailsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeFromListCLicked(FavoritesStore store) {
    final _$actionInfo = _$_DetailsStoreActionController.startAction(
        name: '_DetailsStore.removeFromListCLicked');
    try {
      return super.removeFromListCLicked(store);
    } finally {
      _$_DetailsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onSeasonChanged(int index) {
    final _$actionInfo = _$_DetailsStoreActionController.startAction(
        name: '_DetailsStore.onSeasonChanged');
    try {
      return super.onSeasonChanged(index);
    } finally {
      _$_DetailsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onEpiodeClicked(int index) {
    final _$actionInfo = _$_DetailsStoreActionController.startAction(
        name: '_DetailsStore.onEpiodeClicked');
    try {
      return super.onEpiodeClicked(index);
    } finally {
      _$_DetailsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onEpBackClicked() {
    final _$actionInfo = _$_DetailsStoreActionController.startAction(
        name: '_DetailsStore.onEpBackClicked');
    try {
      return super.onEpBackClicked();
    } finally {
      _$_DetailsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onReviewEndReached() {
    final _$actionInfo = _$_DetailsStoreActionController.startAction(
        name: '_DetailsStore.onReviewEndReached');
    try {
      return super.onReviewEndReached();
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
reviews: ${reviews},
chosenSeason: ${chosenSeason},
isAddedToFav: ${isAddedToFav},
video: ${video},
chosenEpisode: ${chosenEpisode},
reviewList: ${reviewList},
totalReviews: ${totalReviews},
genres: ${genres}
    ''';
  }
}
