import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:watrix/components/movie_tile.dart';
import 'package:watrix/resources/strings.dart';
import 'package:watrix/resources/style.dart';
import 'package:watrix/services/network/utils.dart';
import 'package:watrix/store/favorites/favorites_store.dart';
import 'package:watrix/utils/screen_size.dart';
import 'package:watrix/widgets/custom_checkbox_list.dart';

class HomeFavorites extends StatefulWidget {
  const HomeFavorites({Key? key}) : super(key: key);

  @override
  State<HomeFavorites> createState() => _HomeFavoritesState();
}

class _HomeFavoritesState extends State<HomeFavorites>
    with AutomaticKeepAliveClientMixin {
  late FavoritesStore store;

  @override
  void initState() {
    store = Provider.of<FavoritesStore>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Observer(builder: (_) {
          return Container(
            width: ScreenSize.getPercentOfWidth(context, 0.8),
            child: CustomCheckBoxList(
              type: CheckBoxListType.grid,
              singleSelect: true,
              alwaysEnabled: true,
              selectedItems: [0],
              children: [
                Strings.all,
                Strings.movies,
                Strings.tvShows,
              ],
              delegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 20 / 9,
                crossAxisSpacing: ScreenSize.getPercentOfWidth(context, 0.025),
              ),
              onSelectionAdded: (list) {
                store.selectedFilter = Utils.getEntityByString(list.first);
              },
            ),
          );
        }),
        Style.getVerticalSpacing(context: context),
        Observer(
          builder: (_) => Expanded(
            child: GridView.builder(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: Style.movieTileWithTitleRatio,
              ),
              itemCount: store.currentFav.length,
              itemBuilder: (context, index) {
                return MovieTile(
                  image:
                      Utils.getPosterUrl(store.currentFav[index].posterPath!),
                  width: ScreenSize.getPercentOfWidth(context, 0.3),
                  showTitle: false,
                  onClick: () =>
                      store.itemClicked(context, store.currentFav[index]),
                );
              },
            ),
          ),
        ),
        Style.getVerticalSpacing(
          context: context,
          percent: 0.08,
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
