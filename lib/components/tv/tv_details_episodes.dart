import 'package:cinenexa/models/network/tv_episode.dart';
import 'package:cinenexa/utils/keycode.dart';
import 'package:cinenexa/utils/screen_size.dart';
import 'package:cinenexa/widgets/rounded_button.dart';
import 'package:cinenexa/widgets/tv_horizontal_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:cinenexa/components/tv/tv_episode_tile.dart';

import '../../store/details/details_store.dart';
import '../../store/tv_list/tv_list_store.dart';
import '../../widgets/tv_drawer.dart';

class TvDetailsEpisodes extends StatefulWidget {
  final DetailsStore detailsStore;
  const TvDetailsEpisodes({required this.detailsStore, Key? key})
      : super(key: key);

  @override
  State<TvDetailsEpisodes> createState() => _TvDetailsEpisodesState();
}

class _TvDetailsEpisodesState extends State<TvDetailsEpisodes> {
  final FocusNode focus = FocusNode();
  final List<RoundedButtonController> controllers = [];
  late TvListStore<TvEpisode> tvListStore;

  int yFocusSeason = 0;

  @override
  void initState() {
    for (var _ in widget.detailsStore.tv!.seasons!) {
      controllers.add(RoundedButtonController(type: RoundedButtonType.text));
    }
    yFocusSeason = widget.detailsStore.chosenSeason ?? 0;
    controllers[yFocusSeason].changeType(RoundedButtonType.filled);

    tvListStore = TvListStore<TvEpisode>(
      focusChange: (item) {},
      items: widget.detailsStore.episodes,
    );

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      focus.requestFocus();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: focus,
      onKey: _handleKeyboard,
      child: TvDrawer(
        leftChild: ListView.builder(
            itemCount: widget.detailsStore.tv!.seasons!.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: UnconstrainedBox(
                  child: RoundedButton.controller(
                    onPressed: () {
                      widget.detailsStore.onSeasonChanged(index);
                      controllers[index].changeType(RoundedButtonType.outlined);
                    },
                    controller: controllers[index],
                    child: Text(
                      widget.detailsStore.tv!.seasons![index].name ?? "",
                    ),
                  ),
                ),
              );
            }),
        rightChild: Observer(builder: (_) {
          if (widget.detailsStore.episodes.isEmpty) {
            return Container();
          }

          return TvHorizontalList<TvEpisode>.fromInititalValues(
            heading: "",
            widthPercentItem: ScreenSize.getPercentOfWidth(context, 0.2),
            tvListStore: tvListStore,
            onWidgetBuild: (item) => TvEpisodeTile(
              episode: widget.detailsStore
                  .episodes[widget.detailsStore.episodes.indexOf(item)],
            ),
            direction: Axis.vertical,
          );
        }),
      ),
    );
  }

  void _handleKeyboard(RawKeyEvent event) {
    if (!(event is RawKeyDownEvent)) {
      return;
    }
    RawKeyEventDataAndroid rawKeyEventData =
        event.data as RawKeyEventDataAndroid;

    int seasons = widget.detailsStore.tv!.seasons!.length;
    switch (rawKeyEventData.keyCode) {
      case KEY_RIGHT:
        if (!tvListStore.isListFocused) {
          tvListStore.changeFocus(true);
          controllers[yFocusSeason].changeType(RoundedButtonType.text);
        }
        break;

      case KEY_LEFT:
        if (tvListStore.isListFocused) {
          tvListStore.changeFocus(false);
          controllers[yFocusSeason].changeType(RoundedButtonType.filled);
        }
        break;
      case KEY_DOWN:
        if (tvListStore.isListFocused) {
          tvListStore.changeIndex(KEY_RIGHT);
          return;
        }
        if (yFocusSeason != seasons - 1) {
          controllers[yFocusSeason].changeType(RoundedButtonType.text);
          yFocusSeason++;
          _changeSeasonConfig();
        }
        break;
      case KEY_UP:
        if (tvListStore.isListFocused) {
          tvListStore.changeIndex(KEY_LEFT);
          return;
        }
        if (yFocusSeason != 0) {
          controllers[yFocusSeason].changeType(RoundedButtonType.text);
          yFocusSeason--;
          _changeSeasonConfig();
        }
        break;
      default:
    }
  }

  void _changeSeasonConfig() {
    controllers[yFocusSeason].changeType(RoundedButtonType.filled);
    widget.detailsStore.onSeasonChanged(yFocusSeason);
  }
}
