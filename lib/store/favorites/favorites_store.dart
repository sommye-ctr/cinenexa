import 'package:mobx/mobx.dart';
import 'package:watrix/models/network/base_model.dart';
import 'package:watrix/models/network/enums/entity_type.dart';
import 'package:watrix/services/local/database.dart';
import 'package:watrix/services/network/trakt_oauth_client.dart';
import 'package:watrix/services/network/trakt_repository.dart';
import 'package:watrix/store/user/user_store.dart';

part 'favorites_store.g.dart';

class FavoritesStore extends _FavoritesStore with _$FavoritesStore {}

abstract class _FavoritesStore with Store {
  @observable
  ObservableList<BaseModel> favorites = <BaseModel>[].asObservable();

  @observable
  ObservableList<int> checkedFavoritesIds = <int>[].asObservable();

  @observable
  bool multiSelectEnabled = false;

  @action
  void setMultiSelectEnabled(bool newMultiSelectEnabled) {
    multiSelectEnabled = newMultiSelectEnabled;
  }

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
      traktRepository.getUserFavorites().then((value) {
        localDb.updateFavorites(
            favorites: value.map((e) => e.toFavorite()).toList(),
            onChange: (list) {
              favorites
                ..clear()
                ..addAll(list);
            });
      });
    }
  }

  @action
  void changeFilter(int index) {
    chosenFilter = index;
  }

  @action
  Future addFavorite(BaseModel baseModel, UserStore userStore) async {
    favorites.add(baseModel);

    await Future.wait([
      localDb.addToFavorites(baseModel.toFavorite()),
      if (userStore.isTraktLogged) ...[
        localDb.updateLastActivities(
          movieCollectedAt: baseModel.type == BaseModelType.movie
              ? DateTime.now().toUtc()
              : null,
          epCollectedAt: baseModel.type == BaseModelType.tv
              ? DateTime.now().toUtc()
              : null,
        ),
        traktRepository.addFavorite(
          tmdbId: baseModel.id!,
          entityType: baseModel.type!.getEntityType(),
        ),
      ],
    ]);
    ;
  }

  @action
  Future removeFavorites(UserStore userStore) async {
    List<int> movies = [];
    List<int> shows = [];

    for (var id in checkedFavoritesIds) {
      BaseModel fav = favorites.firstWhere((element) => element.id == id);
      if (fav.type == BaseModelType.movie) {
        movies.add(fav.id!);
      } else {
        shows.add(fav.id!);
      }
      favorites.remove(fav);
    }

    await Future.wait([
      if (userStore.isTraktLogged)
        traktRepository.removeFavorites(
          movieTmdbIds: movies.isEmpty ? null : movies,
          showTmdbIds: shows.isEmpty ? null : shows,
        ),
      localDb.removeFavs(ids: [...movies, ...shows]),
    ]);
  }

  @action
  Future removeFavorite(BaseModel baseModel, UserStore userStore) async {
    favorites.remove(baseModel);

    localDb.removeFromFav(baseModel.id!);
    if (userStore.isTraktLogged) {
      await traktRepository.removeFavorite(
          tmdbId: baseModel.id!, entityType: baseModel.type!.getEntityType());
    }
  }

  @action
  void addCheckedFav({required int id}) {
    checkedFavoritesIds.add(id);
  }

  @action
  void removeCheckedFav({required int id}) {
    checkedFavoritesIds.remove(id);
  }

  @action
  void resetMultiSelect() {
    setMultiSelectEnabled(false);
    checkedFavoritesIds.clear();
  }
}
