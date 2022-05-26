import 'package:mobx/mobx.dart';

import '../../models/base_model.dart';
import '../../services/entity_type.dart';
import '../../services/requests.dart';

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
  int page = 1;

  @observable
  SearchType searchType = SearchType.movie;

  @observable
  bool searchDone = false;

  @observable
  bool resultsEmpty = false;

  @observable
  bool isLoading = false;

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
  }

  @action
  void searchClicked() {
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
