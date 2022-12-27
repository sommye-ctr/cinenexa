import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:watrix/models/network/extensions/extension_stream.dart';
import 'package:watrix/screens/youtube_video_player.dart';
import 'package:watrix/store/details/details_store.dart';

import '../models/network/base_model.dart';
import '../models/network/trakt/trakt_show_history_season.dart';
import '../models/network/trakt/trakt_show_history_season_ep.dart';
import '../models/network/tv_season.dart';
import '../models/network/watch_provider.dart';
import '../resources/strings.dart';
import '../resources/style.dart';
import '../screens/video_player_page.dart';
import '../utils/screen_size.dart';
import '../widgets/horizontal_list.dart';
import 'details_episode_tile.dart';
import 'details_stream_tile.dart';

class DetailsMoreDetailsStreams extends StatefulWidget {
  final DetailsStore detailsStore;
  const DetailsMoreDetailsStreams({
    Key? key,
    required this.detailsStore,
  }) : super(key: key);

  @override
  State<DetailsMoreDetailsStreams> createState() =>
      _DetailsMoreDetailsStreamsState();
}

class _DetailsMoreDetailsStreamsState extends State<DetailsMoreDetailsStreams> {
  @override
  Widget build(BuildContext context) {
    return _build();
  }

  Widget _build() {
    return Observer(
      builder: (context) {
        widget.detailsStore.loadedStreams;
        if (widget.detailsStore.baseModel.type == BaseModelType.movie) {
          return _buildMovieStreams();
        }
        return _buildShowEpisodes();
      },
    );
  }

