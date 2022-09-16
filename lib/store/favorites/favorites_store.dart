import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:watrix/models/network/base_model.dart';
import 'package:watrix/models/network/enums/entity_type.dart';
import 'package:watrix/screens/details_page.dart';
import 'package:watrix/services/local/database.dart';
import 'package:watrix/services/network/trakt_oauth_client.dart';
import 'package:watrix/services/network/trakt_repository.dart';

part 'favorites_store.g.dart';

class FavoritesStore extends _FavoritesStore with _$FavoritesStore {}

abstract class _FavoritesStore with Store {
  @observable
  ObservableList<BaseModel> _favorites = <BaseModel>[].asObservable();

  TraktRepository traktRepository = TraktRepository(client: TraktOAuthClient());
  Database localDb = Database();

  @computed
  ObservableList<BaseModel> get currentFav {
    switch (selectedFilter) {
      case EntityType.all:
        return _favorites;
      case EntityType.movie:
        return _favorites
            .where((element) => element.type == BaseModelType.movie)
            .toList()
            .asObservable();
      case EntityType.tv:
        return _favorites
            .where((element) => element.type == BaseModelType.tv)
            .toList()
            .asObservable();
      default:
        throw UnimplementedError();
    }
  }

  @observable
  EntityType selectedFilter = EntityType.all;

  @action
  Future fetchFavorites() async {
    _favorites.addAll(await Database().getFavorites());
    localDb.updateFavorites(
        favorites: (await traktRepository.getUserFavorites())
            .map((e) => e.toFavorite())
            .toList(),
        onChange: (list) {
          _favorites
            ..clear()
            ..addAll(list);
        });
  }

  @action
  void addFavorite(BaseModel baseModel) {
    _favorites.add(baseModel);
    localDb.addToFavorites(baseModel.toFavorite());
    traktRepository.addFavorites(
        tmdbId: baseModel.id!, entityType: baseModel.type!.getEntityType());
  }

  @action
  void removeFavorite(BaseModel baseModel) {
    _favorites.remove(baseModel);
    localDb.removeFromFav(baseModel.id!);
    traktRepository.removeFavorite(
        tmdbId: baseModel.id!, entityType: baseModel.type!.getEntityType());
  }

  @action
  void itemClicked(BuildContext context, BaseModel baseModel) {
    Navigator.pushNamed(context, DetailsPage.routeName, arguments: baseModel);
  }
}
