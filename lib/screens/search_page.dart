import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:watrix/resources/asset.dart';
import 'package:watrix/resources/my_theme.dart';
import 'package:watrix/resources/strings.dart';
import 'package:watrix/resources/style.dart';
import 'package:watrix/screens/actor_details_page.dart';
import 'package:watrix/store/search/search_store.dart';
import 'package:watrix/utils/screen_size.dart';
import 'package:watrix/widgets/search_input.dart';

import '../components/movie_tile.dart';
import '../components/search_result_tile.dart';
import '../models/network/base_model.dart';
import '../services/constants.dart';
import '../services/network/utils.dart';
import 'details_page.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late SearchStore searchStore;
  late TextEditingController textEditingController;
  late FocusNode focusNode;
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    searchStore = SearchStore();
    textEditingController = TextEditingController();
    focusNode = FocusNode();
    super.initState();
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
            Style.getVerticalSpacing(context: context),
            _buildSearchTypeTabs(),
            _buildMainBody(),
            SizedBox(
              height: kBottomNavigationBarHeight,
            )
          ],
        ),
      ),
    );
  }

  Future<bool> _onBackClicked() {
    if (searchStore.searchDone) {
      searchStore.backClicked();
      textEditingController.clear();
      return Future(() => false);
    }
    return Future(() => true);
  }

  Widget _buildSearchBar() {
    return SearchInput(
      onChanged: searchStore.searchTermChanged,
      onEditingComplete: () => searchStore.searchClicked(),
      controller: textEditingController,
      onCancelSearch: searchStore.searchCancelled,
      focus: focusNode,
      onSearchFocused: searchStore.searchBoxFocused,
    );
  }

  Widget _buildMainBody() {
    return Observer(builder: (_) {
      if (searchStore.searchDone) {
        return _buildSearchResults();
      }
      if (searchStore.searchFocused) {
        return _buildSearchHistory();
      }
      return _buildSearchHint();
    });
  }

  Widget _buildSearchHistory() {
    return Expanded(
      child: AnimatedList(
        key: listKey,
        initialItemCount: searchStore.history.length,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index, animation) {
          return _buildSearchHistorySingleTerm(context, index, animation);
        },
      ),
    );
  }

  Widget _buildSearchHistorySingleTerm(
      BuildContext context, int index, animation) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: Offset(1, 0),
        end: Offset(0, 0),
      ).animate(animation),
      child: Column(
        children: [
          Container(
            width: ScreenSize.getPercentOfWidth(context, 0.95),
            child: ListTile(
              title: Text(searchStore.history[index].term),
              leading: Icon(Icons.history_rounded),
              trailing: IconButton(
                onPressed: () {
                  _onSearchHistoryCleared(index);
                },
                icon: Icon(Icons.clear),
              ),
              onTap: () =>
                  _onSearchHistoryClicked(searchStore.history[index].term),
            ),
          ),
          Style.getVerticalSpacing(context: context, percent: 0.01),
        ],
      ),
    );
  }

  void _onSearchHistoryCleared(int index) {
    listKey.currentState?.removeItem(
      index,
      (context, animation) =>
          _buildSearchHistorySingleTerm(context, index, animation),
      duration: kThemeAnimationDuration,
    );
    Future.delayed(
      kThemeAnimationDuration,
      () => searchStore.historyDeleted(searchStore.history[index]),
    );
  }

  Widget _buildSearchHint() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          Strings.searchHint,
          style: Style.headingStyle,
        ),
        Style.getVerticalSpacing(context: context),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildIconHint(
              Strings.moviesTvShows,
              Provider.of<MyTheme>(context, listen: false).darkMode
                  ? Asset.moviesTvLight
                  : Asset.moviesTvDark,
            ),
            _buildIconHint(
              Strings.actorsDirectors,
              Provider.of<MyTheme>(context, listen: false).darkMode
                  ? Asset.actorsLight
                  : Asset.actorsDark,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSearchResults() {
    if (searchStore.searchType == SearchType.people) {
      return _buildActors();
    }
    return _buildMoviesOrTv();
  }

  Widget _buildSearchTypeTabs() {
    return Observer(
      builder: (_) {
        if (searchStore.searchDone) {
          return DefaultTabController(
            length: 3,
            child: TabBar(
              unselectedLabelColor: Theme.of(context).hintColor,
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
        return Container();
      },
    );
  }

  Widget _buildMoviesOrTv() {
    if (searchStore.fetchItemsFuture.status == FutureStatus.pending) {
      return CircularProgressIndicator();
    }
    List<BaseModel> list =
        searchStore.fetchItemsFuture.result as List<BaseModel>;
    if (searchStore.fetchItemsFuture.status == FutureStatus.fulfilled &&
        list.isEmpty) {
      return Text(Strings.noResultsFound);
    }
    return Flexible(
      child: LazyLoadScrollView(
        onEndOfPage: () {
          searchStore.onEndOfPageReached();
        },
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: list.length,
          itemBuilder: (context, index) {
            BaseModel baseModel = list[index];
            return SearchResultTile(
              image: Utils.getPosterUrl(baseModel.posterPath ?? ""),
              year: baseModel.releaseDate ?? "",
              overview: baseModel.overview ?? "",
              title: baseModel.title ?? "",
              type: Utils.getStringByBasemodelType(baseModel.type!),
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
      ),
    );
  }

  Widget _buildActors() {
    if (searchStore.fetchItemsFuture.status == FutureStatus.pending) {
      return CircularProgressIndicator();
    }
    List<BaseModel> list =
        searchStore.fetchItemsFuture.result as List<BaseModel>;
    if (searchStore.fetchItemsFuture.status == FutureStatus.fulfilled &&
        list.isEmpty) {
      return Text(Strings.noResultsFound);
    }
    return Expanded(
      child: LazyLoadScrollView(
        onEndOfPage: () => searchStore.onEndOfPageReached(),
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
              onClick: () {
                Navigator.pushNamed(
                  context,
                  ActorDetailsPage.routeName,
                  arguments: list[index],
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildIconHint(String text, String image) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          image,
          width: ScreenSize.getPercentOfWidth(context, 0.25),
          fit: BoxFit.contain,
        ),
        Text(text),
      ],
    );
  }

  void _onSearchHistoryClicked(String term) {
    focusNode.requestFocus();
    textEditingController.value = TextEditingValue(text: term);
    searchStore.searchHistoryTermClicked(term);
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
