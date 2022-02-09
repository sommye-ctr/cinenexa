import 'package:flutter/material.dart';
import 'package:watrix/resources/strings.dart';
import 'package:watrix/services/constants.dart';
import 'package:watrix/services/requests.dart';
import 'package:watrix/utils/screen_size.dart';
import 'package:watrix/widgets/horizontal_list.dart';
import 'package:watrix/widgets/image_carousel.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;

  late Widget featured = Column(
    children: [
      ImageCarousel(
        Requests.homeMoviesFuture(
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
      HorizontalList(
        Requests.homeMoviesFuture(Requests.popularMovies),
        "Popular Movies",
        () {},
        0.3,
        Constants.movie,
      ),
      SizedBox(
        height: ScreenSize.getPercentOfHeight(
          context,
          0.02,
        ),
      ),
      HorizontalList(
        Requests.homeTvFuture(Requests.popularTv),
        "Popular TV Shows",
        () {},
        0.3,
        Constants.tv,
      ),
      SizedBox(
        height: ScreenSize.getPercentOfHeight(
          context,
          0.02,
        ),
      ),
      HorizontalList(
        Requests.homePeopleFuture(Requests.popularPerson),
        "Popular Actors",
        () {},
        0.3,
        Constants.person,
      ),
      SizedBox(
        height: ScreenSize.getPercentOfHeight(
          context,
          0.02,
        ),
      ),
      HorizontalList(
        Requests.homeMoviesFuture(
          Requests.weeklyTrendingMovies,
          skip: true,
        ),
        "Weekly Trending Movies",
        () {},
        0.3,
        Constants.movie,
      ),
      SizedBox(
        height: ScreenSize.getPercentOfHeight(
          context,
          0.02,
        ),
      ),
      HorizontalList(
        Requests.homeTvFuture(
          Requests.weeklyTrendingTv,
          skip: true,
        ),
        "Weekly Trending TV Shows",
        () {},
        0.3,
        Constants.tv,
      ),
      SizedBox(
        height: ScreenSize.getPercentOfHeight(
          context,
          0.1,
        ),
      ),
    ],
  );
  late Widget movies = Column(
    children: [
      HorizontalList(
        Requests.homeMoviesFuture(Requests.dailyTrendingMovies),
        "Trending Today",
        () {},
        0.3,
        Constants.movie,
      ),
      SizedBox(
        height: ScreenSize.getPercentOfHeight(
          context,
          0.02,
        ),
      ),
      HorizontalList(
        Requests.homeMoviesFuture(Requests.topRatedMovies),
        "Top Rated",
        () {},
        0.3,
        Constants.movie,
      ),
      SizedBox(
        height: ScreenSize.getPercentOfHeight(
          context,
          0.02,
        ),
      ),
      HorizontalList(
        Requests.homeMoviesFuture(Requests.popularMovies),
        "Popular",
        () {},
        0.3,
        Constants.movie,
      ),
      SizedBox(
        height: ScreenSize.getPercentOfHeight(
          context,
          0.02,
        ),
      ),
      HorizontalList(
        Requests.homeMoviesFuture(
          Requests.weeklyTrendingMovies,
          skip: true,
        ),
        "Trending this Week",
        () {},
        0.3,
        Constants.movie,
      ),
      SizedBox(
        height: ScreenSize.getPercentOfHeight(
          context,
          0.02,
        ),
      ),
    ],
  );
  late Widget tv = Column(
    children: [
      HorizontalList(
        Requests.homeTvFuture(Requests.dailyTrendingTv),
        "Trending Today",
        () {},
        0.3,
        Constants.tv,
      ),
      SizedBox(
        height: ScreenSize.getPercentOfHeight(
          context,
          0.02,
        ),
      ),
      HorizontalList(
        Requests.homeTvFuture(Requests.topRatedTv),
        "Top Rated",
        () {},
        0.3,
        Constants.tv,
      ),
      SizedBox(
        height: ScreenSize.getPercentOfHeight(
          context,
          0.02,
        ),
      ),
      HorizontalList(
        Requests.homeTvFuture(Requests.popularTv),
        "Popular",
        () {},
        0.3,
        Constants.tv,
      ),
      SizedBox(
        height: ScreenSize.getPercentOfHeight(
          context,
          0.02,
        ),
      ),
      HorizontalList(
        Requests.homeTvFuture(Requests.weeklyTrendingTv),
        "Trending this Week",
        () {},
        0.3,
        Constants.tv,
      ),
      SizedBox(
        height: ScreenSize.getPercentOfHeight(
          context,
          0.02,
        ),
      ),
      HorizontalList(
        Requests.homeTvFuture(Requests.airingTodayTv),
        "Airing Today",
        () {},
        0.3,
        Constants.tv,
      ),
      SizedBox(
        height: ScreenSize.getPercentOfHeight(
          context,
          0.1,
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
    return Container(
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
    );
  }
}
