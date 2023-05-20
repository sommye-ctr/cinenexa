import 'package:cinenexa/models/network/base_model.dart';
import 'package:cinenexa/resources/style.dart';
import 'package:cinenexa/screens/tv/tv_home_first.dart';
import 'package:cinenexa/store/tv_list/tv_list_store.dart';
import 'package:cinenexa/store/user/user_store.dart';
import 'package:cinenexa/utils/keycode.dart';
import 'package:cinenexa/widgets/tv_horizontal_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../resources/asset.dart';
import '../../resources/custom_scroll_behavior.dart';
import '../../resources/strings.dart';
import '../../store/favorites/favorites_store.dart';
import '../../store/home/tv_home_store.dart';
import '../../utils/screen_size.dart';
import '../details_page.dart';

class TvFavorites extends StatefulWidget {
  final Stream<int> onClickEvents;
  final TvHomeStore homeStore;
  const TvFavorites(
      {required this.onClickEvents, required this.homeStore, Key? key})
      : super(key: key);

  @override
  State<TvFavorites> createState() => _TvFavoritesState();
}

class _TvFavoritesState extends State<TvFavorites> {
  late FavoritesStore store;
  late ItemScrollController itemScrollController;
  final List<TvListStore> listStores = [];

  int yfocus = 0;
  BaseModel? selected;

  @override
  void initState() {
    store = Provider.of<FavoritesStore>(context, listen: false);
    itemScrollController = ItemScrollController();
    listStores.addAll([
      TvListStore<BaseModel>(
        focusChange: _onFocusChange,
        items: store.favorites
          ..where((element) => element.type == BaseModelType.movie),
        isListFocused: true,
      ),
      TvListStore<BaseModel>(
        focusChange: _onFocusChange,
        items: store.favorites
          ..where((element) => element.type == BaseModelType.tv),
      ),
    ]);

    widget.onClickEvents.listen((event) {
      bool railFocused = widget.homeStore.railFocused;
      switch (event) {
        case KEY_UP:
          if (railFocused) {
            widget.homeStore.changeIndex(1);
            return;
          }

          if (listStores[1].isListFocused) {
            listStores[0].changeFocus(true);
            listStores[1].changeFocus(false);
            return;
          }
          break;
        case KEY_RIGHT:
          if (railFocused) {
            widget.homeStore.changeRailFocused(false);
            return;
          }
          _changeListTap(KEY_RIGHT);

          break;
        case KEY_LEFT:
          if (listStores[0].isListFocused) {
            if (listStores[0].focusedIndex == 0) {
              widget.homeStore.changeRailFocused(true);
              return;
            }
            listStores[0].changeIndex(KEY_LEFT);
            return;
          }

          if (listStores[1].isListFocused) {
            if (listStores[1].focusedIndex == 0) {
              widget.homeStore.changeRailFocused(true);
              return;
            }
            listStores[1].changeIndex(KEY_LEFT);
            return;
          }
          break;
        case KEY_DOWN:
          if (railFocused) {
            widget.homeStore.changeIndex(3);
            return;
          }
          if (listStores[0].isListFocused) {
            listStores[0].changeFocus(false);
            listStores[1].changeFocus(true);
          }
          break;
        case KEY_CENTER:
          if (selected != null) {
            Navigator.pushNamed(
              context,
              DetailsPage.routeName,
              arguments: selected,
            );
          }
          break;
        default:
      }
      SystemSound.play(SystemSoundType.click);
    });
    super.initState();
  }

  void _changeListTap(int tap) {
    if (listStores[0].isListFocused) {
      listStores[0].changeIndex(tap);
      return;
    }
    if (listStores[1].isListFocused) {
      listStores[1].changeIndex(tap);
      return;
    }
  }

  void _onFocusChange(BaseModel item) => selected = item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: TvHomeFirst.CHILDREN_PADDING_TOP,
        right: TvHomeFirst.CHILDREN_PADDING_RIGHT,
      ),
      child: Observer(builder: (_) {
        listStores[0].items = store.favorites
            .where((element) => element.type == BaseModelType.movie)
            .toList()
            .asObservable();
        listStores[1].items = store.favorites
            .where((element) => element.type == BaseModelType.tv)
            .toList()
            .asObservable();

        if (store.currentFav.isEmpty) {
          return Center(
            child: Column(
              children: [
                SvgPicture.asset(
                  Asset.notFound,
                  width: ScreenSize.getPercentOfWidth(context, 0.4),
                ),
                Style.getVerticalSpacing(context: context),
                Text(Strings.noResultsFound),
              ],
            ),
          );
        }

        return ScrollConfiguration(
          behavior: CustomScrollBehavior(),
          child: ScrollablePositionedList.separated(
            itemBuilder: (context, index) {
              if (index == 0) {
                return TvHorizontalList(
                  heading: Strings.movies,
                  height: Style.getMovieTileHeight(
                      context: context, widthPercent: 0.145),
                  widthPercentItem: 0.145,
                  tvListStore: listStores[0],
                );
              }
              return TvHorizontalList(
                heading: Strings.shows,
                height: Style.getMovieTileHeight(
                    context: context, widthPercent: 0.145),
                widthPercentItem: 0.145,
                tvListStore: listStores[1],
              );
            },
            separatorBuilder: (context, index) =>
                Style.getVerticalSpacing(context: context),
            itemCount: 2,
            itemScrollController: itemScrollController,
          ),
        );
      }),
    );
  }
}
