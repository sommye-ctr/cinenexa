import 'package:flutter/material.dart';
import 'package:watrix/models/movie.dart';
import 'package:watrix/models/people.dart';
import 'package:watrix/resources/strings.dart';
import 'package:watrix/services/requests.dart';
import 'package:watrix/utils/screen_size.dart';
import 'package:watrix/widgets/horizontal_list.dart';
import 'package:watrix/widgets/image_carousel.dart';

import '../models/tv.dart';

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
  late Widget movies = Column(
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
      HorizontalList<Tv>(
        future: Requests.tvFuture(Requests.airingTodayTv),
        heading: "Airing Today",
        onClick: () {},
        itemWidthPercent: 0.3,
        showTitle: true,
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
