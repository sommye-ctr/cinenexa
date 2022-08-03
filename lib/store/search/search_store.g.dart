// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SearchStore on _SearchStore, Store {
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

  late final _$itemsAtom = Atom(name: '_SearchStore.items', context: context);

  @override
  ObservableList<BaseModel> get items {
    _$itemsAtom.reportRead();
    return super.items;
  }

  @override
  set items(ObservableList<BaseModel> value) {
    _$itemsAtom.reportWrite(value, super.items, () {
      super.items = value;
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

  late final _$searchDoneAtom =
      Atom(name: '_SearchStore.searchDone', context: context);

  @override
  bool get searchDone {
    _$searchDoneAtom.reportRead();
    return super.searchDone;
  }

  @override
  set searchDone(bool value) {
    _$searchDoneAtom.reportWrite(value, super.searchDone, () {
      super.searchDone = value;
    });
  }

  late final _$resultsEmptyAtom =
      Atom(name: '_SearchStore.resultsEmpty', context: context);

  @override
  bool get resultsEmpty {
    _$resultsEmptyAtom.reportRead();
    return super.resultsEmpty;
  }

  @override
  set resultsEmpty(bool value) {
    _$resultsEmptyAtom.reportWrite(value, super.resultsEmpty, () {
      super.resultsEmpty = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_SearchStore.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
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

  late final _$_fetchHistoryAsyncAction =
      AsyncAction('_SearchStore._fetchHistory', context: context);

  @override
  Future<dynamic> _fetchHistory() {
    return _$_fetchHistoryAsyncAction.run(() => super._fetchHistory());
  }

  late final _$_fetchItemsAsyncAction =
      AsyncAction('_SearchStore._fetchItems', context: context);

  @override
  Future<dynamic> _fetchItems(Future<dynamic> future,
      {bool pageEndReached = false}) {
    return _$_fetchItemsAsyncAction
        .run(() => super._fetchItems(future, pageEndReached: pageEndReached));
  }

  late final _$searchClickedAsyncAction =
      AsyncAction('_SearchStore.searchClicked', context: context);

  @override
  Future<dynamic> searchClicked() {
    return _$searchClickedAsyncAction.run(() => super.searchClicked());
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
items: ${items},
history: ${history},
page: ${page},
searchType: ${searchType},
searchDone: ${searchDone},
resultsEmpty: ${resultsEmpty},
isLoading: ${isLoading},
searchFocused: ${searchFocused}
    ''';
  }
}
