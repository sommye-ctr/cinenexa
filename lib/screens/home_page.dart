import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:watrix/models/base_model.dart';
import 'package:watrix/resources/strings.dart';
import 'package:watrix/resources/style.dart';
import 'package:watrix/screens/details_page.dart';
import 'package:watrix/screens/filter_page.dart';
import 'package:watrix/services/entity_type.dart';
import 'package:watrix/store/home_store.dart';
import 'package:watrix/utils/screen_size.dart';
import 'package:watrix/components/bottom_nav_bar.dart';
import 'package:watrix/widgets/home_featured.dart';
import 'package:watrix/widgets/home_movies.dart';
import 'package:watrix/widgets/home_tv.dart';

import '../models/discover.dart';
import '../services/constants.dart';
import '../components/movie_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final HomeStore homeStore = HomeStore(
    defaultMovieIndex: 1,
    defaultTvIndex: 2,
  );
  late final Widget myList = Column();

  late final Widget featured = HomeFeatured(onItemClicked: onItemClicked);
  late final Widget movies = HomeMovies(onItemClicked: onItemClicked);
  late final Widget tv = HomeTv(onItemClicked: onItemClicked);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ScreenSize.getPercentOfWidth(context, 0.02),
            ),
            child: _buildTabBar(),
          ),
        ),
        _buildFilterFab(),
      ],
    );
  }

  Widget _buildTabBar() {
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
            physics: BouncingScrollPhysics(),
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
          Expanded(
            child: TabBarView(
              physics: BouncingScrollPhysics(),
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

  Widget _buildFilteredItems(List<BaseModel> list) {
    return GridView.builder(
      key: PageStorageKey("filteredItems"),
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
        );
      },
    );
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
                showBottomSheet(context, homeStore.tabIndex);
              },
            ),
          );
        }
        return Container();
      },
    );
  }

  void onItemClicked(BaseModel baseModel) {
    Navigator.pushNamed(
      context,
      DetailsPage.routeName,
      arguments: baseModel,
    );
  }

  void showBottomSheet(BuildContext context, int index) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
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
    ).then(onFilterChanged);
  }

  void onFilterChanged(value) {
    if (value != null && value != -1) {
      homeStore.onFilterApplied(value as Discover);
      /* if (homeStore.tabIndex == 1) {
        _movieDiscover = discover;
        movies = Container();
      } else if (homeStore.tabIndex == 2) {
        _tvDiscover = discover;
        tv = Container();
      } */
      //setState(() {});

      return;
    } else if (value == -1) {
      homeStore.onFilterReset();
    }
  }
}
