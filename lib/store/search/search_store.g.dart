// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SearchStore on _SearchStore, Store {
  final _$futureAtom = Atom(name: '_SearchStore.future');

  @override
  Future<List<BaseModel>> get future {
    _$futureAtom.reportRead();
    return super.future;
  }

  @override
  set future(Future<List<BaseModel>> value) {
    _$futureAtom.reportWrite(value, super.future, () {
      super.future = value;
    });
  }

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

  final _$_SearchStoreActionController = ActionController(name: '_SearchStore');

  @override
  void searchTermChanged(String term) {
    final _$actionInfo = _$_SearchStoreActionController.startAction(
        name: '_SearchStore.searchTermChanged');
    try {
      return super.searchTermChanged(term);
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
  String toString() {
    return '''
future: ${future},
searchTerm: ${searchTerm},
searchDone: ${searchDone},
searchType: ${searchType}
    ''';
  }
}
