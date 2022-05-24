// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeStore on _HomeStore, Store {
  Computed<bool>? _$isFilterAppliedComputed;

  @override
  bool get isFilterApplied =>
      (_$isFilterAppliedComputed ??= Computed<bool>(() => super.isFilterApplied,
              name: '_HomeStore.isFilterApplied'))
          .value;
  Computed<EntityType?>? _$currentTypeComputed;

  @override
  EntityType? get currentType =>
      (_$currentTypeComputed ??= Computed<EntityType?>(() => super.currentType,
              name: '_HomeStore.currentType'))
          .value;

  final _$isMovieFilterAppliedAtom =
      Atom(name: '_HomeStore.isMovieFilterApplied');

  @override
  bool get isMovieFilterApplied {
    _$isMovieFilterAppliedAtom.reportRead();
    return super.isMovieFilterApplied;
  }

  @override
  set isMovieFilterApplied(bool value) {
    _$isMovieFilterAppliedAtom.reportWrite(value, super.isMovieFilterApplied,
        () {
      super.isMovieFilterApplied = value;
    });
  }

  final _$isTvFilterAppliedAtom = Atom(name: '_HomeStore.isTvFilterApplied');

  @override
  bool get isTvFilterApplied {
    _$isTvFilterAppliedAtom.reportRead();
    return super.isTvFilterApplied;
  }

  @override
  set isTvFilterApplied(bool value) {
    _$isTvFilterAppliedAtom.reportWrite(value, super.isTvFilterApplied, () {
      super.isTvFilterApplied = value;
    });
  }

  final _$tabIndexAtom = Atom(name: '_HomeStore.tabIndex');

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

  final _$filterMoviePageAtom = Atom(name: '_HomeStore.filterMoviePage');

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

  final _$filterTvPageAtom = Atom(name: '_HomeStore.filterTvPage');

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

  final _$moviesDiscoverAtom = Atom(name: '_HomeStore.moviesDiscover');

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

  final _$tvDiscoverAtom = Atom(name: '_HomeStore.tvDiscover');

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

  final _$filterMoviesAtom = Atom(name: '_HomeStore.filterMovies');

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

  final _$filterTvAtom = Atom(name: '_HomeStore.filterTv');

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

  final _$_fetchFilteredItemsAsyncAction =
      AsyncAction('_HomeStore._fetchFilteredItems');

  @override
  Future _fetchFilteredItems(String value, {bool pageEndReached = false}) {
    return _$_fetchFilteredItemsAsyncAction.run(
        () => super._fetchFilteredItems(value, pageEndReached: pageEndReached));
  }

  final _$_HomeStoreActionController = ActionController(name: '_HomeStore');

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
isMovieFilterApplied: ${isMovieFilterApplied},
isTvFilterApplied: ${isTvFilterApplied},
tabIndex: ${tabIndex},
filterMoviePage: ${filterMoviePage},
filterTvPage: ${filterTvPage},
moviesDiscover: ${moviesDiscover},
tvDiscover: ${tvDiscover},
filterMovies: ${filterMovies},
filterTv: ${filterTv},
isFilterApplied: ${isFilterApplied},
currentType: ${currentType}
    ''';
  }
}
