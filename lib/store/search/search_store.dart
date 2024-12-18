import 'dart:async';
import 'package:cinenexa/services/network/trakt_oauth_client.dart';
import 'package:cinenexa/services/network/trakt_repository.dart';
import 'package:mobx/mobx.dart';
import 'package:cinenexa/models/local/search_history.dart';
import 'package:cinenexa/services/local/database.dart';
import 'package:cinenexa/services/network/repository.dart';

import '../../models/network/base_model.dart';
import '../../models/network/enums/entity_type.dart';
import '../../models/network/trakt/trakt_list.dart';

part 'search_store.g.dart';

class SearchStore extends _SearchStore with _$SearchStore {}

enum SearchType {
  movie,
  tv,
  people,
  lists,
}

abstract class _SearchStore with Store {
  static const Duration _debounceDuration = Duration(milliseconds: 300);

  static ObservableFuture<List<BaseModel>> emptyResponse =
      ObservableFuture.value([]);

  static ObservableFuture<List<TraktList>> emptyResponse1 =
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

  @observable
  bool speaking = false;

  Database database = Database();

  @observable
  ObservableFuture<List<BaseModel>> fetchItemsFuture = emptyResponse;

  @observable
  ObservableFuture<List<TraktList>> fetchListsFuture = emptyResponse1;

  @observable
  ObservableFuture<List<BaseModel>> autoCompleteTerms = emptyResponse;

  @observable
  ObservableList<BaseModel> results = <BaseModel>[].asObservable();

  @observable
  ObservableList<TraktList> listResults = <TraktList>[].asObservable();

  @computed
  bool get searchDone =>
      fetchItemsFuture != emptyResponse || fetchListsFuture != emptyResponse1;

  Timer? _debounceTimer;

  @computed
  EntityType get entityType {
    switch (searchType) {
      case SearchType.movie:
        return EntityType.movie;
      case SearchType.tv:
        return EntityType.tv;
      case SearchType.people:
        return EntityType.people;
      case SearchType.lists:
        return EntityType.list;
    }
  }

  _SearchStore() {
    _fetchHistory();
  }

  @action
  Future _fetchHistory() async {
    List<SearchHistory> list = await database.getSearchHistory();
    history.addAll(list.reversed);
  }

  @action
  Future _fetchAutocompleteTerms() async {
    autoCompleteTerms =
        Repository.search(searchTerm, EntityType.all).asObservable();
  }

  @action
  void historyDeleted(SearchHistory history) {
    this.history.remove(history);
    database.deleteSearchHistory(history.id!);
  }

  @action
  void searchTermChanged(String value) {
    searchTerm = value;
    if (value.isNotEmpty) {
      if (_debounceTimer?.isActive ?? false) _debounceTimer?.cancel();
      _debounceTimer = Timer(
        _debounceDuration,
        () {
          _fetchAutocompleteTerms();
        },
      );
    }
  }

  @action
  void searchTypeChanged(SearchType type) {
    changeSearchType(type);
    _fetchItems(Repository.search(searchTerm, entityType));
  }

  @action
  void changeSearchType(SearchType type) {
    searchType = type;
  }

  @action
  void searchClicked(String? term) {
    page = 1;
    changeSearchType(SearchType.movie);
    if (speaking) {
      speakToTextClicked(false);
    }

    if (term == null || term.length < 3) {
      return;
    }
    searchTerm = term;

    _fetchItems(
      Repository.search(searchTerm, entityType),
    );
    _addToHistory();
  }

  @action
  Future _fetchItems(Future<List<BaseModel>> future,
      {bool pageEndReached = false}) async {
    if (searchType == SearchType.lists) {
      _fetchLists(pageEndReached: pageEndReached);
      return;
    }

    if (!pageEndReached) {
      results.clear();
    }
    fetchItemsFuture = ObservableFuture(future);
    fetchItemsFuture.whenComplete(() {
      if (fetchItemsFuture.status == FutureStatus.fulfilled) {
        results.addAll(fetchItemsFuture.value!);
      }
    });
  }

  @action
  Future _fetchLists({bool pageEndReached = false}) async {
    if (!pageEndReached) {
      listResults.clear();
    }

    fetchListsFuture = ObservableFuture(
        TraktRepository(client: TraktOAuthClient()).getSearchList(
      searchTerm: searchTerm,
      page: page,
    ));

    fetchListsFuture.whenComplete(() {
      if (fetchListsFuture.status == FutureStatus.fulfilled) {
        listResults.addAll(fetchListsFuture.value!);
      }
    });
  }

  @action
  void backClicked() {
    searchType = SearchType.movie;
    searchTerm = "";
    searchFocused = false;
    fetchItemsFuture = emptyResponse;
    fetchListsFuture = emptyResponse1;
  }

  @action
  Future _addToHistory() async {
    bool isAdded = await database.addSearchHistory(searchTerm);
    if (isAdded) history.insert(0, SearchHistory()..term = searchTerm);
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
  void speakToTextClicked(bool value) {
    speaking = value;
  }

  @action
  void searchCancelled() {
    backClicked();
  }

  @action
  void searchHistoryTermClicked(String term) {
    searchTerm = term;
    searchClicked(term);
  }

  @action
  void searchBoxFocused() {
    searchFocused = true;
  }
}
