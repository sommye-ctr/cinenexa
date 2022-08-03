import 'package:mobx/mobx.dart';
import 'package:watrix/models/local/search_history.dart';
import 'package:watrix/services/local/database.dart';

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
  @observable
  String searchTerm = "";

  @observable
  ObservableList<BaseModel> items = <BaseModel>[].asObservable();

  @observable
  ObservableList<SearchHistory> history = <SearchHistory>[].asObservable();

  @observable
  int page = 1;

  @observable
  SearchType searchType = SearchType.movie;

  @observable
  bool searchDone = false;

  @observable
  bool resultsEmpty = false;

  @observable
  bool isLoading = false;

  @observable
  bool searchFocused = false;

  Database database = Database();

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
    String base = _getSearchBase();
    resultsEmpty = false;
    _fetchItems(Requests.searchFuture(searchTerm, base));
  }

  @action
  Future _fetchItems(Future future, {bool pageEndReached = false}) async {
    if (!pageEndReached) {
      items.clear();
      isLoading = true;
    }
    List<BaseModel> list = await future;
    items.addAll(list);
    isLoading = false;
    if (items.isEmpty) resultsEmpty = true;
  }

  @action
  void backClicked() {
    searchDone = false;
    searchType = SearchType.movie;
    searchTerm = "";
    resultsEmpty = false;
    searchFocused = false;
  }

  @action
  Future searchClicked() async {
    EntityType entityType;
    switch (searchType) {
      case SearchType.movie:
        entityType = EntityType.movie;
        break;
      case SearchType.tv:
        entityType = EntityType.tv;
        break;
      case SearchType.people:
        entityType = EntityType.people;
        break;
    }
    page = 1;
    searchDone = true;
    resultsEmpty = false;
    _fetchItems(
      Requests.searchFuture(
        searchTerm,
        Requests.search(entityType),
      ),
    );
    bool isAdded = await database.addSearchHistory(searchTerm);
    if (isAdded) history.add(SearchHistory()..term = searchTerm);
  }

  @action
  void onEndOfPageReached() {
    page++;
    _fetchItems(
      Requests.searchFuture(
        searchTerm,
        _getSearchBase(),
        page: page,
      ),
      pageEndReached: true,
    );
  }

  @action
  void searchCancelled() {
    backClicked();
  }

  @action
  void searchHistoryTermClicked(String term) {
    searchDone = true;
    page = 1;
    resultsEmpty = false;
    searchTerm = term;
    searchClicked();
  }

  @action
  void searchBoxFocused() {
    searchFocused = true;
  }

  String _getSearchBase() {
    switch (searchType) {
      case SearchType.movie:
        return Requests.search(EntityType.movie);
      case SearchType.tv:
        return Requests.search(EntityType.tv);
      case SearchType.people:
        return Requests.search(EntityType.people);
    }
  }
}
