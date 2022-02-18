import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:watrix/models/movie.dart';
import 'package:watrix/models/people.dart';
import 'package:watrix/resources/strings.dart';
import 'package:watrix/resources/style.dart';
import 'package:watrix/screens/filter_page.dart';
import 'package:watrix/services/requests.dart';
import 'package:watrix/utils/screen_size.dart';
import 'package:watrix/widgets/bottom_nav_bar.dart';
import 'package:watrix/widgets/horizontal_list.dart';
import 'package:watrix/widgets/image_carousel.dart';

import '../models/tv.dart';
import '../services/constants.dart';
import '../widgets/movie_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;
  bool _isFilterApplied = false;

  late final Widget defaultMovies = Column(
    children: [
      HorizontalList<Movie>(
        future: Requests.moviesFuture(Requests.dailyTrendingMovies),
        heading: "Trending Today",
        onClick: () {},
        itemWidthPercent: 0.3,
        showTitle: true,
      ),
      SizedBox(
        height: ScreenSize.getPercentOfHeight(
          context,
          0.02,
        ),
      ),
      HorizontalList<Movie>(
        future: Requests.moviesFuture(Requests.topRatedMovies),
        heading: "Top Rated",
        onClick: () {},
        itemWidthPercent: 0.3,
        showTitle: true,
      ),
      SizedBox(
        height: ScreenSize.getPercentOfHeight(
          context,
          0.02,
        ),
      ),
      HorizontalList<Movie>(
        future: Requests.moviesFuture(Requests.popularMovies),
        heading: "Popular",
        onClick: () {},
        itemWidthPercent: 0.3,
        showTitle: true,
      ),
      SizedBox(
        height: ScreenSize.getPercentOfHeight(
          context,
          0.02,
        ),
      ),
      HorizontalList<Movie>(
        future: Requests.moviesFuture(
          Requests.weeklyTrendingMovies,
          skip: true,
        ),
        heading: "Trending this Week",
        onClick: () {},
        itemWidthPercent: 0.3,
        showTitle: true,
      ),
      SizedBox(
        height: ScreenSize.getPercentOfHeight(
          context,
          0.02,
        ),
      ),
    ],
  );

  late Widget featured = Column(
    children: [
      ImageCarousel<Movie>(
        Requests.moviesFuture(
          Requests.dailyTrendingMovies,
          limit: 5,
        ),
        onPageChanged: (page, home) {},
      ),
      SizedBox(
        height: ScreenSize.getPercentOfHeight(
          context,
          0.02,
        ),
      ),
      HorizontalList<Movie>(
        future: Requests.moviesFuture(Requests.popularMovies),
        heading: "Popular Movies",
        onClick: () {},
        itemWidthPercent: 0.3,
        showTitle: false,
      ),
      SizedBox(
        height: ScreenSize.getPercentOfHeight(
          context,
          0.02,
        ),
      ),
      HorizontalList<Tv>(
        future: Requests.tvFuture(Requests.popularTv),
        heading: "Popular TV Shows",
        onClick: () {},
        itemWidthPercent: 0.3,
        showTitle: false,
      ),
      SizedBox(
        height: ScreenSize.getPercentOfHeight(
          context,
          0.02,
        ),
      ),
      HorizontalList<People>(
        future: Requests.peopleFuture(Requests.popularPerson),
        heading: "Popular Actors",
        onClick: () {},
        itemWidthPercent: 0.3,
        showTitle: false,
      ),
      SizedBox(
        height: ScreenSize.getPercentOfHeight(
          context,
          0.02,
        ),
      ),
      HorizontalList<Movie>(
        future: Requests.moviesFuture(
          Requests.weeklyTrendingMovies,
          skip: true,
        ),
        heading: "Weekly Trending Movies",
        onClick: () {},
        itemWidthPercent: 0.3,
        showTitle: false,
      ),
      SizedBox(
        height: ScreenSize.getPercentOfHeight(
          context,
          0.02,
        ),
      ),
      HorizontalList<Tv>(
        future: Requests.tvFuture(
          Requests.weeklyTrendingTv,
          skip: true,
        ),
        heading: "Weekly Trending TV Shows",
        onClick: () {},
        itemWidthPercent: 0.3,
        showTitle: false,
      ),
      SizedBox(
        height: ScreenSize.getPercentOfHeight(
          context,
          0.08,
        ),
      ),
    ],
  );
  late Widget movies = defaultMovies;
  late Widget tv = Column(
    children: [
      HorizontalList<Tv>(
        future: Requests.tvFuture(Requests.dailyTrendingTv),
        heading: "Trending Today",
        onClick: () {},
        itemWidthPercent: 0.3,
        showTitle: true,
      ),
      SizedBox(
        height: ScreenSize.getPercentOfHeight(
          context,
          0.02,
        ),
      ),
      HorizontalList<Tv>(
        future: Requests.tvFuture(Requests.topRatedTv),
        heading: "Top Rated",
        onClick: () {},
        itemWidthPercent: 0.3,
        showTitle: true,
      ),
      SizedBox(
        height: ScreenSize.getPercentOfHeight(
          context,
          0.02,
        ),
      ),
      HorizontalList<Tv>(
        future: Requests.tvFuture(Requests.popularTv),
        heading: "Popular",
        onClick: () {},
        itemWidthPercent: 0.3,
        showTitle: true,
      ),
      SizedBox(
        height: ScreenSize.getPercentOfHeight(
          context,
          0.02,
        ),
      ),
      HorizontalList<Tv>(
        future: Requests.tvFuture(Requests.weeklyTrendingTv),
        heading: "Trending this Week",
        onClick: () {},
        itemWidthPercent: 0.3,
        showTitle: true,
      ),
      SizedBox(
        height: ScreenSize.getPercentOfHeight(
          context,
          0.02,
        ),
      ),
    ],
  );
  late Widget myList = Column();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(
      () => setState(() => _selectedIndex = _tabController.index),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ScreenSize.getPercentOfWidth(context, 0.02),
            ),
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                DefaultTabController(
                  length: 4,
                  child: TabBar(
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: Colors.transparent,
                    isScrollable: true,
                    controller: _tabController,
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
                ),
                IndexedStack(
                  index: _selectedIndex,
                  children: [
                    featured,
                    movies,
                    tv,
                    myList,
                  ],
                ),
              ],
            ),
          ),
        ),
        if (_selectedIndex == 1 || _selectedIndex == 2)
          Positioned(
            bottom: BottomNavBar.bottomNavHeight +
                BottomNavBar.bottomNavPadding +
                4,
            right: BottomNavBar.bottomNavPadding,
            child: FloatingActionButton(
              child: Badge(
                alignment: Alignment.topRight,
                showBadge: _isFilterApplied,
                child: Icon(
                  _isFilterApplied
                      ? Icons.filter_alt
                      : Icons.filter_alt_outlined,
                ),
              ),
              onPressed: () {
                showBottomSheet(context, _selectedIndex);
              },
            ),
          ),
      ],
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
        return FractionallySizedBox(
          heightFactor: 0.8,
          child: FilterPage(),
        );
      },
    ).then(onBottomSheetFilterChanged);
  }

  void onBottomSheetFilterChanged(value) async {
    if (value != null) {
      setState(() {
        _isFilterApplied = true;
        movies = FutureBuilder<List<Movie>>(
            future: Requests.discoverMovie(value),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                return GridView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  physics: BouncingScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: Style.movieTileWithTitleRatio,
                  ),
                  itemBuilder: (context, index) {
                    return MovieTile(
                      image:
                          "${Constants.imageBaseUrl}${Constants.posterSize}${snapshot.data![index].posterPath}",
                      width: ScreenSize.getPercentOfWidth(
                        context,
                        0.29,
                      ),
                      showTitle: true,
                      text: snapshot.data![index].title,
                    );
                  },
                );
              }
              return Container();
            });
      });
      return;
    }
    setState(() {
      movies = defaultMovies;
      _isFilterApplied = false;
    });
  }
}
