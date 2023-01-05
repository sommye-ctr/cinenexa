import 'package:oauth2_client/oauth2_client.dart';

class TraktOAuthClient extends OAuth2Client {
  TraktOAuthClient()
      : super(
          authorizeUrl: "https://trakt.tv/oauth/authorize",
          tokenUrl: "https://api.trakt.tv/oauth/token",
          redirectUri: "cinenexa://trakt",
          customUriScheme: "cinenexa",
        );
}
