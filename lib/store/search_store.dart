import 'package:mobx/mobx.dart';
import 'package:watrix/models/base_model.dart';

import '../services/entity_type.dart';
import '../services/requests.dart';

part 'search_store.g.dart';

class SearchStore extends _SearchStore with _$SearchStore {}

enum SearchType {
  movie,
  tv,
  people,
}

abstract class _SearchStore with Store {
  @observable
  Future<List<BaseModel>> future =
      Requests.titlesFuture(Requests.popular(EntityType.movie));

  @observable
  String searchTerm = "";

  @observable
  bool searchDone = false;

  @observable
  SearchType searchType = SearchType.movie;

  @action
  void searchTermChanged(String term) {
    searchTerm = term;
  }

  @action
  void searchTypeChanged(SearchType type) {
    searchType = type;
    String base = "";
    switch (type) {
      case SearchType.movie:
        base = Requests.search(EntityType.movie);
        break;
      case SearchType.tv:
        base = Requests.search(EntityType.tv);
        break;
      case SearchType.people:
        base = Requests.search(EntityType.people);
        break;
    }
    future = Requests.searchFuture(searchTerm, base);
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
    future = Requests.searchFuture(
      searchTerm,
      Requests.search(entityType),
    );
    searchDone = true;
  }

  @action
  void backClicked() {
    future = Requests.titlesFuture(
      Requests.popular(EntityType.movie),
    );
    searchDone = false;
    searchType = SearchType.movie;
    searchTerm = "";
  }
}
