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
  List<BaseModel> get filterMovies {
    _$filterMoviesAtom.reportRead();
    return super.filterMovies;
  }

  @override
  set filterMovies(List<BaseModel> value) {
    _$filterMoviesAtom.reportWrite(value, super.filterMovies, () {
      super.filterMovies = value;
    });
  }

  final _$filterTvAtom = Atom(name: '_HomeStore.filterTv');

  @override
  List<BaseModel> get filterTv {
    _$filterTvAtom.reportRead();
    return super.filterTv;
  }

  @override
  set filterTv(List<BaseModel> value) {
    _$filterTvAtom.reportWrite(value, super.filterTv, () {
      super.filterTv = value;
    });
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
  String toString() {
    return '''
isMovieFilterApplied: ${isMovieFilterApplied},
isTvFilterApplied: ${isTvFilterApplied},
tabIndex: ${tabIndex},
moviesDiscover: ${moviesDiscover},
tvDiscover: ${tvDiscover},
filterMovies: ${filterMovies},
filterTv: ${filterTv},
isFilterApplied: ${isFilterApplied}
    ''';
  }
}
