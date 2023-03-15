import 'package:cinenexa/models/local/progress.dart';
import 'package:cinenexa/utils/link_opener.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:lottie/lottie.dart';
import 'package:cinenexa/models/network/extensions/extension_stream.dart';
import 'package:cinenexa/resources/asset.dart';
import 'package:cinenexa/screens/youtube_video_player.dart';
import 'package:cinenexa/store/details/details_store.dart';
import 'package:cinenexa/widgets/rounded_button.dart';

import '../../models/network/base_model.dart';
import '../../models/network/trakt/trakt_show_history_season.dart';
import '../../models/network/trakt/trakt_show_history_season_ep.dart';
import '../../models/network/tv_episode.dart';
import '../../models/network/tv_season.dart';
import '../../models/network/watch_provider.dart';
import '../../resources/strings.dart';
import '../../resources/style.dart';
import '../../utils/screen_size.dart';
import '../../widgets/horizontal_list.dart';
import 'details_episode_tile.dart';
import 'details_stream_tile.dart';

class DetailsMoreDetailsStreams extends StatefulWidget {
  final DetailsStore detailsStore;
  final ScrollController controller;
  const DetailsMoreDetailsStreams({
    Key? key,
    required this.detailsStore,
    required this.controller,
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
          return _buildStreams();
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

  Widget _buildStreams() {
    return ListView(
      physics: BouncingScrollPhysics(),
      children: [
        _buildWatchProviders(),
        if (widget.detailsStore.watchProviders.isNotEmpty)
          Style.getVerticalSpacing(context: context),
        Observer(builder: (context) {
          if (widget.detailsStore.noOfExtensions == 0) {
            return _buildInstallExtensionsHelp();
          }

          if (!widget.detailsStore.isStreamLoading &&
              widget.detailsStore.loadedStreams.isEmpty) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  Asset.notFound,
                  width: ScreenSize.getPercentOfWidth(context, 0.75),
                ),
                Text(
                  Strings.noStreamsReturnedHelp,
                  textAlign: TextAlign.center,
                ),
                Style.getVerticalSpacing(context: context),
                _buildInstallExtensionsButton(),
              ],
            );
          }
          return Column(
            children: [
              if (widget.detailsStore.isStreamLoading)
                Center(
                  child: CircularProgressIndicator(),
                ),
              if (widget.detailsStore.isStreamLoading)
                Style.getVerticalSpacing(context: context),
              _buildStreamsList(),
            ],
          );
        }),
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

  Widget _buildInstallExtensionsHelp() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          Asset.installExtensions,
          width: ScreenSize.getPercentOfWidth(context, 0.75),
        ),
        Style.getVerticalSpacing(context: context),
        Text(
          Strings.installExtensionsHelp,
          textAlign: TextAlign.center,
        ),
        Style.getVerticalSpacing(context: context),
        _buildInstallExtensionsButton(),
      ],
    );
  }

  Widget _buildInstallExtensionsButton() {
    return RoundedButton(
      type: RoundedButtonType.outlined,
      onPressed: () => Navigator.pop(context, true),
      child: Text(Strings.installExtensions),
    );
  }

  Widget _buildStreamsList() {
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
        Expanded(child: _buildStreams()),
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
        stream: extensionStream,
        id: widget.detailsStore.baseModel.id!,
        progress: widget.detailsStore.baseModel.type == BaseModelType.movie
            ? widget.detailsStore.progress
            : _getProgressForShow(),
        ep: widget.detailsStore.chosenEpisode != null
            ? widget.detailsStore.episodes[widget.detailsStore.chosenEpisode!]
                .episodeNumber
            : null,
        season: widget.detailsStore.chosenSeason != null
            ? (widget.detailsStore.tv
                    ?.seasons?[widget.detailsStore.chosenSeason!])
                ?.seasonNumber
            : null,
      );
    } else if (extensionStream.ytId != null) {
      Navigator.pushNamed(context, YoutubeVideoPlayer.routeName,
          arguments: extensionStream.ytId);
    } else if (extensionStream.magnet != null) {
      navigateToVideoPlayer(
        stream: extensionStream,
        id: widget.detailsStore.baseModel.id!,
        progress: widget.detailsStore.baseModel.type == BaseModelType.movie
            ? widget.detailsStore.progress
            : _getProgressForShow(),
        ep: widget.detailsStore.chosenEpisode != null
            ? widget.detailsStore.episodes[widget.detailsStore.chosenEpisode!]
                .episodeNumber
            : null,
        season: widget.detailsStore.chosenSeason != null
            ? (widget.detailsStore.tv
                    ?.seasons?[widget.detailsStore.chosenSeason!])
                ?.seasonNumber
            : null,
      );
    } else if (extensionStream.external != null) {
      Style.showExternalLinkOpenWarning(
        context: context,
        extensionName: extensionStream.extension?.name ?? "",
        url: extensionStream.external!,
      );
    }
  }

  Progress? _getProgressForShow() {
    Progress? progress;
    TvEpisode episode =
        widget.detailsStore.episodes[widget.detailsStore.chosenEpisode!];

    if (widget.detailsStore.progress?.episodeNo == episode.episodeNumber &&
        widget.detailsStore.progress?.seasonNo ==
            widget.detailsStore.tv!.seasons![widget.detailsStore.chosenSeason!]
                .seasonNumber) {
      progress = widget.detailsStore.progress;
    }
    return progress;
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
    required ExtensionStream stream,
    required int id,
    Progress? progress,
    int? season,
    int? ep,
  }) async {
    await LinkOpener.navigateToVideoPlayer(
      stream: stream,
      id: id,
      baseModel: widget.detailsStore.baseModel,
      context: context,
      ep: ep,
      season: season,
      progress: progress,
      movie: widget.detailsStore.movie,
      tv: widget.detailsStore.tv,
      detailsStore: widget.detailsStore,
      showHistory: widget.detailsStore.showHistory,
    );

    Future.delayed(
      Duration(milliseconds: 500),
      () {
        widget.controller.animateTo(
          widget.controller.position.maxScrollExtent,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeIn,
        );
      },
    );

    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    await widget.detailsStore.fetchProgress();
  }
}
