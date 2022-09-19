import 'package:mobx/mobx.dart';
import 'package:watrix/models/network/base_model.dart';
import 'package:watrix/models/network/enums/entity_type.dart';
import 'package:watrix/services/local/database.dart';
import 'package:watrix/services/network/trakt_oauth_client.dart';
import 'package:watrix/services/network/trakt_repository.dart';

part 'favorites_store.g.dart';

class FavoritesStore extends _FavoritesStore with _$FavoritesStore {}

abstract class _FavoritesStore with Store {
  @observable
  ObservableList<BaseModel> favorites = <BaseModel>[].asObservable();

  @observable
  int chosenFilter = 0;

  TraktRepository traktRepository = TraktRepository(client: TraktOAuthClient());
  Database localDb = Database();

  @computed
  ObservableList<BaseModel> get currentFav {
    switch (chosenFilter) {
      case 0:
        return favorites;
      case 1:
        ObservableList<BaseModel> list = favorites
            .where((element) => element.type == BaseModelType.movie)
            .toList()
            .asObservable();
        return list;
      case 2:
        ObservableList<BaseModel> list = favorites
            .where((element) => element.type == BaseModelType.tv)
            .toList()
            .asObservable();
        return list;
      default:
        throw UnimplementedError();
    }
  }

  @action
  Future fetchFavorites({bool fromApi = false}) async {
    favorites.addAll(await Database().getFavorites());

    if (fromApi) {
      localDb.updateFavorites(
          favorites: (await traktRepository.getUserFavorites())
              .map((e) => e.toFavorite())
              .toList(),
          onChange: (list) {
            favorites
              ..clear()
              ..addAll(list);
          });
    }
  }

  @action
  void changeFilter(int index) {
    chosenFilter = index;
  }

  @action
  void addFavorite(BaseModel baseModel) {
    favorites.add(baseModel);

    localDb.addToFavorites(baseModel.toFavorite());
    traktRepository.addFavorites(
        tmdbId: baseModel.id!, entityType: baseModel.type!.getEntityType());
  }

  @action
  void removeFavorite(BaseModel baseModel) {
    favorites.remove(baseModel);

    localDb.removeFromFav(baseModel.id!);
    traktRepository.removeFavorite(
        tmdbId: baseModel.id!, entityType: baseModel.type!.getEntityType());
  }
}
