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
  Future<dynamic> fetchFavorites() {
    return _$fetchFavoritesAsyncAction.run(() => super.fetchFavorites());
  }

  late final _$_FavoritesStoreActionController =
      ActionController(name: '_FavoritesStore', context: context);

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
  void addFavorite(BaseModel baseModel) {
    final _$actionInfo = _$_FavoritesStoreActionController.startAction(
        name: '_FavoritesStore.addFavorite');
    try {
      return super.addFavorite(baseModel);
    } finally {
      _$_FavoritesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeFavorite(BaseModel baseModel) {
    final _$actionInfo = _$_FavoritesStoreActionController.startAction(
        name: '_FavoritesStore.removeFavorite');
    try {
      return super.removeFavorite(baseModel);
    } finally {
      _$_FavoritesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void itemClicked(BuildContext context, BaseModel baseModel) {
    final _$actionInfo = _$_FavoritesStoreActionController.startAction(
        name: '_FavoritesStore.itemClicked');
    try {
      return super.itemClicked(context, baseModel);
    } finally {
      _$_FavoritesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
favorites: ${favorites},
chosenFilter: ${chosenFilter},
currentFav: ${currentFav}
    ''';
  }
}
