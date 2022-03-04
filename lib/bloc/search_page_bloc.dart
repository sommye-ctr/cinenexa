import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watrix/bloc/search_page_event.dart';
import 'package:watrix/bloc/search_page_state.dart';

import '../services/entity_type.dart';
import '../services/requests.dart';

class SearchPageBloc extends Bloc<SearchPageEvent, SearchPageState> {
  String searchTerm = "";
  SearchType? searchType;

  SearchPageBloc() : super(SearchNotDone()) {
    on<SearchClicked>(_searchClicked);
    on<SearchTermChanged>(_searchTermChanged);
    on<SearchTypeChanged>(_searchTypeChanged);
    on<SearchBackClicked>(_searchBackClicked);
  }

  _searchClicked(SearchClicked searchClicked, Emitter<SearchPageState> emit) {
    if (searchTerm.length > 3) {
      EntityType entityType = EntityType.movie;

      if (searchType == SearchType.tv) {
        entityType = EntityType.tv;
      } else if (searchType == SearchType.people) {
        entityType = EntityType.people;
      }

      emit(
        SearchDone(
          searchTerm: searchTerm,
          future: Requests.searchFuture(
            searchTerm,
            Requests.search(entityType),
          ),
        ),
      );
      searchType = SearchType.movie;
    }
  }

  _searchTermChanged(
      SearchTermChanged searchTermChanged, Emitter<SearchPageState> emit) {
    searchTerm = searchTermChanged.searchTerm;
  }

  _searchBackClicked(
      SearchBackClicked searchBackClicked, Emitter<SearchPageState> emit) {
    searchType = null;
    emit(
      SearchNotDone(
        future: Requests.titlesFuture(
          Requests.popular(EntityType.movie),
        ),
      ),
    );
  }

  _searchTypeChanged(
      SearchTypeChanged searchTypeChanged, Emitter<SearchPageState> emit) {
    searchType = searchTypeChanged.searchType;

    String base = "";
    switch (searchTypeChanged.searchType) {
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
    emit(
      SearchDone(
        searchTerm: searchTerm,
        future: Requests.searchFuture(searchTerm, base),
      ),
    );
  }

  @override
  void onChange(Change<SearchPageState> change) {
    print(
        "on change: ${change.currentState.toString()} to ${change.nextState.toString()}");
    super.onChange(change);
  }

  @override
  void onEvent(SearchPageEvent event) {
    print("on event: ${event.toString()}");
    super.onEvent(event);
  }
}
