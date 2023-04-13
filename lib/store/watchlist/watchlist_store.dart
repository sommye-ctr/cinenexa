import 'package:cinenexa/models/network/trakt/trakt_list.dart';
import 'package:mobx/mobx.dart';

import '../../services/local/database.dart';
import '../../services/network/trakt_oauth_client.dart';
import '../../services/network/trakt_repository.dart';
part 'watchlist_store.g.dart';

class WatchListStore = _WatchListStoreBase with _$WatchListStore;

abstract class _WatchListStoreBase with Store {
  @observable
  ObservableList<TraktList> watchLists = <TraktList>[].asObservable();

  TraktRepository traktRepository = TraktRepository(client: TraktOAuthClient());
  Database localDb = Database();

  @action
  Future fetchWatchLists({bool fromApi = false}) async {
    watchLists.addAll(await localDb.getLists());

    if (fromApi) {
      traktRepository.getUserTraktLists().then((value) async {
        await localDb.updateLists(lists: value);
        watchLists.clear();
        watchLists.addAll(value);

        await Future.forEach<TraktList>(watchLists, (element) async {
          element.setItems(await traktRepository.getListItems(
            listId: element.traktId,
            personal: true,
          ));
        });
        await localDb.updateLists(lists: watchLists);
        List<TraktList> newList = List.from(watchLists);
        watchLists.clear();
        watchLists = newList.asObservable();
      });
    }
  }
}