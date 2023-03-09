import 'package:cinenexa/models/local/show_history.dart';
import 'package:cinenexa/models/network/base_model.dart';
import 'package:cinenexa/models/network/tv.dart';
import 'package:cinenexa/services/network/analytics.dart';
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
    ShowHistory? showHistory,
    context,
  }) async {
    Analytics().logMoviePlay(title: baseModel.title!, tmdbId: baseModel.id!);
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
        "showHistory": showHistory,
      },
    );
  }
}
