import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:watrix/components/movie_tile.dart';
import 'package:watrix/resources/strings.dart';
import 'package:watrix/resources/style.dart';
import 'package:watrix/services/network/utils.dart';
import 'package:watrix/store/favorites/favorites_store.dart';
import 'package:watrix/utils/screen_size.dart';

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
          return _buildHeading();
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

  @override
  bool get wantKeepAlive => true;
}
