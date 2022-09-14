import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:watrix/models/network/review.dart';
import 'package:watrix/services/network/api.dart';
import 'package:watrix/services/network/utils.dart';

import '../../models/network/base_model.dart';

import '../../models/network/certification.dart';
import '../../models/network/enums/entity_type.dart';
import '../../models/network/genre.dart';
import '../../models/network/movie.dart';
import '../../models/network/people.dart';
import '../../models/network/tv.dart';
import '../../models/network/tv_episode.dart';
import '../../models/network/video.dart';
import '../constants.dart';

class Repository {
  static Api api = Api();

  static Future<List<BaseModel>> getTitles(
    String request, {
    int? limit,
    bool? shuffle,
    int page = 1,
  }) async {
    String req = "$request?page=$page";
    final response = await api.getRequest(req, haveQueries: true);
    var parsedList = response['results'];

    return Utils.convertToBaseModelListWithSkipLimit(
      parsedList,
      limit ?? Constants.homeLimit,
      shuffle ?? false,
    );
  }

  static Future<List<Genre>> getGenre(String request) async {
    final response = await api.getRequest(request);
    var parsedList = response['genres'];
    return (parsedList as List).map((e) => Genre.fromMap(e)).toList();
  }

  static Future<List<Certification>> getCertification(String query) async {
    final response = await api.getRequest(query);
    var parsedList = response['certifications']['IN'];
    return (parsedList as List).map((e) => Certification.fromMap(e)).toList();
  }

  static Future<List<BaseModel>> search(
    String query,
    EntityType type, {
    int page = 1,
  }) async {
    if (query.length < 1) {
      throw ErrorHint(
          "The length of query term cannot be less than 1 characters");
    }
    String stringType;
    if (type == EntityType.movie) {
      stringType = Constants.movie;
    } else if (type == EntityType.tv) {
      stringType = Constants.tv;
    } else if (type == EntityType.people) {
      stringType = Constants.person;
    } else if (type == EntityType.all) {
      stringType = Constants.multi;
    } else {
      throw FlutterError("Invalid media type");
    }

    String encoded = Uri.encodeFull(query);
    final response = await api.getRequest(
      "${Constants.search}${stringType}?query=$encoded&page=$page",
      haveQueries: true,
    );
    var parsedList = response['results'];
    return Utils.convertToBaseModelList(parsedList);
  }

  static Future<List<BaseModel>> discover({
    required String query,
    required EntityType type,
    int page = 1,
  }) async {
    String stringType =
        type == EntityType.movie ? Constants.movie : Constants.tv;
    String request = "${Constants.discover}${stringType}?$query&page=$page";

    final response = await api.getRequest(request, haveQueries: true);
    var parsedList = response['results'];
    return Utils.convertToBaseModelList(parsedList);
  }

  static Future<Map> getReviews({required String query, int page = 1}) async {
    String req = "$query?page=$page";
    final Response response = await api.getTraktRequest(req);

    List list = Utils.parseJson(response.body);
    return {
      "total": int.parse(response.headers["x-pagination-item-count"]!),
      "results": list.map((e) => Review.fromMap(e)).toList(),
    };
  }

  static Future<int> getTraktIdFromTmdb(
      {required int tmdbId, required String type}) async {
    String req = "${Constants.search}/tmdb/$tmdbId?type=$type";
    Response response = await api.getTraktRequest(req);
    List list = Utils.parseJson(response.body);
    return list.first[type]['ids']['trakt'];
  }

  static Future<Map> getMovieDetailsWithExtras({required int id}) async {
    final response = await api.getRequest(
      "${Constants.movie}/${id}?append_to_response=credits,recommendations,videos",
      haveQueries: true,
    );
    Video? vid = Utils.convertToVideo(response['videos']['results'] as List);
    return {
      "movie": Movie.fromMap(response),
      "credits": Utils.convertToBaseModelList(response['credits']['cast']),
      "recommended":
          Utils.convertToBaseModelList(response['recommendations']['results']),
      "video": vid,
    };
  }

  static Future<Movie> getMovieDetails({required int id}) async {
    final response = await api.getRequest(
      "${Constants.movie}/${id}",
    );
    return Movie.fromMap(response);
  }

  static Future<Tv> getTvDetails({required int id}) async {
    final response = await api.getRequest(
      "${Constants.tv}/${id}",
    );
    return Tv.fromMap(response);
  }

  static Future<Map> getTvDetailsWithExtras({required int id}) async {
    final response = await api.getRequest(
      "${Constants.tv}/${id}?append_to_response=credits,recommendations,videos",
      haveQueries: true,
    );
    Video? vid = Utils.convertToVideo(response['videos']['results'] as List);
    return {
      "tv": Tv.fromMap(response),
      "credits": Utils.convertToBaseModelList(response['credits']['cast']),
      "recommended":
          Utils.convertToBaseModelList(response['recommendations']['results']),
      "video": vid,
    };
  }

  static Future<Map> getPeopleDetails({required int id}) async {
    final response = await api.getRequest(
      "${Constants.person}/${id}?append_to_response=combined_credits",
      haveQueries: true,
    );
    return {
      "person": People.fromMap(response),
      "credits":
          Utils.convertToBaseModelList(response['combined_credits']['cast'])
    };
  }

  static Future<List<TvEpisode>> getSeasonEpisodes(
      {required int tvId, required int seasonNo}) async {
    final response =
        await api.getRequest("${Constants.tv}/${tvId}/season/$seasonNo");
    var parsedList = response['episodes'];
    return (parsedList as List).map((e) => TvEpisode.fromMap(e)).toList();
  }
}
