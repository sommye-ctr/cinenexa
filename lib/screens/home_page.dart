import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watrix/bloc/home/home_page_bloc.dart';
import 'package:watrix/bloc/home/home_page_event.dart';
import 'package:watrix/bloc/home/home_page_state.dart';
import 'package:watrix/models/base_model.dart';
import 'package:watrix/resources/strings.dart';
import 'package:watrix/resources/style.dart';
import 'package:watrix/screens/details_page.dart';
import 'package:watrix/screens/filter_page.dart';
import 'package:watrix/services/duration_type.dart';
import 'package:watrix/services/entity_type.dart';
import 'package:watrix/services/requests.dart';
import 'package:watrix/utils/screen_size.dart';
import 'package:watrix/components/bottom_nav_bar.dart';
import 'package:watrix/widgets/horizontal_list.dart';
import 'package:watrix/widgets/image_carousel.dart';

import '../models/discover.dart';
import '../services/constants.dart';
import '../components/movie_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  static const FEATURED = 0;
  static const MOVIES = 1;
  static const TV = 2;
  static const MY_LIST = 3;
  //late TabController _tabController;
  //int _selectedIndex = 0;

  List<BaseModel> filterMovies = List.empty();
  List<BaseModel> filterTv = List.empty();
  int _movieFilterPage = 1, _tvFilterPage = 1;
  //bool _isMovieFilterApplied = false, _isTvFilterApplied = false;
  Discover? _movieDiscover, _tvDiscover;

  late final Widget defaultMovies = Column(
    children: [
      HorizontalList(
        future: Requests.titlesFuture(
            Requests.trending(EntityType.movie, DurationType.day)),
        heading: "Trending Today",
        onClick: (data) => onItemClicked(data),
        itemWidthPercent: 0.3,
        showTitle: true,
      ),
      SizedBox(
        height: ScreenSize.getPercentOfHeight(
          context,
          0.02,
        ),
      ),
      HorizontalList(
        future: Requests.titlesFuture(Requests.topRated(EntityType.movie)),
        heading: "Top Rated",
        onClick: (data) => onItemClicked(data),
        itemWidthPercent: 0.3,
        showTitle: true,
      ),
      SizedBox(
        height: ScreenSize.getPercentOfHeight(
          context,
          0.02,
        ),
      ),
      HorizontalList(
        future: Requests.titlesFuture(Requests.popular(EntityType.movie)),
        heading: "Popular",
        onClick: (data) => onItemClicked(data),
        itemWidthPercent: 0.3,
        showTitle: true,
      ),
      SizedBox(
        height: ScreenSize.getPercentOfHeight(
          context,
          0.02,
        ),
      ),
      HorizontalList(
        future: Requests.titlesFuture(
          Requests.trending(EntityType.movie, DurationType.week),
          skip: true,
        ),
        heading: "Trending this Week",
        onClick: (data) => onItemClicked(data),
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
  late Widget defaultTv = Column(
    children: [
      HorizontalList(
        future: Requests.titlesFuture(
            Requests.trending(EntityType.tv, DurationType.day)),
        heading: "Trending Today",
        onClick: (data) => onItemClicked(data),
        itemWidthPercent: 0.3,
        showTitle: true,
      ),
      SizedBox(
        height: ScreenSize.getPercentOfHeight(
          context,
          0.02,
        ),
      ),
      HorizontalList(
        future: Requests.titlesFuture(Requests.topRated(EntityType.tv)),
        heading: "Top Rated",
        onClick: (data) => onItemClicked(data),
        itemWidthPercent: 0.3,
        showTitle: true,
      ),
      SizedBox(
        height: ScreenSize.getPercentOfHeight(
          context,
          0.02,
        ),
      ),
      HorizontalList(
        future: Requests.titlesFuture(Requests.popular(EntityType.tv)),
        heading: "Popular",
        onClick: (data) => onItemClicked(data),
        itemWidthPercent: 0.3,
        showTitle: true,
      ),
      SizedBox(
        height: ScreenSize.getPercentOfHeight(
          context,
          0.02,
        ),
      ),
      HorizontalList(
        future: Requests.titlesFuture(
            Requests.trending(EntityType.tv, DurationType.week)),
        heading: "Trending this Week",
        onClick: (data) => onItemClicked(data),
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
      ImageCarousel(
        Requests.titlesFuture(
          Requests.trending(EntityType.all, DurationType.day),
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
        future: Requests.titlesFuture(Requests.popular(EntityType.movie)),
        heading: "Popular Movies",
        onClick: (data) => onItemClicked(data),
        itemWidthPercent: 0.3,
        showTitle: false,
      ),
      SizedBox(
        height: ScreenSize.getPercentOfHeight(
          context,
          0.02,
        ),
      ),
      HorizontalList(
        future: Requests.titlesFuture(Requests.popular(EntityType.tv)),
        heading: "Popular TV Shows",
        onClick: (data) => onItemClicked(data),
        itemWidthPercent: 0.3,
        showTitle: false,
      ),
      SizedBox(
        height: ScreenSize.getPercentOfHeight(
          context,
          0.02,
        ),
      ),
      HorizontalList(
        future: Requests.titlesFuture(Requests.popular(EntityType.people)),
        heading: "Popular Actors",
        onClick: (data) => onItemClicked(data),
        itemWidthPercent: 0.3,
        showTitle: false,
      ),
      SizedBox(
        height: ScreenSize.getPercentOfHeight(
          context,
          0.02,
        ),
      ),
      HorizontalList(
        future: Requests.titlesFuture(
          Requests.trending(EntityType.movie, DurationType.week),
          skip: true,
        ),
        heading: "Weekly Trending Movies",
        onClick: (data) => onItemClicked(data),
        itemWidthPercent: 0.3,
        showTitle: false,
      ),
      SizedBox(
        height: ScreenSize.getPercentOfHeight(
          context,
          0.02,
        ),
      ),
      HorizontalList(
        future: Requests.titlesFuture(
          Requests.trending(EntityType.tv, DurationType.week),
          skip: true,
        ),
        heading: "Weekly Trending TV Shows",
        onClick: (data) => onItemClicked(data),
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
  late Widget tv = defaultTv;
  late Widget myList = Column();

  @override
  void initState() {
    super.initState();
    //_tabController = TabController(length: 4, vsync: this);
    /* _tabController.addListener(
      () => setState(() => _selectedIndex = _tabController.index),
    ); */
  }

  @override
  void dispose() {
    //_tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomePageBloc(HomePageTabType.featured),
      child: Stack(
        children: [
          Container(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenSize.getPercentOfWidth(context, 0.02),
              ),
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  _buildTabs(),
                  _buildMainBody(),
                ],
              ),
            ),
          ),
          _buildFilterFab(),
        ],
      ),
    );
  }

  Widget _buildMainBody() {
    return BlocBuilder<HomePageBloc, HomePageState>(
      buildWhen: (previous, current) => previous.index != current.index,
      builder: (context, state) {
        return IndexedStack(
          index: state.index,
          children: [
            featured,
            movies,
            tv,
            myList,
          ],
        );
      },
    );
  }

  Widget _buildTabs() {
    return DefaultTabController(
      length: 4,
      child: TabBar(
        labelColor: Colors.black,
        unselectedLabelColor: Colors.grey,
        indicatorColor: Colors.transparent,
        isScrollable: true,
        onTap: _onTabClicked,
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
    );
  }

  void _onTabClicked(int index) {
    BlocProvider.of<HomePageBloc>(context).add(
      HomePageTabChanged(
        index: index,
        type: _getTabType(index),
      ),
    );
  }

  HomePageTabType _getTabType(int index) {
    switch (index) {
      case FEATURED:
        return HomePageTabType.featured;
      case MOVIES:
        return HomePageTabType.movies;
      case TV:
        return HomePageTabType.tv;
      case MY_LIST:
        return HomePageTabType.list;
    }
    throw FlutterError("Unknown tab!");
  }

  Widget _buildFilterFab() {
    return BlocBuilder<HomePageBloc, HomePageState>(
      builder: (context, state) {
        if (state.type == HomePageTabType.movies ||
            state.type == HomePageTabType.tv) {
          return Positioned(
            bottom: BottomNavBar.bottomNavHeight +
                BottomNavBar.bottomNavPadding +
                4,
            right: BottomNavBar.bottomNavPadding,
            child: FloatingActionButton(
              child: Badge(
                alignment: Alignment.topRight,
                showBadge: isFilterApplied(),
                child: Icon(
                  isFilterApplied()
                      ? Icons.filter_alt
                      : Icons.filter_alt_outlined,
                ),
              ),
              onPressed: () {
                _showBottomSheet(context, state.index);
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

  bool isFilterApplied() {
    return (_selectedIndex == 1 && _isMovieFilterApplied) ||
        (_selectedIndex == 2 && _isTvFilterApplied);
  }

  void _showBottomSheet(BuildContext context, int index) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      builder: (context) {
        EntityType type;
        if (index == MOVIES) {
          type = EntityType.movie;
        } else if (index == TV) {
          type = EntityType.tv;
        } else {
          throw FlutterError(
              "The bottom sheet index is not same as movies or tv shows");
        }
        return FractionallySizedBox(
          heightFactor: 0.8,
          child: FilterPage(
            type: type,
            discover: index == MOVIES ? _movieDiscover : _tvDiscover,
          ),
        );
      },
    ).then(onFilterChanged);
  }

  void onFilterChanged(value) {
    if (value != null && value != -1) {
      Discover discover = value as Discover;
      value = Requests.discover(
        type: _selectedIndex == 1 ? EntityType.movie : EntityType.tv,
        certification: discover.certification,
        releaseDateLessThan: discover.releaseDateRange?.end,
        releaseDateMoreThan: discover.releaseDateRange?.start,
        voteAverageGreaterThan: discover.voteAverage?.start.toInt(),
        voteAverageLessThan: discover.voteAverage?.end.toInt(),
        withGenres: discover.genres,
        sortMoviesBy: discover.sortMoviesBy,
        sortTvBy: discover.sortTvBy,
      );

      fetch(value);
      if (_selectedIndex == 1) {
        _movieDiscover = discover;
        movies = Container();
      } else if (_selectedIndex == 2) {
        _tvDiscover = discover;
        tv = Container();
      }
      setState(() {});

      return;
    } else if (value == -1) {
      setState(() {
        if (_selectedIndex == 1) {
          movies = defaultMovies;
          _movieFilterPage = 1;
          _isMovieFilterApplied = false;
          _movieDiscover = null;
          filterMovies.clear();
        } else if (_selectedIndex == 2) {
          tv = defaultTv;
          _tvFilterPage = 1;
          _isTvFilterApplied = false;
          _tvDiscover = null;
          filterTv.clear();
        }
      });
    }
  }

  void fetch(value) async {
    List<BaseModel> list = await Requests.discoverFuture(
        type: _selectedIndex == 1 ? EntityType.movie : EntityType.tv,
        query: value,
        page: _selectedIndex == 1 ? _movieFilterPage : _tvFilterPage);
    setState(() {
      if (_selectedIndex == 1) {
        filterMovies = [
          ...filterMovies,
        ];
        filterMovies.clear();
        filterMovies.addAll(list);
        _isMovieFilterApplied = true;
      } else if (_selectedIndex == 2) {
        filterTv = [...filterTv];
        filterTv.clear();
        filterTv.addAll(list);
        _isTvFilterApplied = true;
      }
      setFilteredItems(value);
    });
  }

  void setFilteredItems(String value) {
    if (_selectedIndex == 1) {
      movies = GridView.builder(
        shrinkWrap: true,
        itemCount: filterMovies.length,
        physics: BouncingScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: Style.movieTileWithTitleRatio,
        ),
        itemBuilder: (context, index) {
          return MovieTile(
            image:
                "${Constants.imageBaseUrl}${Constants.posterSize}${filterMovies[index].posterPath}",
            width: ScreenSize.getPercentOfWidth(
              context,
              0.29,
            ),
            showTitle: true,
            text: filterMovies[index].title!,
          );
        },
      );
    } else if (_selectedIndex == 2) {
      tv = GridView.builder(
        shrinkWrap: true,
        itemCount: filterTv.length,
        physics: BouncingScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: Style.movieTileWithTitleRatio,
        ),
        itemBuilder: (context, index) {
          return MovieTile(
            image:
                "${Constants.imageBaseUrl}${Constants.posterSize}${filterTv[index].posterPath}",
            width: ScreenSize.getPercentOfWidth(
              context,
              0.29,
            ),
            showTitle: true,
            text: filterTv[index].title!,
          );
        },
      );
    }
  }
}
