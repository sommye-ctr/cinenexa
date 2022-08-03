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

  late final _$_favoritesAtom =
      Atom(name: '_FavoritesStore._favorites', context: context);

  @override
  ObservableList<BaseModel> get _favorites {
    _$_favoritesAtom.reportRead();
    return super._favorites;
  }

  @override
  set _favorites(ObservableList<BaseModel> value) {
    _$_favoritesAtom.reportWrite(value, super._favorites, () {
      super._favorites = value;
    });
  }

  late final _$selectedFilterAtom =
      Atom(name: '_FavoritesStore.selectedFilter', context: context);

  @override
  EntityType get selectedFilter {
    _$selectedFilterAtom.reportRead();
    return super.selectedFilter;
  }

  @override
  set selectedFilter(EntityType value) {
    _$selectedFilterAtom.reportWrite(value, super.selectedFilter, () {
      super.selectedFilter = value;
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
selectedFilter: ${selectedFilter},
currentFav: ${currentFav}
    ''';
  }
}
