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

  late final _$fetchUserStatsAsyncAction =
      AsyncAction('_UserStoreBase.fetchUserStats', context: context);

  @override
  Future<dynamic> fetchUserStats() {
    return _$fetchUserStatsAsyncAction.run(() => super.fetchUserStats());
  }

  @override
  String toString() {
    return '''
userStats: ${userStats}
    ''';
  }
}
