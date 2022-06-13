// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SearchStore on _SearchStore, Store {
  final _$searchTermAtom = Atom(name: '_SearchStore.searchTerm');

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

  final _$itemsAtom = Atom(name: '_SearchStore.items');

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

  final _$pageAtom = Atom(name: '_SearchStore.page');

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

  final _$searchTypeAtom = Atom(name: '_SearchStore.searchType');

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

  final _$searchDoneAtom = Atom(name: '_SearchStore.searchDone');

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

  final _$resultsEmptyAtom = Atom(name: '_SearchStore.resultsEmpty');

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

  final _$isLoadingAtom = Atom(name: '_SearchStore.isLoading');

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

  final _$searchFocusedAtom = Atom(name: '_SearchStore.searchFocused');

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

  final _$_fetchItemsAsyncAction = AsyncAction('_SearchStore._fetchItems');

  @override
  Future<dynamic> _fetchItems(Future<dynamic> future,
      {bool pageEndReached = false}) {
    return _$_fetchItemsAsyncAction
        .run(() => super._fetchItems(future, pageEndReached: pageEndReached));
  }

  final _$_SearchStoreActionController = ActionController(name: '_SearchStore');

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
  void searchClicked() {
    final _$actionInfo = _$_SearchStoreActionController.startAction(
        name: '_SearchStore.searchClicked');
    try {
      return super.searchClicked();
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
page: ${page},
searchType: ${searchType},
searchDone: ${searchDone},
resultsEmpty: ${resultsEmpty},
isLoading: ${isLoading},
searchFocused: ${searchFocused}
    ''';
  }
}
