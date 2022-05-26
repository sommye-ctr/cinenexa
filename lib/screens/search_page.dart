import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:watrix/resources/strings.dart';
import 'package:watrix/resources/style.dart';
import 'package:watrix/store/search/search_store.dart';
import 'package:watrix/utils/screen_size.dart';
import 'package:watrix/widgets/search_input.dart';

import '../components/movie_tile.dart';
import '../components/search_result_tile.dart';
import '../models/base_model.dart';
import '../services/constants.dart';
import '../services/utils.dart';
import 'details_page.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final SearchStore searchStore = SearchStore();
  late TextEditingController textEditingController;

  @override
  void initState() {
    textEditingController = TextEditingController();
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
            _buildSpacing(),
            _buildSearchTypeTabs(),
            _buildMainBody(),
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
    );
  }

  Widget _buildMainBody() {
    return Observer(builder: (_) {
      if (searchStore.searchDone) {
        return _buildSearchResults();
      }
      return _buildSearchHint();
    });
  }

  Widget _buildSearchHint() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          Strings.searchHint,
          style: Style.headingStyle,
        ),
        _buildSpacing(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildIconHint(
              Strings.moviesTvShows,
              "assets/images/movies&tv.png",
            ),
            _buildIconHint(
              Strings.actorsDirectors,
              "assets/images/actor.png",
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
        return Container();
      },
    );
  }

  Widget _buildMoviesOrTv() {
    if (searchStore.isLoading) {
      return CircularProgressIndicator();
    }
    if (searchStore.resultsEmpty) {
      return Text(Strings.noResultsFound);
    }
    return Flexible(
      child: LazyLoadScrollView(
        onEndOfPage: () {
          searchStore.onEndOfPageReached();
        },
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: searchStore.items.length,
          itemBuilder: (context, index) {
            BaseModel baseModel = searchStore.items[index];
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
      ),
    );
  }

  Widget _buildActors() {
    if (searchStore.isLoading) {
      return CircularProgressIndicator();
    }
    if (searchStore.resultsEmpty) {
      return Text(Strings.noResultsFound);
    }
    return Expanded(
      child: LazyLoadScrollView(
        onEndOfPage: () => searchStore.onEndOfPageReached(),
        child: GridView.builder(
          shrinkWrap: true,
          itemCount: searchStore.items.length,
          physics: BouncingScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: Style.movieTileWithTitleRatio,
          ),
          itemBuilder: (context, index) {
            return MovieTile(
              image:
                  "${Constants.imageBaseUrl}${Constants.posterSize}${searchStore.items[index].posterPath}",
              width: ScreenSize.getPercentOfWidth(
                context,
                0.29,
              ),
              showTitle: true,
              text: searchStore.items[index].title!,
              onClick: () {
                Navigator.pushNamed(
                  context,
                  DetailsPage.routeName,
                  arguments: searchStore.items[index],
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

  Widget _buildSpacing({double percent = 0.02}) {
    return SizedBox(
      height: ScreenSize.getPercentOfHeight(context, percent),
    );
  }
}