  Widget _buildShowEpisodes() {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 500),
      transitionBuilder: (child, animation) {
        final offset = Tween(
          begin: Offset(1, 0),
          end: Offset(0, 0),
        ).animate(animation);
        return ClipRect(
          child: SlideTransition(
            position: offset,
            child: child,
          ),
        );
      },
      child: widget.detailsStore.chosenEpisode == null
          ? ListView(
              physics: BouncingScrollPhysics(),
              children: _buildSeasonDetails(),
            )
          : _buildEpisodeStreams(),
    );
  }

  Widget _buildMovieStreams() {
    return ListView(
      physics: BouncingScrollPhysics(),
      children: [
        _buildWatchProviders(),
        if (widget.detailsStore.watchProviders.isNotEmpty)
          Style.getVerticalSpacing(context: context),
        Builder(builder: (context) {
          if (widget.detailsStore.isStreamLoading)
            return Center(child: CircularProgressIndicator());
          return Container();
        }),
        Style.getVerticalSpacing(context: context),
        _buildExtensionStreams(),
      ],
    );
  }

  Widget _buildWatchProviders() {
    return HorizontalList<WatchProvider>.fromInititalValues(
      items: widget.detailsStore.watchProviders,
      heading: Strings.availableAt,
      buildWidget: (item) {
        return UnconstrainedBox(
          child: DetailsStreamTile(
            provider: item,
            hidePlayButton: true,
          ),
        );
      },
      buildPlaceHolder: () => Container(),
      height: ScreenSize.getPercentOfHeight(context, 0.1),
    );
  }

  Widget _buildExtensionStreams() {
    return MasonryGridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: widget.detailsStore.loadedStreams.length,
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return UnconstrainedBox(
          child: DetailsStreamTile(
            extensionStream: widget.detailsStore.loadedStreams[index],
            onClick: (extensionStream, watchProvider) {
              _handleExtensionClick(extensionStream!);
            },
          ),
        );
      },
    );
  }

  Widget _buildEpisodeStreams() {
    DetailsStore store = widget.detailsStore;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            BackButton(
              onPressed: () => store.onEpBackClicked(),
            ),
            Text(
              "${store.tv!.seasons![store.chosenSeason!].name} Episode ${store.episodes[store.chosenEpisode!].episodeNumber}",
              style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
            ),
          ],
        ),
        Observer(
          builder: (context) {
            if (widget.detailsStore.isStreamLoading) {
              return Center(child: CircularProgressIndicator());
            }
            return Container();
          },
        ),
        Expanded(child: _buildExtensionStreams()),
        /* Center(
          child: ElevatedButton(
            onPressed: () {
              var ep = widget.detailsStore
                  .episodes[widget.detailsStore.chosenEpisode!].episodeNumber;

              double? progress;
              TvEpisode episode = widget
                  .detailsStore.episodes[widget.detailsStore.chosenEpisode!];

              if (widget.detailsStore.progress?.episodeNo ==
                      episode.episodeNumber &&
                  widget.detailsStore.progress?.seasonNo ==
                      widget
                          .detailsStore
                          .tv!
                          .seasons![widget.detailsStore.chosenSeason!]
                          .seasonNumber) {
                progress = widget.detailsStore.progress!.progress!;
              }
              navigateToVideoPlayer(
                url: "",
                id: episode.id,
                ep: ep,
                progress: progress,
                season: widget.detailsStore.tv!
                    .seasons![widget.detailsStore.chosenSeason!].seasonNumber,
              );
            },
            child: Text("Play"),
          ),
        ), */
      ],
    );
  }

  void _handleExtensionClick(ExtensionStream extensionStream) {
    if (extensionStream.url != null) {
      navigateToVideoPlayer(
        url:
            "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
        id: widget.detailsStore.baseModel.id!,
        progress: widget.detailsStore.progress?.progress,
      );
    } else if (extensionStream.ytId != null) {
      Navigator.pushNamed(context, YoutubeVideoPlayer.routeName,
          arguments: extensionStream.ytId);
    } else if (extensionStream.magnet != null) {
      navigateToVideoPlayer(
        url: "",
        id: widget.detailsStore.baseModel.id!,
        progress: widget.detailsStore.progress?.progress,
      );
    } else if (extensionStream.external != null) {
      Style.showExternalLinkOpenWarning(
        context: context,
        extensionName: extensionStream.extension?.name ?? "",
        url: extensionStream.external!,
      );
    }
  }

  List<Widget> _buildSeasonDetails() {
    return [
      Observer(builder: (_) => _buildSeasonsHeading()),
      Style.getVerticalSpacing(context: context),
      Observer(
        builder: (context1) {
          widget.detailsStore.showHistory;

          return ListView.builder(
            shrinkWrap: true,
            itemCount: widget.detailsStore.episodes.length,
            physics: ClampingScrollPhysics(),
            itemBuilder: _buildEpisodeTile,
          );
        },
      ),
      Style.getVerticalSpacing(context: context),
    ];
  }

  Widget _buildEpisodeTile(context, index) {
    bool? watched = false;

    Iterable<TraktShowHistorySeason>? iterable =
        widget.detailsStore.showHistory?.seasons?.where(
      (element) =>
          element.number ==
          widget.detailsStore.tv!.seasons![widget.detailsStore.chosenSeason!]
              .seasonNumber,
    );
    if (iterable != null && iterable.isNotEmpty) {
      TraktShowHistorySeason? historySeason = iterable.elementAt(0);
      Iterable<TraktShowHistorySeasonEp>? list = historySeason.episodes?.where(
          (element) =>
              element.number ==
              widget.detailsStore.episodes[index].episodeNumber);
      watched = list != null && list.isNotEmpty;
    }

    return FocusedMenuHolder(
      menuItems: _buildPopupItems(epWatched: watched, index: index),
      onPressed: () {},
      animateMenuItems: true,
      blurSize: 5,
      child: EpisodeTile(
        episode: widget.detailsStore.episodes[index],
        watched: watched,
        onTap: () {
          widget.detailsStore.onEpiodeClicked(index);
          widget.detailsStore.fetchStreams();
        },
      ),
    );
  }

  List<FocusedMenuItem> _buildPopupItems(
      {required bool epWatched, required int index}) {
    return [
      FocusedMenuItem(
        title: Text(epWatched ? Strings.markUnwatched : Strings.markWatched),
        trailingIcon: Icon(
          epWatched
              ? Icons.playlist_remove_rounded
              : Icons.playlist_add_check_rounded,
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        onPressed: () {
          Style.showLoadingDialog(context: context);
          epWatched
              ? widget.detailsStore
                  .markUnwatchedClicked(epIndex: index)
                  .whenComplete(() => Navigator.pop(context))
              : widget.detailsStore
                  .markWatchedClicked(epIndex: index)
                  .whenComplete(() => Navigator.pop(context));
        },
      ),
    ];
  }

  Widget _buildSeasonsHeading() {
    if (widget.detailsStore.baseModel.type == BaseModelType.tv &&
        widget.detailsStore.tv != null) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              Strings.chooseEp,
              style: Style.headingStyle,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Style.largeRoundEdgeRadius),
                border: Border.all(
                  color: Theme.of(context).highlightColor,
                ),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<TvSeason>(
                  alignment: Alignment.centerLeft,
                  borderRadius:
                      BorderRadius.circular(Style.largeRoundEdgeRadius),
                  value: widget.detailsStore.tv!
                      .seasons![widget.detailsStore.chosenSeason!],
                  menuMaxHeight: ScreenSize.getPercentOfHeight(context, 0.25),
                  items: widget.detailsStore.tv!.seasons!.map((e) {
                    return DropdownMenuItem(
                      child: Text(
                        e.name!,
                      ),
                      value: e,
                    );
                  }).toList(),
                  onChanged: (value) {
                    widget.detailsStore.onSeasonChanged(
                        widget.detailsStore.tv!.seasons!.indexOf(value!));
                  },
                ),
              ),
            ),
          ],
        ),
      );
    }
    return SizedBox();
  }

  void navigateToVideoPlayer({
    required String url,
    required int id,
    double? progress,
    int? season,
    int? ep,
  }) async {
    await Navigator.pushNamed(
      context,
      VideoPlayerPage.routeName,
      arguments: {
        //"url":
        //  "magnet:?xt=urn:btih:AA6C8D8201FD572B233B3282DCC5BF9DCFA0F0EB&dn=Youkoso+Jitsuryoku+Shijou+Shugi+no+Kyoushitsu+e+%28Classroom+of+the+Elite%29+%28Season+2%29+%5B1080p%5D%5BHEVC+x265+10bit%5D%5BMulti-Subs%5D+-+Judas&tr=http%3A%2F%2Fnyaa.tracker.wf%3A7777%2Fannounce&tr=http%3A%2F%2Fanidex.moe%3A6969%2Fannounce&tr=udp%3A%2F%2Fopen.stealth.si%3A80%2Fannounce&tr=udp%3A%2F%2Ftracker.opentrackr.org%3A1337%2Fannounce&tr=udp%3A%2F%2Fexodus.desync.com%3A6969%2Fannounce&tr=udp%3A%2F%2Ftracker.torrent.eu.org%3A451%2Fannounce&tr=udp%3A%2F%2Ftracker.opentrackr.org%3A1337%2Fannounce&tr=http%3A%2F%2Ftracker.openbittorrent.com%3A80%2Fannounce&tr=udp%3A%2F%2Fopentracker.i2p.rocks%3A6969%2Fannounce&tr=udp%3A%2F%2Ftracker.internetwarriors.net%3A1337%2Fannounce&tr=udp%3A%2F%2Ftracker.leechers-paradise.org%3A6969%2Fannounce&tr=udp%3A%2F%2Fcoppersurfer.tk%3A6969%2Fannounce&tr=udp%3A%2F%2Ftracker.zer0day.to%3A1337%2Fannounce",
        "url": url,
        "movie": widget.detailsStore.movie,
        "tv": widget.detailsStore.tv,
        "episode": ep,
        "season": season,
        "progress": progress,
        "id": id,
        "model": widget.detailsStore.baseModel,
      },
    );
    await widget.detailsStore.fetchProgress();
  }
}
