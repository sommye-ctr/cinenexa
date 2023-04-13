import 'package:badges/badges.dart' as Badge;
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:mobx/mobx.dart';
import 'package:cinenexa/components/home_favourites.dart';
import 'package:cinenexa/resources/strings.dart';
import 'package:cinenexa/resources/style.dart';
import 'package:cinenexa/screens/filter_page.dart';
import 'package:cinenexa/screens/see_more_page.dart';
import 'package:cinenexa/models/network/enums/entity_type.dart';
import 'package:cinenexa/utils/screen_size.dart';
import 'package:cinenexa/components/home_bottom_nav_bar.dart';
import 'package:cinenexa/components/home_featured.dart';
import 'package:cinenexa/components/home_movies.dart';
import 'package:cinenexa/components/home_tv.dart';

import '../models/network/base_model.dart';
import '../models/network/discover.dart';
import '../services/constants.dart';
import '../components/movie_tile.dart';
import '../store/home/home_store.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final HomeStore homeStore = HomeStore(
    defaultMovieIndex: 1,
    defaultTvIndex: 2,
  );
  late final Widget myList = HomeFavorites();

  late final Widget featured = HomeFeatured(
      onItemClicked: _onItemClicked, onSeeMoreClicked: _onSeeMoreClicked);
  late final Widget movies = HomeMovies(
      onItemClicked: _onItemClicked, onSeeMoreClicked: _onSeeMoreClicked);
  late final Widget tv = HomeTv(
      onItemClicked: _onItemClicked, onSeeMoreClicked: _onSeeMoreClicked);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ScreenSize.getPercentOfWidth(context, 0.02),
            ),
            child: _buildBody(),
          ),
          Observer(builder: (context) => _buildFilterFab()),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return DefaultTabController(
      length: 4,
      child: Column(
        children: [
          TabBar(
            indicator: ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Style.largeRoundEdgeRadius),
              ),
              color: Theme.of(context).colorScheme.primary,
            ),
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorPadding: EdgeInsets.all(8),
            splashBorderRadius: BorderRadius.circular(40),
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
                text: Strings.shows,
              ),
              Tab(
                text: Strings.favorites,
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                featured,
                _buildMovieBody(),
                _buildTvBody(),
                myList,
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMovieBody() {
    return Observer(builder: (context) {
      if (homeStore.isMovieFilterApplied) {
        return (homeStore.currentFilterMovieFuture.status ==
                    FutureStatus.pending &&
                homeStore.filterMovies.isEmpty)
            ? Center(child: CircularProgressIndicator())
            : _buildFilteredItems(homeStore.filterMovies);
      }
      return movies;
    });
  }

  Widget _buildTvBody() {
    return Observer(builder: (context) {
      if (homeStore.isTvFilterApplied) {
        return (homeStore.currentFilterTvFuture.status ==
                    FutureStatus.pending &&
                homeStore.filterTv.isEmpty)
            ? Center(child: CircularProgressIndicator())
            : _buildFilteredItems(homeStore.filterTv);
      }
      return tv;
    });
  }

  Widget _buildFilterFab() {
    return Observer(
      builder: (context) {
        if (homeStore.tabIndex == 1 || homeStore.tabIndex == 2) {
          return Positioned(
            bottom: HomeBottomNavBar.bottomNavHeight +
                HomeBottomNavBar.bottomNavPadding +
                4,
            right: HomeBottomNavBar.bottomNavPadding,
            child: FloatingActionButton(
              child: Badge.Badge(
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
                "${Constants.tmdbImageBase}${Constants.posterSize}${list[index].posterPath}",
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

  void _onItemClicked(BaseModel baseModel) async {
    homeStore.onItemClicked(context, baseModel);
  }

  void _onSeeMoreClicked(String future, List<BaseModel> items, String heading,
      {SeeMoreChildType seeMoreChildType = SeeMoreChildType.squicircle}) {
    _showSeeMoreSheet(context, future, items, heading, seeMoreChildType);
  }

  void _showSeeMoreSheet(
      BuildContext context,
      String future,
      List<BaseModel> items,
      String heading,
      SeeMoreChildType seeMoreChildType) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Style.largeRoundEdgeRadius),
      ),
      backgroundColor: Colors.transparent,
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.75,
          child: SeeMorePage(
            future: future,
            initialItems: items,
            heading: heading,
            type: seeMoreChildType,
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
