import 'package:cinenexa/models/network/trakt/trakt_list.dart';
import 'package:mobx/mobx.dart';

import '../../models/network/base_model.dart';
import '../../services/local/database.dart';
import '../../services/network/trakt_oauth_client.dart';
import '../../services/network/trakt_repository.dart';
part 'watchlist_store.g.dart';

class WatchListStore = _WatchListStoreBase with _$WatchListStore;

abstract class _WatchListStoreBase with Store {
  @observable
  ObservableList<TraktList> watchLists = <TraktList>[].asObservable();

  @observable
  ObservableList<TraktList> likedLists = <TraktList>[].asObservable();

  @observable
  bool currentIsLiked = false;

  TraktRepository traktRepository = TraktRepository(client: TraktOAuthClient());
  Database localDb = Database();

  @action
  void changeSelection(bool currentLiked) {
    currentIsLiked = currentLiked;
  }

  @action
  Future fetchWatchLists({bool fromApi = false}) async {
    watchLists.addAll(await localDb.getLists());

    if (fromApi) {
      traktRepository.getUserTraktLists().then((value) async {
        await localDb.updateLists(lists: value);
        watchLists.clear();
        watchLists.addAll(value);

        await Future.forEach<TraktList>(watchLists, (element) async {
          try {
            var item = await traktRepository.getListItems(
              listId: element.traktId,
              personal: true,
              limit: false,
            );
            element.setItems(item);
            await localDb.updateListItem(id: element.traktId, items: item);
          } catch (e) {}
        });

        localDb.updateLastActivities(listUpdatedAt: DateTime.now());
        List<TraktList> newList = List.from(watchLists);
        watchLists.clear();
        watchLists = newList.asObservable();
      });
    }
  }

  @action
  Future fetchLikedLists({bool fromApi = false}) async {
    likedLists.addAll(await localDb.getLikedLists());

    if (fromApi) {
      traktRepository.getUserLikedTraktLists().then((value) async {
        await localDb.updateLists(lists: value, liked: true);
        localDb.updateLastActivities(listLikedAt: DateTime.now());
        likedLists.clear();
        likedLists.addAll(value);
      });
    }
  }

  @action
  Future addItemtoList(
      {required BaseModel baseModel, required int listId}) async {
    int index = watchLists.indexWhere((element) => element.traktId == listId);
    TraktList list = watchLists[index];
    watchLists[index] = list..addItem(baseModel);

    localDb.addToList(listId: listId, item: baseModel);
    traktRepository
        .addItemsToList(
      item: baseModel,
      listId: listId,
    )
        .then((value) {
      localDb.updateLastActivities(listUpdatedAt: DateTime.now());
    });
  }

  @action
  Future removeItemtoList(
      {required BaseModel baseModel, required int listId}) async {
    int index = watchLists.indexWhere((element) => element.traktId == listId);
    TraktList list = watchLists[index];
    watchLists[index] = list..removeItem(baseModel);

    localDb.removeFromList(listId: listId, item: baseModel);
    traktRepository
        .removeItemsToList(
      item: baseModel,
      listId: listId,
    )
        .then((value) {
      localDb.updateLastActivities(listUpdatedAt: DateTime.now());
    });
  }
}
