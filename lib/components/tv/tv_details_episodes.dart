import 'package:cinenexa/components/tv/tv_details_drawer.dart';
import 'package:cinenexa/components/tv/tv_details_streams.dart';
import 'package:cinenexa/models/network/tv_episode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:cinenexa/components/tv/tv_episode_tile.dart';

import '../../store/details/details_store.dart';

class TvDetailsEpisodes extends StatefulWidget {
  final DetailsStore detailsStore;
  const TvDetailsEpisodes({required this.detailsStore, Key? key})
      : super(key: key);

  @override
  State<TvDetailsEpisodes> createState() => _TvDetailsEpisodesState();
}

class _TvDetailsEpisodesState extends State<TvDetailsEpisodes> {
  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return TvDetailsDrawer<TvEpisode>(
        leftChildren:
            widget.detailsStore.tv!.seasons!.map((e) => e.name ?? "").toList(),
        rightChildren: widget.detailsStore.episodes,
        initialyFocusLeft: widget.detailsStore.chosenSeason,
        onLeftChildClicked: (index) =>
            widget.detailsStore.onSeasonChanged(index),
        onRightWidgetBuild: (item) => Container(
          child: TvEpisodeTile(
            episode: widget.detailsStore
                .episodes[widget.detailsStore.episodes.indexOf(item)],
          ),
        ),
        onRightWidgetClicked: (item) {
          showDialog(
            context: context,
            builder: (context) {
              return TvDetailsStreams(
                detailStore: widget.detailsStore,
              );
            },
          );
        },
      );
    });
  }
}
