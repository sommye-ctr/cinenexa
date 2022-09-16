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
  User? get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(User? value) {
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

  late final _$fetchUserProfileAsyncAction =
      AsyncAction('_UserStoreBase.fetchUserProfile', context: context);

  @override
  Future<dynamic> fetchUserProfile() {
    return _$fetchUserProfileAsyncAction.run(() => super.fetchUserProfile());
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
  Future<dynamic> fetchUserProgress() {
    return _$fetchUserProgressAsyncAction.run(() => super.fetchUserProgress());
  }

  late final _$fetchUserRecommendationsAsyncAction =
      AsyncAction('_UserStoreBase.fetchUserRecommendations', context: context);

  @override
  Future<dynamic> fetchUserRecommendations() {
    return _$fetchUserRecommendationsAsyncAction
        .run(() => super.fetchUserRecommendations());
  }

  @override
  String toString() {
    return '''
userStats: ${userStats},
user: ${user},
progress: ${progress},
movieRecommendations: ${movieRecommendations},
showRecommendations: ${showRecommendations}
    ''';
  }
}
