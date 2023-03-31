import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:oauth2_client/oauth2_client.dart';
import 'package:oauth2_client/oauth2_helper.dart';
import 'package:cinenexa/models/local/last_activities.dart';
import 'package:cinenexa/models/local/show_history.dart';
import 'package:cinenexa/models/network/base_model.dart';
import 'package:cinenexa/models/network/movie.dart';
import 'package:cinenexa/models/network/trakt/trakt_progress.dart';
import 'package:cinenexa/models/network/trakt_user.dart';
import 'package:cinenexa/models/network/user_stats.dart';
import 'package:cinenexa/services/network/repository.dart';
import 'package:cinenexa/services/network/utils.dart';
import 'package:cinenexa/utils/date_time_formatter.dart';

import '../../models/network/enums/entity_type.dart';
import '../../models/network/trakt/trakt_list.dart';
import '../../models/network/tv.dart';
import '../constants.dart';

import 'package:http/http.dart' as https;

class TraktRepository {
  final OAuth2Helper helper;
  TraktRepository({required OAuth2Client client})
      : helper = OAuth2Helper(
          client,
          clientId: Constants.traktApi,
          grantType: OAuth2Helper.authorizationCode,
          scopes: ['public'],
        );

  Future get(String url) async {
    return helper.get(url, headers: Constants.traktRequestHeaders);
  }

  Future post(String url, {dynamic data}) {
    return helper.post(
      url,
      body: data,
      headers: Constants.traktRequestHeaders,
    );
  }

  Future delete(String url) {
    return helper.delete(url, headers: Constants.traktRequestHeaders);
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

  /// doesnt require trakt login
  Future<List<TraktList>> getSearchList(
      {required String searchTerm, int page = 1}) async {
    Response response = await https.get(
      Uri.parse(
          "https://api.trakt.tv/search/list?query=$searchTerm&page=$page"),
      headers: {
        "Content-type": "application/json",
        "trakt-api-key": Constants.traktApi,
        "trakt-api-version": "2",
      },
    );

    List<TraktList> items = [];

    if (response.statusCode == 200) {
      List list = Utils.parseJson(response.body);

      for (var element in list) {
        items.add(TraktList.fromMap(element));
      }
    }
    return items;
  }

  Future<List<BaseModel>> getListItems({
    required int listId,
    int page = 1,
  }) async {
    Response response = await https.get(
      Uri.parse(
          "https://api.trakt.tv/lists/$listId/items/movie,show?page=$page&limit=15"),
      headers: {
        "Content-type": "application/json",
        "trakt-api-key": Constants.traktApi,
        "trakt-api-version": "2",
      },
    );

    List list = Utils.parseJson(response.body);
    List<BaseModel> baseModels = [];

    await Future.forEach(list, (element) async {
      element as Map;
      if (element['type'] == "movie") {
        Movie movie = await Repository.getMovieDetails(
            id: (element)['movie']['ids']['tmdb']);
        baseModels.add(BaseModel.fromMovie(movie));
        return;
      }
      Tv tv = await Repository.getTvDetails(
        id: (element)['show']['ids']['tmdb'],
      );
      baseModels.add(BaseModel.fromTv(tv));
    });
    return baseModels;
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
            pausedAt: DateTimeFormatter.parseDate(element['paused_at']),
            playbackId: element['id'],
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
          pausedAt: DateTimeFormatter.parseDate(element['paused_at']),
          playbackId: element['id'],
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

  Future removeProgress({required int progressId}) async {
    await delete("https://api.trakt.tv/sync/playback/$progressId");
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

  Future<TraktUser> getUserProfile() async {
    Response resp = await get("https://api.trakt.tv/users/me?extended=full");
    return TraktUser.fromJson(resp.body);
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

  Future<int> scrobbleStart({
    required BaseModelType type,
    required int tmdbId,
    required double progress,
  }) async {
    Map body;
    if (type == BaseModelType.movie) {
      body = {
        "movie": {
          "ids": {
            "tmdb": tmdbId,
          }
        },
        "progress": progress,
      };
    } else {
      body = {
        "episode": {
          "ids": {
            "tmdb": tmdbId,
          }
        },
        "progress": progress,
      };
    }
    Response resp = await post("https://api.trakt.tv/scrobble/start",
        data: Utils.encodeJson(body));
    return Utils.parseJson(resp.body)['id'];
  }

  Future<int> scrobblePause({
    required BaseModelType type,
    required int tmdbId,
    required double progress,
  }) async {
    Map body;
    if (type == BaseModelType.movie) {
      body = {
        "movie": {
          "ids": {
            "tmdb": tmdbId,
          }
        },
        "progress": progress,
      };
    } else {
      body = {
        "episode": {
          "ids": {
            "tmdb": tmdbId,
          }
        },
        "progress": progress,
      };
    }
    Response resp = await post("https://api.trakt.tv/scrobble/pause",
        data: Utils.encodeJson(body));
    return Utils.parseJson(resp.body)['id'];
  }

  Future scrobbleStop({
    required BaseModelType type,
    required int tmdbId,
    required double progress,
  }) async {
    Map body;
    if (type == BaseModelType.movie) {
      body = {
        "movie": {
          "ids": {
            "tmdb": tmdbId,
          }
        },
        "progress": progress,
      };
    } else {
      body = {
        "episode": {
          "ids": {
            "tmdb": tmdbId,
          }
        },
        "progress": progress,
      };
    }
    await post("https://api.trakt.tv/scrobble/stop",
        data: Utils.encodeJson(body));
  }
}
