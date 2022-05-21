import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:watrix/models/base_model.dart';
import 'package:watrix/resources/strings.dart';
import 'package:watrix/resources/style.dart';
import 'package:watrix/services/constants.dart';
import 'package:watrix/services/utils.dart';
import 'package:watrix/store/search/search_store.dart';
import 'package:watrix/utils/screen_size.dart';
import 'package:watrix/components/movie_tile.dart';
import 'package:watrix/components/search_result_tile.dart';

import 'details_page.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late TextEditingController _textEditingController;
  final SearchStore searchStore = SearchStore();

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
        onChanged: searchStore.searchTermChanged,
        onEditingComplete: searchStore.searchClicked,
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
    return Observer(
      builder: (context) {
        if (!searchStore.searchDone) {
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
      },
    );
  }

  Widget _buildSpacing({double percent = 0.02}) {
    return SizedBox(
      height: ScreenSize.getPercentOfHeight(context, percent),
    );
  }

  Widget _buildFutureBuilder() {
    return Observer(
      builder: (context) {
        return FutureBuilder(
          builder: ((context, AsyncSnapshot<List<BaseModel>> snapshot) {
            return _buildList(context, snapshot);
          }),
          future: searchStore.future,
        );
      },
    );
  }

  Widget _buildList(
    BuildContext context,
    AsyncSnapshot<List<BaseModel>> snapshot,
  ) {
    if (snapshot.connectionState == ConnectionState.done) {
      if (searchStore.searchDone &&
          searchStore.searchType != SearchType.people) {
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
    if (searchStore.searchDone) {
      searchStore.backClicked();
      setState(() {
        _textEditingController.clear();
      });
      return Future(() => false);
    }
    return Future(() => true);
  }

  void _onSearchTypeChanged(int index) {
    switch (index) {
      case 0:
        searchStore.searchTypeChanged(SearchType.movie);
        break;
      case 1:
        searchStore.searchTypeChanged(SearchType.tv);
        break;
      case 2:
        searchStore.searchTypeChanged(SearchType.people);
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