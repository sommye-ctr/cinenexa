import 'package:mobx/mobx.dart';
import 'package:watrix/models/local/search_history.dart';
import 'package:watrix/services/local/database.dart';
import 'package:watrix/services/network/repository.dart';

import '../../models/network/base_model.dart';
import '../../models/network/enums/entity_type.dart';
import '../../services/network/requests.dart';

part 'search_store.g.dart';

class SearchStore extends _SearchStore with _$SearchStore {}

enum SearchType {
  movie,
  tv,
  people,
}

abstract class _SearchStore with Store {
  static ObservableFuture<List<BaseModel>> emptyResponse =
      ObservableFuture.value([]);

  @observable
  String searchTerm = "";

  @observable
  ObservableList<SearchHistory> history = <SearchHistory>[].asObservable();

  @observable
  int page = 1;

  @observable
  SearchType searchType = SearchType.movie;

  @observable
  bool searchFocused = false;

  Database database = Database();

  @observable
  ObservableFuture<List<BaseModel>> fetchItemsFuture = emptyResponse;

  @computed
  bool get searchDone => fetchItemsFuture != emptyResponse;

  @computed
  EntityType get entityType {
    switch (searchType) {
      case SearchType.movie:
        return EntityType.movie;
      case SearchType.tv:
        return EntityType.tv;
      case SearchType.people:
        return EntityType.people;
    }
  }

  _SearchStore() {
    _fetchHistory();
  }

  @action
  Future _fetchHistory() async {
    List<SearchHistory> list = await database.getSearchHistory();
    history.addAll(list);
  }

  @action
  void historyDeleted(SearchHistory history) {
    this.history.remove(history);
    database.deleteSearchHistory(history.id);
  }

  @action
  void searchTermChanged(String value) {
    searchTerm = value;
  }

  @action
  void searchTypeChanged(SearchType type) {
    searchType = type;
    _fetchItems(Repository.search(searchTerm, entityType));
  }

  @action
  void searchClicked() {
    page = 1;

    _fetchItems(
      Repository.search(searchTerm, entityType),
    );
    _addToHistory();
  }

  @action
  Future _fetchItems(Future<List<BaseModel>> future,
      {bool pageEndReached = false}) async {
    if (!pageEndReached) {
      fetchItemsFuture = emptyResponse;
    }
    fetchItemsFuture = ObservableFuture(future);
  }

  @action
  void backClicked() {
    searchType = SearchType.movie;
    searchTerm = "";
    searchFocused = false;
    fetchItemsFuture = emptyResponse;
  }

  @action
  Future _addToHistory() async {
    bool isAdded = await database.addSearchHistory(searchTerm);
    if (isAdded) history.add(SearchHistory()..term = searchTerm);
  }

  @action
  void onEndOfPageReached() {
    page++;
    _fetchItems(
      Repository.search(searchTerm, entityType, page: page),
      pageEndReached: true,
    );
  }

  @action
  void searchCancelled() {
    backClicked();
  }

  @action
  void searchHistoryTermClicked(String term) {
    searchTerm = term;
    searchClicked();
  }

  @action
  void searchBoxFocused() {
    searchFocused = true;
  }
}
