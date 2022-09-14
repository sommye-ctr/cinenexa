import 'package:mobx/mobx.dart';
import 'package:watrix/models/network/trakt/trakt_progress.dart';
import 'package:watrix/models/network/user.dart';
import 'package:watrix/models/network/user_stats.dart';
import 'package:watrix/services/network/trakt_oauth_client.dart';
import 'package:watrix/services/network/trakt_repository.dart';
part 'user_store.g.dart';

class UserStore = _UserStoreBase with _$UserStore;

abstract class _UserStoreBase with Store {
  @observable
  UserStats? userStats;

  @observable
  User? user;

  @observable
  ObservableList<TraktProgress> progress = <TraktProgress>[].asObservable();

  TraktRepository repository = TraktRepository(client: TraktOAuthClient());

  @action
  Future fetchUserProfile() async {
    user = await repository.getUserProfile();
  }

  @action
  Future fetchUserStats() async {
    userStats = await repository.getUserStats();
  }

  @action
  Future fetchUserProgress() async {
    progress.addAll(await repository.getUserMovieProgress());
  }
}
