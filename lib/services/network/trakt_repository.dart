import 'package:http/http.dart';
import 'package:oauth2_client/oauth2_client.dart';
import 'package:oauth2_client/oauth2_helper.dart';
import 'package:watrix/models/network/movie.dart';
import 'package:watrix/models/network/trakt/trakt_progress.dart';
import 'package:watrix/models/network/user.dart';
import 'package:watrix/models/network/user_stats.dart';
import 'package:watrix/services/network/repository.dart';
import 'package:watrix/services/network/utils.dart';

import '../../models/network/tv.dart';
import '../constants.dart';

class TraktRepository {
  final OAuth2Helper helper;
  TraktRepository({required OAuth2Client client})
      : helper = OAuth2Helper(
          client,
          clientId: Constants.traktApi,
          grantType: OAuth2Helper.AUTHORIZATION_CODE,
          scopes: ['public'],
        );

  Future get(String url) {
    return helper.get(url, headers: Constants.traktRequestHeaders);
  }

  Future<UserStats> getUserStats() async {
    Response resp = await get("https://api.trakt.tv/users/me/stats");

    return UserStats.fromJson(resp.body);
  }

  Future<User> getUserProfile() async {
    Response resp = await get("https://api.trakt.tv/users/me?extended=full");
    return User.fromJson(resp.body);
  }

  Future<List<TraktProgress>> getUserProgress() async {
    Response resp = await get("https://api.trakt.tv/sync/playback/episodes");

    List list = (Utils.parseJson(resp.body) as List);
    List<TraktProgress> progressList = [];
    await Future.forEach(list, (element) async {
      element as Map;
      Tv tv = await Repository.getTvDetails(
        id: (element)['show']['ids']['tmdb'],
      );
      progressList.add(
        TraktProgress(
          progress: element['progress'],
          type: element['type'],
          show: tv,
          episodeNo: element['episode']['number'],
          seasonNo: element['episode']['season'],
        ),
      );
    });

    return progressList;
  }

  Future<List<TraktProgress>> getUserMovieProgress() async {
    Response resp = await get("https://api.trakt.tv/sync/playback");
    List list = (Utils.parseJson(resp.body) as List);
    List<TraktProgress> progressList = [];

    await Future.forEach(list, (element) async {
      element as Map;
      if (element['type'] == "movie") {
        Movie movie = await Repository.getMovieDetails(
            id: (element)['movie']['ids']['tmdb']);
        progressList.add(
          TraktProgress(
            progress: element['progress'],
            type: element['type'],
            movie: movie,
          ),
        );
        return;
      }
      Tv tv = await Repository.getTvDetails(
        id: (element)['show']['ids']['tmdb'],
      );
      progressList.add(
        TraktProgress(
          progress: element['progress'],
          type: element['type'],
          show: tv,
          episodeNo: element['episode']['number'],
          seasonNo: element['episode']['season'],
        ),
      );
    });

    return progressList;
  }

  Future getUserWatched() async {
    Response resp = await get("https://api.trakt.tv/sync/watched/shows");
    //print(resp.body);
  }
}
