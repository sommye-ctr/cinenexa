// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SearchStore on _SearchStore, Store {
  Computed<bool>? _$searchDoneComputed;

  @override
  bool get searchDone =>
      (_$searchDoneComputed ??= Computed<bool>(() => super.searchDone,
              name: '_SearchStore.searchDone'))
          .value;
  Computed<EntityType>? _$entityTypeComputed;

  @override
  EntityType get entityType =>
      (_$entityTypeComputed ??= Computed<EntityType>(() => super.entityType,
              name: '_SearchStore.entityType'))
          .value;

  late final _$searchTermAtom =
      Atom(name: '_SearchStore.searchTerm', context: context);

  @override
  String get searchTerm {
    _$searchTermAtom.reportRead();
    return super.searchTerm;
  }

  @override
  set searchTerm(String value) {
    _$searchTermAtom.reportWrite(value, super.searchTerm, () {
      super.searchTerm = value;
    });
  }

  late final _$historyAtom =
      Atom(name: '_SearchStore.history', context: context);

  @override
  ObservableList<SearchHistory> get history {
    _$historyAtom.reportRead();
    return super.history;
  }

  @override
  set history(ObservableList<SearchHistory> value) {
    _$historyAtom.reportWrite(value, super.history, () {
      super.history = value;
    });
  }

  late final _$pageAtom = Atom(name: '_SearchStore.page', context: context);

  @override
  int get page {
    _$pageAtom.reportRead();
    return super.page;
  }

  @override
  set page(int value) {
    _$pageAtom.reportWrite(value, super.page, () {
      super.page = value;
    });
  }

  late final _$searchTypeAtom =
      Atom(name: '_SearchStore.searchType', context: context);

  @override
  SearchType get searchType {
    _$searchTypeAtom.reportRead();
    return super.searchType;
  }

  @override
  set searchType(SearchType value) {
    _$searchTypeAtom.reportWrite(value, super.searchType, () {
      super.searchType = value;
    });
  }

  late final _$searchFocusedAtom =
      Atom(name: '_SearchStore.searchFocused', context: context);

  @override
  bool get searchFocused {
    _$searchFocusedAtom.reportRead();
    return super.searchFocused;
  }

  @override
  set searchFocused(bool value) {
    _$searchFocusedAtom.reportWrite(value, super.searchFocused, () {
      super.searchFocused = value;
    });
  }

  late final _$speakingAtom =
      Atom(name: '_SearchStore.speaking', context: context);

  @override
  bool get speaking {
    _$speakingAtom.reportRead();
    return super.speaking;
  }

  @override
  set speaking(bool value) {
    _$speakingAtom.reportWrite(value, super.speaking, () {
      super.speaking = value;
    });
  }

  late final _$fetchItemsFutureAtom =
      Atom(name: '_SearchStore.fetchItemsFuture', context: context);

  @override
  ObservableFuture<List<BaseModel>> get fetchItemsFuture {
    _$fetchItemsFutureAtom.reportRead();
    return super.fetchItemsFuture;
  }

  @override
  set fetchItemsFuture(ObservableFuture<List<BaseModel>> value) {
    _$fetchItemsFutureAtom.reportWrite(value, super.fetchItemsFuture, () {
      super.fetchItemsFuture = value;
    });
  }

  late final _$fetchListsFutureAtom =
      Atom(name: '_SearchStore.fetchListsFuture', context: context);

  @override
  ObservableFuture<List<TraktList>> get fetchListsFuture {
    _$fetchListsFutureAtom.reportRead();
    return super.fetchListsFuture;
  }

  @override
  set fetchListsFuture(ObservableFuture<List<TraktList>> value) {
    _$fetchListsFutureAtom.reportWrite(value, super.fetchListsFuture, () {
      super.fetchListsFuture = value;
    });
  }

  late final _$autoCompleteTermsAtom =
      Atom(name: '_SearchStore.autoCompleteTerms', context: context);

  @override
  ObservableFuture<List<BaseModel>> get autoCompleteTerms {
    _$autoCompleteTermsAtom.reportRead();
    return super.autoCompleteTerms;
  }

  @override
  set autoCompleteTerms(ObservableFuture<List<BaseModel>> value) {
    _$autoCompleteTermsAtom.reportWrite(value, super.autoCompleteTerms, () {
      super.autoCompleteTerms = value;
    });
  }

  late final _$resultsAtom =
      Atom(name: '_SearchStore.results', context: context);

  @override
  ObservableList<BaseModel> get results {
    _$resultsAtom.reportRead();
    return super.results;
  }

  @override
  set results(ObservableList<BaseModel> value) {
    _$resultsAtom.reportWrite(value, super.results, () {
      super.results = value;
    });
  }

  late final _$listResultsAtom =
      Atom(name: '_SearchStore.listResults', context: context);

  @override
  ObservableList<TraktList> get listResults {
    _$listResultsAtom.reportRead();
    return super.listResults;
  }

  @override
  set listResults(ObservableList<TraktList> value) {
    _$listResultsAtom.reportWrite(value, super.listResults, () {
      super.listResults = value;
    });
  }

  late final _$_fetchHistoryAsyncAction =
      AsyncAction('_SearchStore._fetchHistory', context: context);

  @override
  Future<dynamic> _fetchHistory() {
    return _$_fetchHistoryAsyncAction.run(() => super._fetchHistory());
  }

  late final _$_fetchAutocompleteTermsAsyncAction =
      AsyncAction('_SearchStore._fetchAutocompleteTerms', context: context);

  @override
  Future<dynamic> _fetchAutocompleteTerms() {
    return _$_fetchAutocompleteTermsAsyncAction
        .run(() => super._fetchAutocompleteTerms());
  }

  late final _$_fetchItemsAsyncAction =
      AsyncAction('_SearchStore._fetchItems', context: context);

  @override
  Future<dynamic> _fetchItems(Future<List<BaseModel>> future,
      {bool pageEndReached = false}) {
    return _$_fetchItemsAsyncAction
        .run(() => super._fetchItems(future, pageEndReached: pageEndReached));
  }

  late final _$_fetchListsAsyncAction =
      AsyncAction('_SearchStore._fetchLists', context: context);

  @override
  Future<dynamic> _fetchLists({bool pageEndReached = false}) {
    return _$_fetchListsAsyncAction
        .run(() => super._fetchLists(pageEndReached: pageEndReached));
  }

  late final _$_addToHistoryAsyncAction =
      AsyncAction('_SearchStore._addToHistory', context: context);

  @override
  Future<dynamic> _addToHistory() {
    return _$_addToHistoryAsyncAction.run(() => super._addToHistory());
  }

  late final _$_SearchStoreActionController =
      ActionController(name: '_SearchStore', context: context);

  @override
  void historyDeleted(SearchHistory history) {
    final _$actionInfo = _$_SearchStoreActionController.startAction(
        name: '_SearchStore.historyDeleted');
    try {
      return super.historyDeleted(history);
    } finally {
      _$_SearchStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void searchTermChanged(String value) {
    final _$actionInfo = _$_SearchStoreActionController.startAction(
        name: '_SearchStore.searchTermChanged');
    try {
      return super.searchTermChanged(value);
    } finally {
      _$_SearchStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void searchTypeChanged(SearchType type) {
    final _$actionInfo = _$_SearchStoreActionController.startAction(
        name: '_SearchStore.searchTypeChanged');
    try {
      return super.searchTypeChanged(type);
    } finally {
      _$_SearchStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeSearchType(SearchType type) {
    final _$actionInfo = _$_SearchStoreActionController.startAction(
        name: '_SearchStore.changeSearchType');
    try {
      return super.changeSearchType(type);
    } finally {
      _$_SearchStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void searchClicked(String? term) {
    final _$actionInfo = _$_SearchStoreActionController.startAction(
        name: '_SearchStore.searchClicked');
    try {
      return super.searchClicked(term);
    } finally {
      _$_SearchStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void backClicked() {
    final _$actionInfo = _$_SearchStoreActionController.startAction(
        name: '_SearchStore.backClicked');
    try {
      return super.backClicked();
    } finally {
      _$_SearchStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onEndOfPageReached() {
    final _$actionInfo = _$_SearchStoreActionController.startAction(
        name: '_SearchStore.onEndOfPageReached');
    try {
      return super.onEndOfPageReached();
    } finally {
      _$_SearchStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void speakToTextClicked(bool value) {
    final _$actionInfo = _$_SearchStoreActionController.startAction(
        name: '_SearchStore.speakToTextClicked');
    try {
      return super.speakToTextClicked(value);
    } finally {
      _$_SearchStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void searchCancelled() {
    final _$actionInfo = _$_SearchStoreActionController.startAction(
        name: '_SearchStore.searchCancelled');
    try {
      return super.searchCancelled();
    } finally {
      _$_SearchStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void searchHistoryTermClicked(String term) {
    final _$actionInfo = _$_SearchStoreActionController.startAction(
        name: '_SearchStore.searchHistoryTermClicked');
    try {
      return super.searchHistoryTermClicked(term);
    } finally {
      _$_SearchStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void searchBoxFocused() {
    final _$actionInfo = _$_SearchStoreActionController.startAction(
        name: '_SearchStore.searchBoxFocused');
    try {
      return super.searchBoxFocused();
    } finally {
      _$_SearchStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
searchTerm: ${searchTerm},
history: ${history},
page: ${page},
searchType: ${searchType},
searchFocused: ${searchFocused},
speaking: ${speaking},
fetchItemsFuture: ${fetchItemsFuture},
fetchListsFuture: ${fetchListsFuture},
autoCompleteTerms: ${autoCompleteTerms},
results: ${results},
listResults: ${listResults},
searchDone: ${searchDone},
entityType: ${entityType}
    ''';
  }
}
