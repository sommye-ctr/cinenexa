// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'watchlist_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$WatchListStore on _WatchListStoreBase, Store {
  late final _$watchListsAtom =
      Atom(name: '_WatchListStoreBase.watchLists', context: context);

  @override
  ObservableList<TraktList> get watchLists {
    _$watchListsAtom.reportRead();
    return super.watchLists;
  }

  @override
  set watchLists(ObservableList<TraktList> value) {
    _$watchListsAtom.reportWrite(value, super.watchLists, () {
      super.watchLists = value;
    });
  }

  late final _$likedListsAtom =
      Atom(name: '_WatchListStoreBase.likedLists', context: context);

  @override
  ObservableList<TraktList> get likedLists {
    _$likedListsAtom.reportRead();
    return super.likedLists;
  }

  @override
  set likedLists(ObservableList<TraktList> value) {
    _$likedListsAtom.reportWrite(value, super.likedLists, () {
      super.likedLists = value;
    });
  }

  late final _$currentIsLikedAtom =
      Atom(name: '_WatchListStoreBase.currentIsLiked', context: context);

  @override
  bool get currentIsLiked {
    _$currentIsLikedAtom.reportRead();
    return super.currentIsLiked;
  }

  @override
  set currentIsLiked(bool value) {
    _$currentIsLikedAtom.reportWrite(value, super.currentIsLiked, () {
      super.currentIsLiked = value;
    });
  }

  late final _$fetchWatchListsAsyncAction =
      AsyncAction('_WatchListStoreBase.fetchWatchLists', context: context);

  @override
  Future<dynamic> fetchWatchLists({bool fromApi = false}) {
    return _$fetchWatchListsAsyncAction
        .run(() => super.fetchWatchLists(fromApi: fromApi));
  }

  late final _$fetchLikedListsAsyncAction =
      AsyncAction('_WatchListStoreBase.fetchLikedLists', context: context);

  @override
  Future<dynamic> fetchLikedLists({bool fromApi = false}) {
    return _$fetchLikedListsAsyncAction
        .run(() => super.fetchLikedLists(fromApi: fromApi));
  }

  late final _$addItemtoListAsyncAction =
      AsyncAction('_WatchListStoreBase.addItemtoList', context: context);

  @override
  Future<dynamic> addItemtoList(
      {required BaseModel baseModel, required int listId}) {
    return _$addItemtoListAsyncAction
        .run(() => super.addItemtoList(baseModel: baseModel, listId: listId));
  }

  late final _$removeItemtoListAsyncAction =
      AsyncAction('_WatchListStoreBase.removeItemtoList', context: context);

  @override
  Future<dynamic> removeItemtoList(
      {required BaseModel baseModel, required int listId}) {
    return _$removeItemtoListAsyncAction.run(
        () => super.removeItemtoList(baseModel: baseModel, listId: listId));
  }

  late final _$_WatchListStoreBaseActionController =
      ActionController(name: '_WatchListStoreBase', context: context);

  @override
  void changeSelection(bool currentLiked) {
    final _$actionInfo = _$_WatchListStoreBaseActionController.startAction(
        name: '_WatchListStoreBase.changeSelection');
    try {
      return super.changeSelection(currentLiked);
    } finally {
      _$_WatchListStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
watchLists: ${watchLists},
likedLists: ${likedLists},
currentIsLiked: ${currentIsLiked}
    ''';
  }
}
