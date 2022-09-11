// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:http/http.dart';
import 'package:oauth2_client/oauth2_client.dart';
import 'package:oauth2_client/oauth2_helper.dart';
import 'package:watrix/models/network/user.dart';
import 'package:watrix/models/network/user_stats.dart';

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
}
