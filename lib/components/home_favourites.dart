import 'package:badges/badges.dart' as Badge;
import 'package:cinenexa/resources/asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:cinenexa/components/favorites_entity_tile.dart';
import 'package:cinenexa/resources/strings.dart';
import 'package:cinenexa/resources/style.dart';
import 'package:cinenexa/services/network/utils.dart';
import 'package:cinenexa/store/favorites/favorites_store.dart';
import 'package:cinenexa/store/user/user_store.dart';
import 'package:cinenexa/utils/screen_size.dart';

import '../models/network/base_model.dart';
import '../screens/details_page.dart';
import 'home_bottom_nav_bar.dart';

class HomeFavorites extends StatefulWidget {
  const HomeFavorites({Key? key}) : super(key: key);

  @override
  State<HomeFavorites> createState() => _HomeFavoritesState();
}

class _HomeFavoritesState extends State<HomeFavorites>
    with AutomaticKeepAliveClientMixin {
  late FavoritesStore store;
  final List<GlobalKey<FavoritesEntityTileState>> keys = [];

  @override
  void initState() {
    store = Provider.of<FavoritesStore>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      body: _buildBody(),
      floatingActionButton: Observer(builder: (context) => _buildFab()),
      floatingActionButtonLocation: ExpandableFab.location,
    );
  }

  Widget _buildBody() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Observer(builder: (_) {
          return _buildHeading();
        }),
        Style.getVerticalSpacing(context: context),
        Observer(
          builder: (_) {
            store.multiSelectEnabled;

            if (store.currentFav.isEmpty) {
              return Column(
                children: [
                  SvgPicture.asset(
                    Asset.notFound,
                    width: ScreenSize.getPercentOfWidth(context, 0.75),
                  ),
                  Style.getVerticalSpacing(context: context),
                  Text(Strings.noResultsFound),
                ],
              );
            }
            return Expanded(
              child: GridView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: Style.movieTileWithTitleRatio,
                ),
                itemCount: store.currentFav.length,
                itemBuilder: (context, index) {
                  keys.add(GlobalKey());

                  return FavoritesEntityTile(
                    key: keys[index],
                    image:
                        Utils.getPosterUrl(store.currentFav[index].posterPath!),
                    width: ScreenSize.getPercentOfWidth(context, 0.3),
                    showTitle: false,
                    onClick: () =>
                        itemClicked(context, store.currentFav[index]),
                    checked: store.checkedFavoritesIds
                        .contains(store.currentFav[index].id),
                    showCheckIcon: store.multiSelectEnabled,
                    onLongClick: () {
                      store.multiSelectEnabled = true;
                    },
                    onCheckClick: (checked) {
                      if (checked) {
                        store.addCheckedFav(id: store.currentFav[index].id!);
                        return;
                      }
                      store.removeCheckedFav(id: store.currentFav[index].id!);
                    },
                  );
                },
              ),
            );
          },
        ),
        Style.getVerticalSpacing(
          context: context,
          percent: 0.08,
        ),
      ],
    );
  }

  void itemClicked(BuildContext context, BaseModel baseModel) {
    Navigator.pushNamed(context, DetailsPage.routeName, arguments: baseModel);
  }

  Widget _buildHeading() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "${store.currentFav.length} Results",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
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
            child: DropdownButton<int>(
              alignment: Alignment.centerLeft,
              borderRadius: BorderRadius.circular(Style.largeRoundEdgeRadius),
              value: store.chosenFilter,
              menuMaxHeight: ScreenSize.getPercentOfHeight(context, 0.25),
              items: [
                DropdownMenuItem(
                  child: Text(
                    Strings.all,
                  ),
                  value: 0,
                ),
                DropdownMenuItem(
                  child: Text(
                    Strings.movies,
                  ),
                  value: 1,
                ),
                DropdownMenuItem(
                  child: Text(
                    Strings.shows,
                  ),
                  value: 2,
                ),
              ],
              onChanged: (value) {
                store.changeFilter(value!);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFab() {
    Widget widget = Badge.Badge(
      badgeContent: Text("${store.checkedFavoritesIds.length}"),
      child: Icon(Icons.more_vert_rounded),
    );
    if (store.multiSelectEnabled) {
      return Padding(
        padding: const EdgeInsets.only(
          bottom: HomeBottomNavBar.bottomNavHeight,
        ),
        child: ExpandableFab(
          child: widget,
          type: ExpandableFabType.fan,
          closeButtonStyle: ExpandableFabCloseButtonStyle(
            child: widget,
          ),
          children: [
            FloatingActionButton.extended(
              onPressed: _onRemoveClicked,
              label: Text(Strings.remove),
              icon: Icon(Icons.favorite_outline_outlined),
            ),
            FloatingActionButton.extended(
              onPressed: _onCancelClicked,
              label: Text(Strings.cancel),
              icon: Icon(Icons.close),
            )
          ],
        ),
      );
    }
    return Container();
  }

  void _onCancelClicked() {
    store.resetMultiSelect();
  }

  void _onRemoveClicked() {
    if (store.checkedFavoritesIds.isNotEmpty) {
      Style.showLoadingDialog(context: context);

      List<int> indexes = [];
      for (var id in store.checkedFavoritesIds) {
        indexes.add(store.currentFav.indexWhere((element) => element.id == id));
      }
      for (var element in indexes) {
        keys[element].currentState?.changeChecked();
      }

      store
          .removeFavorites(Provider.of<UserStore>(context, listen: false))
          .whenComplete(() {
        store.resetMultiSelect();
        Navigator.pop(context);
      });
      return;
    }
    Style.showToast(context: context, text: Strings.noItemsSelected);
  }

  @override
  bool get wantKeepAlive => true;
}
