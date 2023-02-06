import 'package:cinenexa/models/network/base_model.dart';
import 'package:cinenexa/models/network/tv.dart';
import 'package:cinenexa/models/network/tv_episode.dart';
import 'package:cinenexa/store/details/details_store.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/local/progress.dart';
import '../models/network/extensions/extension_stream.dart';
import '../models/network/movie.dart';
import '../screens/video_player_page.dart';

class LinkOpener {
  static Future openLink(String url) async {
    Uri uri = Uri.parse(url);
    if (!uri.hasAbsolutePath) {
      uri = Uri.parse("https://${url}");
    }
    return launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );
  }

  static Future navigateToVideoPlayer({
    required ExtensionStream stream,
    required int id,
    Progress? progress,
    int? season,
    int? ep,
    Tv? tv,
    Movie? movie,
    required BaseModel baseModel,
    DetailsStore? detailsStore,
    context,
  }) async {
    return Navigator.pushNamed(
      context,
      VideoPlayerPage.routeName,
      arguments: {
        "stream": stream,
        "movie": movie,
        "tv": tv,
        "episode": ep,
        "season": season,
        "progress": progress,
        "id": id,
        "model": baseModel,
        'store': detailsStore,
      },
    );
  }
}
