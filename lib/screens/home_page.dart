import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:watrix/components/home_mylist.dart';
import 'package:watrix/models/base_model.dart';
import 'package:watrix/resources/strings.dart';
import 'package:watrix/resources/style.dart';
import 'package:watrix/screens/filter_page.dart';
import 'package:watrix/screens/see_more_page.dart';
import 'package:watrix/services/entity_type.dart';
import 'package:watrix/utils/screen_size.dart';
import 'package:watrix/components/bottom_nav_bar.dart';
import 'package:watrix/components/home_featured.dart';
import 'package:watrix/components/home_movies.dart';
import 'package:watrix/components/home_tv.dart';

import '../models/discover.dart';
import '../services/constants.dart';
import '../components/movie_tile.dart';
import '../store/home/home_store.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final HomeStore homeStore = HomeStore(
    defaultMovieIndex: 1,
    defaultTvIndex: 2,
  );
  late final Widget myList = HomeMyList();

  late final Widget featured = HomeFeatured(
      onItemClicked: _onItemClicked, onSeeMoreClicked: _onSeeMoreClicked);
  late final Widget movies = HomeMovies(
      onItemClicked: _onItemClicked, onSeeMoreClicked: _onSeeMoreClicked);
  late final Widget tv = HomeTv(
      onItemClicked: _onItemClicked, onSeeMoreClicked: _onSeeMoreClicked);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ScreenSize.getPercentOfWidth(context, 0.02),
            ),
            child: _buildBody(),
          ),
        ),
        Observer(builder: (context) => _buildFilterFab()),
      ],
    );
  }

  Widget _buildBody() {
    return DefaultTabController(
      length: 4,
      child: Column(
        children: [
          TabBar(
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.transparent,
            isScrollable: true,
            onTap: homeStore.tabChanged,
            tabs: [
              Tab(
                text: Strings.featured,
              ),
              Tab(
                text: Strings.movies,
              ),
              Tab(
                text: Strings.tvShows,
              ),
              Tab(
                text: Strings.myList,
              ),
            ],
          ),
          Observer(
            builder: (_) {
              return Expanded(
                child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    featured,
                    _buildMovieBody(),
                    _buildTvBody(),
                    myList,
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMovieBody() {
    if (homeStore.isMovieFilterApplied) {
      return _buildFilteredItems(homeStore.filterMovies);
    }
    return movies;
  }

  Widget _buildTvBody() {
    if (homeStore.isTvFilterApplied) {
      return _buildFilteredItems(homeStore.filterTv);
    }
    return tv;
  }

  Widget _buildFilterFab() {
    return Observer(
      builder: (context) {
        if (homeStore.tabIndex == 1 || homeStore.tabIndex == 2) {
          return Positioned(
            bottom: BottomNavBar.bottomNavHeight +
                BottomNavBar.bottomNavPadding +
                4,
            right: BottomNavBar.bottomNavPadding,
            child: FloatingActionButton(
              child: Badge(
                alignment: Alignment.topRight,
                showBadge: homeStore.isFilterApplied,
                child: Icon(
                  homeStore.isFilterApplied
                      ? Icons.filter_alt
                      : Icons.filter_alt_outlined,
                ),
              ),
              onPressed: () {
                _showFiltersSheet(context, homeStore.tabIndex);
              },
            ),
          );
        }
        return Container();
      },
    );
  }

  Widget _buildFilteredItems(List<BaseModel> list) {
    return LazyLoadScrollView(
      onEndOfPage: () {
        homeStore.onFilterPageEndReached();
      },
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: list.length,
        physics: BouncingScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: Style.movieTileWithTitleRatio,
        ),
        itemBuilder: (context, index) {
          return MovieTile(
            image:
                "${Constants.imageBaseUrl}${Constants.posterSize}${list[index].posterPath}",
            width: ScreenSize.getPercentOfWidth(
              context,
              0.29,
            ),
            showTitle: true,
            text: list[index].title!,
            onClick: () => _onItemClicked(list[index]),
          );
        },
      ),
    );
  }

  void _onItemClicked(BaseModel baseModel) {
    homeStore.onItemClicked(context, baseModel);
  }

  void _onSeeMoreClicked(String future, List<BaseModel> items, String heading) {
    _showSeeMoreSheet(context, future, items, heading);
  }

  void _showSeeMoreSheet(BuildContext context, String future,
      List<BaseModel> items, String heading) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Style.largeRoundEdgeRadius),
      ),
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.75,
          child: SeeMorePage(
            future: future,
            initialItems: items,
            heading: heading,
          ),
        );
      },
    );
  }

  void _showFiltersSheet(BuildContext context, int index) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Style.largeRoundEdgeRadius),
      ),
      builder: (context) {
        EntityType type;
        if (homeStore.tabIndex == 1) {
          type = EntityType.movie;
        } else if (homeStore.tabIndex == 2) {
          type = EntityType.tv;
        } else {
          throw FlutterError(
              "The bottom sheet index is not same as movies or tv shows");
        }
        return FractionallySizedBox(
          heightFactor: 0.8,
          child: FilterPage(
            type: type,
            discover: homeStore.tabIndex == 1
                ? homeStore.moviesDiscover
                : homeStore.tvDiscover,
          ),
        );
      },
    ).then(_onFilterChanged);
  }

  void _onFilterChanged(value) {
    if (value != null && value != -1) {
      homeStore.onFilterApplied(value as Discover);
      return;
    } else if (value == -1) {
      homeStore.onFilterReset();
    }
  }
}
