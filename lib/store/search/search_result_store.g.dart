// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_result_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SearchResultStore on _SearchResultStore, Store {
  final _$itemsAtom = Atom(name: '_SearchResultStore.items');

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

  final _$pageAtom = Atom(name: '_SearchResultStore.page');

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

  final _$searchTermAtom = Atom(name: '_SearchResultStore.searchTerm');

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

  final _$searchTypeAtom = Atom(name: '_SearchResultStore.searchType');

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

  final _$_fetchItemsAsyncAction =
      AsyncAction('_SearchResultStore._fetchItems');

  @override
  Future<dynamic> _fetchItems(Future<dynamic> future,
      {bool pageEndReached = false}) {
    return _$_fetchItemsAsyncAction
        .run(() => super._fetchItems(future, pageEndReached: pageEndReached));
  }

  final _$_SearchResultStoreActionController =
      ActionController(name: '_SearchResultStore');

  @override
  void searchTermChanged(String term) {
    final _$actionInfo = _$_SearchResultStoreActionController.startAction(
        name: '_SearchResultStore.searchTermChanged');
    try {
      return super.searchTermChanged(term);
    } finally {
      _$_SearchResultStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void searchTypeChanged(SearchType type) {
    final _$actionInfo = _$_SearchResultStoreActionController.startAction(
        name: '_SearchResultStore.searchTypeChanged');
    try {
      return super.searchTypeChanged(type);
    } finally {
      _$_SearchResultStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void searchClicked() {
    final _$actionInfo = _$_SearchResultStoreActionController.startAction(
        name: '_SearchResultStore.searchClicked');
    try {
      return super.searchClicked();
    } finally {
      _$_SearchResultStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onEndOfPageReached() {
    final _$actionInfo = _$_SearchResultStoreActionController.startAction(
        name: '_SearchResultStore.onEndOfPageReached');
    try {
      return super.onEndOfPageReached();
    } finally {
      _$_SearchResultStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
items: ${items},
page: ${page},
searchTerm: ${searchTerm},
searchType: ${searchType}
    ''';
  }
}
