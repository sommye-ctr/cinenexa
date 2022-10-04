import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:oauth2_client/oauth2_client.dart';
import 'package:oauth2_client/oauth2_helper.dart';
import 'package:watrix/models/local/last_activities.dart';
import 'package:watrix/models/local/show_history.dart';
import 'package:watrix/models/network/base_model.dart';
import 'package:watrix/models/network/movie.dart';
import 'package:watrix/models/network/trakt/trakt_progress.dart';
import 'package:watrix/models/network/user.dart';
import 'package:watrix/models/network/user_stats.dart';
import 'package:watrix/services/network/repository.dart';
import 'package:watrix/services/network/utils.dart';
import 'package:watrix/utils/date_time_formatter.dart';

import '../../models/network/enums/entity_type.dart';
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

  Future post(String url, {dynamic data}) {
    return helper.post(
      url,
      body: data,
      headers: Constants.traktRequestHeaders,
    );
  }

  Future<LastActivities> getUserLastActivity() async {
    Response resp = await get("https://api.trakt.tv/sync/last_activities");
    Map map = Utils.parseJson(resp.body) as Map;

    return LastActivities()
      ..epWatchedAt =
          DateTimeFormatter.parseDate(map['episodes']['watched_at'])!
      ..epCollectedAt =
          DateTimeFormatter.parseDate(map['episodes']['collected_at'])!
      ..movieCollectedAt =
          DateTimeFormatter.parseDate(map['movies']['collected_at'])!
      ..movieWatchedAt =
          DateTimeFormatter.parseDate(map['movies']['watched_at'])!;
  }

  Future<UserStats> getUserStats() async {
    Response resp = await get("https://api.trakt.tv/users/me/stats");

    return UserStats.fromJson(resp.body);
  }

  Future<User> getUserProfile() async {
    Response resp = await get("https://api.trakt.tv/users/me?extended=full");
    return User.fromJson(resp.body);
  }

  Future<List<BaseModel>> getUserFavorites() async {
    List list = await Future.wait([
      get("https://api.trakt.tv/sync/collection/movies"),
      get("https://api.trakt.tv/sync/collection/shows")
    ]);
    Response movieResp = list[0];
    Response tvResp = list[1];

    List movieList = (Utils.parseJson(movieResp.body) as List);
    List tvList = (Utils.parseJson(tvResp.body) as List);

    List<BaseModel> basemodels = [];
    await Future.forEach(movieList..addAll(tvList), (element) async {
      element as Map;
      if (element['movie'] != null) {
        Movie movie = await Repository.getMovieDetails(
            id: (element)['movie']['ids']['tmdb']);
        basemodels.add(BaseModel.fromMovie(movie));
        return;
      }
      Tv tv =
          await Repository.getTvDetails(id: (element)['show']['ids']['tmdb']);
      basemodels.add(BaseModel.fromTv(tv));
    });
    return basemodels;
  }

  Future<List<TraktProgress>> getUserProgress() async {
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

  Future<List<ShowHistory>> getUserWatched() async {
    Response resp = await get("https://api.trakt.tv/sync/watched/shows");
    List list = (Utils.parseJson(resp.body) as List);

    List<ShowHistory> respList = [];
    await Future.forEach(list, (element) async {
      element as Map;

      Tv tv = await Repository.getTvDetails(id: element['show']['ids']['tmdb']);

      respList.add(ShowHistory.fromMap({
        "show": tv.toMap(),
        "seasons": element['seasons'],
        "last_updated_at": element['last_updated_at'],
      }));
    });
    return respList;
  }

  Future getRecommendations({
    required EntityType type,
    int page = 1,
  }) async {
    String stringType;
    if (type == EntityType.movie) {
      stringType = Constants.movies;
    } else if (type == EntityType.tv) {
      stringType = Constants.shows;
    } else {
      throw FlutterError("Invalid media type");
    }
    Response resp = await get(
        "https://api.trakt.tv/recommendations/$stringType?ignore_collected=false&page=$page");
    List list = Utils.parseJson(resp.body);

    List<BaseModel> respList = [];
    await Future.forEach(list, (element) async {
      element as Map;
      if (type == EntityType.movie) {
        respList.add(BaseModel.fromMovie(
            await Repository.getMovieDetails(id: element['ids']['tmdb'])));
        return;
      }
      respList.add(BaseModel.fromTv(
          await Repository.getTvDetails(id: element['ids']['tmdb'])));
    });

    return respList;
  }

  Future addToWatched({required int tmdbEpId}) async {
    Map ep = {
      "watched_at": DateTime.now().toIso8601String(),
      "ids": {
        "tmdb": tmdbEpId,
      }
    };

    Map body = {
      "episodes": [ep]
    };
    await post("https://api.trakt.tv/sync/history",
        data: Utils.encodeJson(body));
  }

  Future removeFromWatched({required int tmdbEpId}) async {
    Map body = {
      "episodes": [
        {
          "ids": {
            "tmdb": tmdbEpId,
          },
        }
      ],
    };
    await post(
      "https://api.trakt.tv/sync/history/remove",
      data: Utils.encodeJson(body),
    );
  }

//this adds to the "Collected" in trakt
  Future addFavorite(
      {required int tmdbId, required EntityType entityType}) async {
    Map body;
    if (entityType == EntityType.movie) {
      body = {
        "movies": [
          {
            "ids": {
              "tmdb": tmdbId,
            }
          }
        ]
      };
    } else {
      body = {
        "shows": [
          {
            "ids": {
              "tmdb": tmdbId,
            }
          }
        ]
      };
    }
    await post("https://api.trakt.tv/sync/collection",
        data: Utils.encodeJson(body));
  }

  Future removeFavorites({
    required List<int>? movieTmdbIds,
    required List<int>? showTmdbIds,
  }) async {
    Map body;
    List<Map> movieBodies = [];
    List<Map> showBodies = [];

    if (movieTmdbIds != null) {
      for (var tmdbId in movieTmdbIds) {
        movieBodies.add({
          "ids": {
            "tmdb": tmdbId,
          }
        });
      }
    }
    if (showTmdbIds != null) {
      for (var tmdbId in showTmdbIds) {
        showBodies.add({
          "ids": {
            "tmdb": tmdbId,
          }
        });
      }
    }

    body = {"movies": movieBodies, "shows": showBodies};

    await post(
      "https://api.trakt.tv/sync/collection/remove",
      data: Utils.encodeJson(body),
    );
  }

  Future removeFavorite(
      {required int tmdbId, required EntityType entityType}) async {
    Map body;
    if (entityType == EntityType.movie) {
      body = {
        "movies": [
          {
            "ids": {
              "tmdb": tmdbId,
            }
          }
        ]
      };
    } else {
      body = {
        "shows": [
          {
            "ids": {
              "tmdb": tmdbId,
            }
          }
        ]
      };
    }
    await post("https://api.trakt.tv/sync/collection/remove",
        data: Utils.encodeJson(body));
  }
}
