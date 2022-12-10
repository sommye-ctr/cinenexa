// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorites_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FavoritesStore on _FavoritesStore, Store {
  Computed<ObservableList<BaseModel>>? _$currentFavComputed;

  @override
  ObservableList<BaseModel> get currentFav => (_$currentFavComputed ??=
          Computed<ObservableList<BaseModel>>(() => super.currentFav,
              name: '_FavoritesStore.currentFav'))
      .value;

  late final _$favoritesAtom =
      Atom(name: '_FavoritesStore.favorites', context: context);

  @override
  ObservableList<BaseModel> get favorites {
    _$favoritesAtom.reportRead();
    return super.favorites;
  }

  @override
  set favorites(ObservableList<BaseModel> value) {
    _$favoritesAtom.reportWrite(value, super.favorites, () {
      super.favorites = value;
    });
  }

  late final _$checkedFavoritesIdsAtom =
      Atom(name: '_FavoritesStore.checkedFavoritesIds', context: context);

  @override
  ObservableList<int> get checkedFavoritesIds {
    _$checkedFavoritesIdsAtom.reportRead();
    return super.checkedFavoritesIds;
  }

  @override
  set checkedFavoritesIds(ObservableList<int> value) {
    _$checkedFavoritesIdsAtom.reportWrite(value, super.checkedFavoritesIds, () {
      super.checkedFavoritesIds = value;
    });
  }

  late final _$multiSelectEnabledAtom =
      Atom(name: '_FavoritesStore.multiSelectEnabled', context: context);

  @override
  bool get multiSelectEnabled {
    _$multiSelectEnabledAtom.reportRead();
    return super.multiSelectEnabled;
  }

  @override
  set multiSelectEnabled(bool value) {
    _$multiSelectEnabledAtom.reportWrite(value, super.multiSelectEnabled, () {
      super.multiSelectEnabled = value;
    });
  }

  late final _$chosenFilterAtom =
      Atom(name: '_FavoritesStore.chosenFilter', context: context);

  @override
  int get chosenFilter {
    _$chosenFilterAtom.reportRead();
    return super.chosenFilter;
  }

  @override
  set chosenFilter(int value) {
    _$chosenFilterAtom.reportWrite(value, super.chosenFilter, () {
      super.chosenFilter = value;
    });
  }

  late final _$fetchFavoritesAsyncAction =
      AsyncAction('_FavoritesStore.fetchFavorites', context: context);

  @override
  Future<dynamic> fetchFavorites({bool fromApi = false}) {
    return _$fetchFavoritesAsyncAction
        .run(() => super.fetchFavorites(fromApi: fromApi));
  }

  late final _$addFavoriteAsyncAction =
      AsyncAction('_FavoritesStore.addFavorite', context: context);

  @override
  Future<dynamic> addFavorite(BaseModel baseModel, UserStore userStore) {
    return _$addFavoriteAsyncAction
        .run(() => super.addFavorite(baseModel, userStore));
  }

  late final _$removeFavoritesAsyncAction =
      AsyncAction('_FavoritesStore.removeFavorites', context: context);

  @override
  Future<dynamic> removeFavorites(UserStore userStore) {
    return _$removeFavoritesAsyncAction
        .run(() => super.removeFavorites(userStore));
  }

  late final _$removeFavoriteAsyncAction =
      AsyncAction('_FavoritesStore.removeFavorite', context: context);

  @override
  Future<dynamic> removeFavorite(BaseModel baseModel, UserStore userStore) {
    return _$removeFavoriteAsyncAction
        .run(() => super.removeFavorite(baseModel, userStore));
  }

  late final _$_FavoritesStoreActionController =
      ActionController(name: '_FavoritesStore', context: context);

  @override
  void setMultiSelectEnabled(bool newMultiSelectEnabled) {
    final _$actionInfo = _$_FavoritesStoreActionController.startAction(
        name: '_FavoritesStore.setMultiSelectEnabled');
    try {
      return super.setMultiSelectEnabled(newMultiSelectEnabled);
    } finally {
      _$_FavoritesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeFilter(int index) {
    final _$actionInfo = _$_FavoritesStoreActionController.startAction(
        name: '_FavoritesStore.changeFilter');
    try {
      return super.changeFilter(index);
    } finally {
      _$_FavoritesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addCheckedFav({required int id}) {
    final _$actionInfo = _$_FavoritesStoreActionController.startAction(
        name: '_FavoritesStore.addCheckedFav');
    try {
      return super.addCheckedFav(id: id);
    } finally {
      _$_FavoritesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeCheckedFav({required int id}) {
    final _$actionInfo = _$_FavoritesStoreActionController.startAction(
        name: '_FavoritesStore.removeCheckedFav');
    try {
      return super.removeCheckedFav(id: id);
    } finally {
      _$_FavoritesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetMultiSelect() {
    final _$actionInfo = _$_FavoritesStoreActionController.startAction(
        name: '_FavoritesStore.resetMultiSelect');
    try {
      return super.resetMultiSelect();
    } finally {
      _$_FavoritesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
favorites: ${favorites},
checkedFavoritesIds: ${checkedFavoritesIds},
multiSelectEnabled: ${multiSelectEnabled},
chosenFilter: ${chosenFilter},
currentFav: ${currentFav}
    ''';
  }
}
