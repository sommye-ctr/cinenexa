import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watrix/bloc/search_page_event.dart';
import 'package:watrix/models/base_model.dart';
import 'package:watrix/resources/strings.dart';
import 'package:watrix/resources/style.dart';
import 'package:watrix/services/constants.dart';
import 'package:watrix/services/utils.dart';
import 'package:watrix/utils/screen_size.dart';
import 'package:watrix/components/movie_tile.dart';
import 'package:watrix/components/search_result_tile.dart';

import '../bloc/search_page_bloc.dart';
import '../bloc/search_page_state.dart';
import 'details_page.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SearchPageBloc(),
      child: SearchPageView(),
    );
  }
}

class SearchPageView extends StatefulWidget {
  const SearchPageView({Key? key}) : super(key: key);

  @override
  State<SearchPageView> createState() => _SearchPageViewState();
}

class _SearchPageViewState extends State<SearchPageView> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackClicked,
      child: Container(
        width: ScreenSize.getPercentOfWidth(context, 1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildSearchBar(),
            _buildSpacing(),
            _buildHeading(),
            _buildSpacing(),
            _buildFutureBuilder(),
            _buildSpacing(percent: 0.08),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      width: ScreenSize.getPercentOfWidth(context, 0.95),
      child: TextField(
        controller: _textEditingController,
        onChanged: (value) {
          context.read<SearchPageBloc>().add(
                SearchTermChanged(searchTerm: value),
              );
        },
        onEditingComplete: () {
          context.read<SearchPageBloc>().add(
                SearchClicked(),
              );
        },
        style: TextStyle(
          color: Colors.black,
        ),
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          hintText: Strings.searchHint,
          hintStyle: TextStyle(color: Colors.black),
          suffixIcon: Icon(
            Icons.search,
            color: Colors.black,
          ),
        ),
        textInputAction: TextInputAction.search,
        textCapitalization: TextCapitalization.words,
      ),
    );
  }

  Widget _buildHeading() {
    return BlocBuilder<SearchPageBloc, SearchPageState>(
      buildWhen: (previous, current) =>
          previous.runtimeType != current.runtimeType,
      builder: ((context, state) {
        if (state is SearchNotDone) {
          return Text(
            Strings.frequentSearch,
            style: Style.headingStyle,
          );
        } else if (state is SearchDone) {
          return DefaultTabController(
            length: 3,
            child: TabBar(
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.transparent,
              isScrollable: true,
              onTap: _onSearchTypeChanged,
              tabs: [
                Tab(
                  text: Strings.movies,
                ),
                Tab(
                  text: Strings.tvShows,
                ),
                Tab(
                  text: Strings.actor,
                ),
              ],
            ),
          );
        }
        throw FlutterError("Unknown state");
      }),
    );
  }

  Widget _buildSpacing({double percent = 0.02}) {
    return SizedBox(
      height: ScreenSize.getPercentOfHeight(context, percent),
    );
  }

  Widget _buildFutureBuilder() {
    return BlocBuilder<SearchPageBloc, SearchPageState>(
      builder: (context, state) {
        return FutureBuilder(
          builder: ((context, AsyncSnapshot<List<BaseModel>> snapshot) {
            return _buildList(context, snapshot, state);
          }),
          future: state.future as Future<List<BaseModel>>,
        );
      },
    );
  }

  Widget _buildList(
    BuildContext context,
    AsyncSnapshot<List<BaseModel>> snapshot,
    SearchPageState searchPageState,
  ) {
    if (snapshot.connectionState == ConnectionState.done) {
      if (searchPageState is SearchDone &&
          context.read<SearchPageBloc>().searchType != SearchType.people) {
        return Flexible(
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              BaseModel baseModel = snapshot.data![index];
              if (baseModel.type == BaseModelType.people) {}
              return SearchResultTile(
                image: Utils.getPosterUrl(baseModel.posterPath ?? ""),
                year: baseModel.releaseDate ?? "",
                overview: baseModel.overview ?? "",
                title: baseModel.title ?? "",
                type: Utils.getEntityTypeBy(baseModel.type!),
                typeColor: Utils.getColorByEntity(baseModel.type!),
                vote: baseModel.type == BaseModelType.people
                    ? 0
                    : baseModel.voteAverage!,
                onClick: () {
                  Navigator.pushNamed(
                    context,
                    DetailsPage.routeName,
                    arguments: baseModel,
                  );
                },
              );
            },
          ),
        );
      }
      return _buildGridView(snapshot);
    }
    return Container();
  }

//for frequentSearch as well as actors list
  Widget _buildGridView(AsyncSnapshot<List<BaseModel>> snapshot) {
    return Expanded(
      child: GridView.builder(
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
            text: snapshot.data![index].title!,
            onClick: () {
              Navigator.pushNamed(
                context,
                DetailsPage.routeName,
                arguments: snapshot.data![index],
              );
            },
          );
        },
      ),
    );
  }

  Future<bool> _onBackClicked() {
    if (context.read<SearchPageBloc>().state is SearchDone) {
      context.read<SearchPageBloc>().add(
            SearchBackClicked(),
          );
      setState(() {
        _textEditingController.clear();
      });
      return Future(() => false);
    }
    return Future(() => true);
  }

  void _onSearchTypeChanged(int index) {
    SearchPageBloc bloc = context.read<SearchPageBloc>();
    switch (index) {
      case 0:
        bloc.add(
          SearchTypeChanged(
            index: index,
            searchType: SearchType.movie,
          ),
        );
        break;
      case 1:
        bloc.add(
          SearchTypeChanged(
            index: index,
            searchType: SearchType.tv,
          ),
        );
        break;
      case 2:
        bloc.add(
          SearchTypeChanged(
            index: index,
            searchType: SearchType.people,
          ),
        );
        break;
    }
  }
}

/* 
  Widget getHeading() {
    if (!_isSearchDone)
      return Text(
        Strings.frequentSearch,
        style: Style.headingStyle,
      );
    return DefaultTabController(
      length: 3,
      child: TabBar(
        labelColor: Colors.black,
        unselectedLabelColor: Colors.grey,
        indicatorColor: Colors.transparent,
        isScrollable: true,
        controller: _tabController,
        tabs: [
          Tab(
            text: Strings.movies,
          ),
          Tab(
            text: Strings.tvShows,
          ),
          Tab(
            text: Strings.actor,
          ),
        ],
      ),
    );
  }

  void onSearchTermChanged(String value) {
    setState(() {
      _searchTerm = value;
    });
  }

  void onSearhClicked() {
    if (_searchTerm.length > 3) {
      setState(() {
        _isSearchDone = true;
        future = Requests.searchFuture(
            _searchTerm, Requests.search(EntityType.movie));
        _tabController.animateTo(0);
      });
    }
  } */

  /*  void onSearchTypeChanged() {
    setState(() {
      _isSearchDone = true;
      String base = "";
      switch (_tabController.index) {
        case 0:
          base = Requests.search(EntityType.movie);
          break;
        case 1:
          base = Requests.search(EntityType.tv);
          break;
        case 2:
          base = Requests.search(EntityType.people);
          break;
      }
      future = Requests.searchFuture(_searchTerm, base);
    });
  } */