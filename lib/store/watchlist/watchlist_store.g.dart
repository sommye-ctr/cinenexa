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

  late final _$fetchWatchListsAsyncAction =
      AsyncAction('_WatchListStoreBase.fetchWatchLists', context: context);

  @override
  Future<dynamic> fetchWatchLists({bool fromApi = false}) {
    return _$fetchWatchListsAsyncAction
        .run(() => super.fetchWatchLists(fromApi: fromApi));
  }

  @override
  String toString() {
    return '''
watchLists: ${watchLists}
    ''';
  }
}
