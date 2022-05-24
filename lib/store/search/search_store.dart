import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:watrix/models/base_model.dart';
import 'package:watrix/screens/search_result_page.dart';

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
  _SearchStore() {
    _fetchItems(
      Requests.titlesFuture(
        Requests.popular(
          EntityType.movie,
          page: 1,
        ),
      ),
    );
  }

  @observable
  ObservableList<BaseModel> items = <BaseModel>[].asObservable();

  @observable
  int page = 1;

  @observable
  String searchTerm = "";

  @action
  Future _fetchItems(Future future, {bool pageEndReached = false}) async {
    if (!pageEndReached) items.clear();
    List<BaseModel> list = await future;
    items.addAll(list);
  }

  @action
  void searchTermChanged(String value) {
    searchTerm = value;
  }

  @action
  void searchClicked(context) {
    Navigator.pushNamed(
      context,
      SearchResultPage.routeName,
      arguments: searchTerm,
    );
  }

  @action
  void onEndOfPageReached() {
    page++;
    _fetchItems(
      Requests.titlesFuture(
        Requests.popular(EntityType.movie, page: page),
      ),
      pageEndReached: true,
    );
  }
}
