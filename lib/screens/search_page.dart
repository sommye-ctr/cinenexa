import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:watrix/resources/strings.dart';
import 'package:watrix/resources/style.dart';
import 'package:watrix/services/constants.dart';
import 'package:watrix/store/search/search_store.dart';
import 'package:watrix/utils/screen_size.dart';
import 'package:watrix/components/movie_tile.dart';
import 'package:watrix/widgets/search_input.dart';

import 'details_page.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final SearchStore searchStore = SearchStore();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenSize.getPercentOfWidth(context, 1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildSearchBar(),
          _buildSpacing(),
          _buildHeading(),
          _buildContent(),
          _buildSpacing(percent: 0.08),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return SearchInput(
      onChanged: searchStore.searchTermChanged,
      onEditingComplete: () => searchStore.searchClicked(context),
    );
  }

  Widget _buildHeading() {
    return Column(
      children: [
        Text(
          Strings.frequentSearch,
          style: Style.headingStyle,
        ),
        _buildSpacing(),
      ],
    );
  }

  Widget _buildSpacing({double percent = 0.02}) {
    return SizedBox(
      height: ScreenSize.getPercentOfHeight(context, percent),
    );
  }

  Widget _buildContent() {
    return Observer(
      builder: (context) {
        return _buildGrid();
      },
    );
  }

  Widget _buildGrid() {
    return Expanded(
      child: LazyLoadScrollView(
        onEndOfPage: () => searchStore.onEndOfPageReached(),
        child: GridView.builder(
          shrinkWrap: true,
          itemCount: searchStore.items.length,
          physics: BouncingScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: Style.movieTileWithTitleRatio,
          ),
          itemBuilder: (context, index) {
            return MovieTile(
              image:
                  "${Constants.imageBaseUrl}${Constants.posterSize}${searchStore.items[index].posterPath}",
              width: ScreenSize.getPercentOfWidth(
                context,
                0.29,
              ),
              showTitle: true,
              text: searchStore.items[index].title!,
              onClick: () {
                Navigator.pushNamed(
                  context,
                  DetailsPage.routeName,
                  arguments: searchStore.items[index],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
