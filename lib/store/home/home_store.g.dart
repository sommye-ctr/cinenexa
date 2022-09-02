// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeStore on _HomeStore, Store {
  Computed<bool>? _$isFilterAppliedComputed;

  @override
  bool get isFilterApplied =>
      (_$isFilterAppliedComputed ??= Computed<bool>(() => super.isFilterApplied,
              name: '_HomeStore.isFilterApplied'))
          .value;
  Computed<bool>? _$isMovieFilterAppliedComputed;

  @override
  bool get isMovieFilterApplied => (_$isMovieFilterAppliedComputed ??=
          Computed<bool>(() => super.isMovieFilterApplied,
              name: '_HomeStore.isMovieFilterApplied'))
      .value;
  Computed<bool>? _$isTvFilterAppliedComputed;

  @override
  bool get isTvFilterApplied => (_$isTvFilterAppliedComputed ??= Computed<bool>(
          () => super.isTvFilterApplied,
          name: '_HomeStore.isTvFilterApplied'))
      .value;
  Computed<EntityType?>? _$currentTypeComputed;

  @override
  EntityType? get currentType =>
      (_$currentTypeComputed ??= Computed<EntityType?>(() => super.currentType,
              name: '_HomeStore.currentType'))
          .value;

  late final _$tabIndexAtom =
      Atom(name: '_HomeStore.tabIndex', context: context);

  @override
  int get tabIndex {
    _$tabIndexAtom.reportRead();
    return super.tabIndex;
  }

  @override
  set tabIndex(int value) {
    _$tabIndexAtom.reportWrite(value, super.tabIndex, () {
      super.tabIndex = value;
    });
  }

  late final _$filterMoviePageAtom =
      Atom(name: '_HomeStore.filterMoviePage', context: context);

  @override
  int get filterMoviePage {
    _$filterMoviePageAtom.reportRead();
    return super.filterMoviePage;
  }

  @override
  set filterMoviePage(int value) {
    _$filterMoviePageAtom.reportWrite(value, super.filterMoviePage, () {
      super.filterMoviePage = value;
    });
  }

  late final _$filterTvPageAtom =
      Atom(name: '_HomeStore.filterTvPage', context: context);

  @override
  int get filterTvPage {
    _$filterTvPageAtom.reportRead();
    return super.filterTvPage;
  }

  @override
  set filterTvPage(int value) {
    _$filterTvPageAtom.reportWrite(value, super.filterTvPage, () {
      super.filterTvPage = value;
    });
  }

  late final _$moviesDiscoverAtom =
      Atom(name: '_HomeStore.moviesDiscover', context: context);

  @override
  Discover? get moviesDiscover {
    _$moviesDiscoverAtom.reportRead();
    return super.moviesDiscover;
  }

  @override
  set moviesDiscover(Discover? value) {
    _$moviesDiscoverAtom.reportWrite(value, super.moviesDiscover, () {
      super.moviesDiscover = value;
    });
  }

  late final _$tvDiscoverAtom =
      Atom(name: '_HomeStore.tvDiscover', context: context);

  @override
  Discover? get tvDiscover {
    _$tvDiscoverAtom.reportRead();
    return super.tvDiscover;
  }

  @override
  set tvDiscover(Discover? value) {
    _$tvDiscoverAtom.reportWrite(value, super.tvDiscover, () {
      super.tvDiscover = value;
    });
  }

  late final _$currentFilterMovieFutureAtom =
      Atom(name: '_HomeStore.currentFilterMovieFuture', context: context);

  @override
  ObservableFuture<List<BaseModel>> get currentFilterMovieFuture {
    _$currentFilterMovieFutureAtom.reportRead();
    return super.currentFilterMovieFuture;
  }

  @override
  set currentFilterMovieFuture(ObservableFuture<List<BaseModel>> value) {
    _$currentFilterMovieFutureAtom
        .reportWrite(value, super.currentFilterMovieFuture, () {
      super.currentFilterMovieFuture = value;
    });
  }

  late final _$currentFilterTvFutureAtom =
      Atom(name: '_HomeStore.currentFilterTvFuture', context: context);

  @override
  ObservableFuture<List<BaseModel>> get currentFilterTvFuture {
    _$currentFilterTvFutureAtom.reportRead();
    return super.currentFilterTvFuture;
  }

  @override
  set currentFilterTvFuture(ObservableFuture<List<BaseModel>> value) {
    _$currentFilterTvFutureAtom.reportWrite(value, super.currentFilterTvFuture,
        () {
      super.currentFilterTvFuture = value;
    });
  }

  late final _$filterMoviesAtom =
      Atom(name: '_HomeStore.filterMovies', context: context);

  @override
  ObservableList<BaseModel> get filterMovies {
    _$filterMoviesAtom.reportRead();
    return super.filterMovies;
  }

  @override
  set filterMovies(ObservableList<BaseModel> value) {
    _$filterMoviesAtom.reportWrite(value, super.filterMovies, () {
      super.filterMovies = value;
    });
  }

  late final _$filterTvAtom =
      Atom(name: '_HomeStore.filterTv', context: context);

  @override
  ObservableList<BaseModel> get filterTv {
    _$filterTvAtom.reportRead();
    return super.filterTv;
  }

  @override
  set filterTv(ObservableList<BaseModel> value) {
    _$filterTvAtom.reportWrite(value, super.filterTv, () {
      super.filterTv = value;
    });
  }

  late final _$_fetchFilteredItemsAsyncAction =
      AsyncAction('_HomeStore._fetchFilteredItems', context: context);

  @override
  Future<dynamic> _fetchFilteredItems(String value,
      {bool pageEndReached = false}) {
    return _$_fetchFilteredItemsAsyncAction.run(
        () => super._fetchFilteredItems(value, pageEndReached: pageEndReached));
  }

  late final _$_HomeStoreActionController =
      ActionController(name: '_HomeStore', context: context);

  @override
  void tabChanged(int index) {
    final _$actionInfo =
        _$_HomeStoreActionController.startAction(name: '_HomeStore.tabChanged');
    try {
      return super.tabChanged(index);
    } finally {
      _$_HomeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onFilterApplied(Discover discover) {
    final _$actionInfo = _$_HomeStoreActionController.startAction(
        name: '_HomeStore.onFilterApplied');
    try {
      return super.onFilterApplied(discover);
    } finally {
      _$_HomeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onFilterReset() {
    final _$actionInfo = _$_HomeStoreActionController.startAction(
        name: '_HomeStore.onFilterReset');
    try {
      return super.onFilterReset();
    } finally {
      _$_HomeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onFilterPageEndReached() {
    final _$actionInfo = _$_HomeStoreActionController.startAction(
        name: '_HomeStore.onFilterPageEndReached');
    try {
      return super.onFilterPageEndReached();
    } finally {
      _$_HomeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _onFilterProcessed(bool endPage) {
    final _$actionInfo = _$_HomeStoreActionController.startAction(
        name: '_HomeStore._onFilterProcessed');
    try {
      return super._onFilterProcessed(endPage);
    } finally {
      _$_HomeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onItemClicked(BuildContext context, BaseModel baseModel) {
    final _$actionInfo = _$_HomeStoreActionController.startAction(
        name: '_HomeStore.onItemClicked');
    try {
      return super.onItemClicked(context, baseModel);
    } finally {
      _$_HomeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
tabIndex: ${tabIndex},
filterMoviePage: ${filterMoviePage},
filterTvPage: ${filterTvPage},
moviesDiscover: ${moviesDiscover},
tvDiscover: ${tvDiscover},
currentFilterMovieFuture: ${currentFilterMovieFuture},
currentFilterTvFuture: ${currentFilterTvFuture},
filterMovies: ${filterMovies},
filterTv: ${filterTv},
isFilterApplied: ${isFilterApplied},
isMovieFilterApplied: ${isMovieFilterApplied},
isTvFilterApplied: ${isTvFilterApplied},
currentType: ${currentType}
    ''';
  }
}
