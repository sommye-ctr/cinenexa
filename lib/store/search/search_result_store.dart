import 'package:mobx/mobx.dart';
import 'package:watrix/store/search/search_store.dart';

import '../../models/base_model.dart';
import '../../services/entity_type.dart';
import '../../services/requests.dart';

part 'search_result_store.g.dart';

class SearchResultStore extends _SearchResultStore with _$SearchResultStore {
  SearchResultStore({required String searchTerm})
      : super(searchTerm: searchTerm);
}

abstract class _SearchResultStore with Store {
  @observable
  ObservableList<BaseModel> items = <BaseModel>[].asObservable();

  @observable
  int page = 1;

  @observable
  String searchTerm;

  @observable
  SearchType searchType = SearchType.movie;

  _SearchResultStore({required this.searchTerm}) {
    _fetchItems(
      Requests.searchFuture(
        searchTerm,
        Requests.search(EntityType.movie),
      ),
    );
  }

  @action
  void searchTermChanged(String term) {
    searchTerm = term;
  }

  @action
  void searchTypeChanged(SearchType type) {
    searchType = type;
    String base = _getSearchBase();
    _fetchItems(Requests.searchFuture(searchTerm, base));
  }

  @action
  Future _fetchItems(Future future, {bool pageEndReached = false}) async {
    if (!pageEndReached) items.clear();
    List<BaseModel> list = await future;
    items.addAll(list);
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
