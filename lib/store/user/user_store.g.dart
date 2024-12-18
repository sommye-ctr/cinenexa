// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UserStore on _UserStoreBase, Store {
  late final _$userStatsAtom =
      Atom(name: '_UserStoreBase.userStats', context: context);

  @override
  UserStats? get userStats {
    _$userStatsAtom.reportRead();
    return super.userStats;
  }

  @override
  set userStats(UserStats? value) {
    _$userStatsAtom.reportWrite(value, super.userStats, () {
      super.userStats = value;
    });
  }

  late final _$userAtom = Atom(name: '_UserStoreBase.user', context: context);

  @override
  CineNexaUser? get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(CineNexaUser? value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  late final _$progressAtom =
      Atom(name: '_UserStoreBase.progress', context: context);

  @override
  ObservableList<TraktProgress> get progress {
    _$progressAtom.reportRead();
    return super.progress;
  }

  @override
  set progress(ObservableList<TraktProgress> value) {
    _$progressAtom.reportWrite(value, super.progress, () {
      super.progress = value;
    });
  }

  late final _$movieRecommendationsAtom =
      Atom(name: '_UserStoreBase.movieRecommendations', context: context);

  @override
  ObservableList<BaseModel> get movieRecommendations {
    _$movieRecommendationsAtom.reportRead();
    return super.movieRecommendations;
  }

  @override
  set movieRecommendations(ObservableList<BaseModel> value) {
    _$movieRecommendationsAtom.reportWrite(value, super.movieRecommendations,
        () {
      super.movieRecommendations = value;
    });
  }

  late final _$showRecommendationsAtom =
      Atom(name: '_UserStoreBase.showRecommendations', context: context);

  @override
  ObservableList<BaseModel> get showRecommendations {
    _$showRecommendationsAtom.reportRead();
    return super.showRecommendations;
  }

  @override
  set showRecommendations(ObservableList<BaseModel> value) {
    _$showRecommendationsAtom.reportWrite(value, super.showRecommendations, () {
      super.showRecommendations = value;
    });
  }

  late final _$showHistoryAtom =
      Atom(name: '_UserStoreBase.showHistory', context: context);

  @override
  ObservableList<ShowHistory> get showHistory {
    _$showHistoryAtom.reportRead();
    return super.showHistory;
  }

  @override
  set showHistory(ObservableList<ShowHistory> value) {
    _$showHistoryAtom.reportWrite(value, super.showHistory, () {
      super.showHistory = value;
    });
  }

  late final _$initAsyncAction =
      AsyncAction('_UserStoreBase.init', context: context);

  @override
  Future<dynamic> init(
      {FavoritesStore? favoritesStore, WatchListStore? watchListsStore}) {
    return _$initAsyncAction.run(() => super.init(
        favoritesStore: favoritesStore, watchListsStore: watchListsStore));
  }

  late final _$fetchUserStatsAsyncAction =
      AsyncAction('_UserStoreBase.fetchUserStats', context: context);

  @override
  Future<dynamic> fetchUserStats() {
    return _$fetchUserStatsAsyncAction.run(() => super.fetchUserStats());
  }

  late final _$fetchUserProgressAsyncAction =
      AsyncAction('_UserStoreBase.fetchUserProgress', context: context);

  @override
  Future<dynamic> fetchUserProgress({bool fromApi = true}) {
    return _$fetchUserProgressAsyncAction
        .run(() => super.fetchUserProgress(fromApi: fromApi));
  }

  late final _$removeProgressAsyncAction =
      AsyncAction('_UserStoreBase.removeProgress', context: context);

  @override
  Future<dynamic> removeProgress(TraktProgress traktProgress) {
    return _$removeProgressAsyncAction
        .run(() => super.removeProgress(traktProgress));
  }

  late final _$fetchUserWatchedShowsAsyncAction =
      AsyncAction('_UserStoreBase.fetchUserWatchedShows', context: context);

  @override
  Future<dynamic> fetchUserWatchedShows(
      {LastActivities? local, LastActivities? api, bool fromApi = false}) {
    return _$fetchUserWatchedShowsAsyncAction.run(() =>
        super.fetchUserWatchedShows(local: local, api: api, fromApi: fromApi));
  }

  late final _$fetchUserTraktProfileAsyncAction =
      AsyncAction('_UserStoreBase.fetchUserTraktProfile', context: context);

  @override
  Future<TraktUser> fetchUserTraktProfile() {
    return _$fetchUserTraktProfileAsyncAction
        .run(() => super.fetchUserTraktProfile());
  }

  late final _$logoutAsyncAction =
      AsyncAction('_UserStoreBase.logout', context: context);

  @override
  Future<dynamic> logout() {
    return _$logoutAsyncAction.run(() => super.logout());
  }

  late final _$fetchUserRecommendationsAsyncAction =
      AsyncAction('_UserStoreBase.fetchUserRecommendations', context: context);

  @override
  Future<dynamic> fetchUserRecommendations() {
    return _$fetchUserRecommendationsAsyncAction
        .run(() => super.fetchUserRecommendations());
  }

  late final _$disconnectTraktAsyncAction =
      AsyncAction('_UserStoreBase.disconnectTrakt', context: context);

  @override
  Future<dynamic> disconnectTrakt() {
    return _$disconnectTraktAsyncAction.run(() => super.disconnectTrakt());
  }

  @override
  String toString() {
    return '''
userStats: ${userStats},
user: ${user},
progress: ${progress},
movieRecommendations: ${movieRecommendations},
showRecommendations: ${showRecommendations},
showHistory: ${showHistory}
    ''';
  }
}
