import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:watrix/store/search/search_result_store.dart';

import '../components/movie_tile.dart';
import '../components/search_result_tile.dart';
import '../models/base_model.dart';
import '../resources/strings.dart';
import '../resources/style.dart';
import '../services/constants.dart';
import '../services/utils.dart';
import '../store/search/search_store.dart';
import '../utils/screen_size.dart';
import '../widgets/search_input.dart';
import 'details_page.dart';

class SearchResultPage extends StatefulWidget {
  static const routeName = "/searchResult";

  final String searchTerm;
  const SearchResultPage({
    Key? key,
    required this.searchTerm,
  }) : super(key: key);

  @override
  State<SearchResultPage> createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  late SearchResultStore resultStore;

  @override
  void initState() {
    resultStore = SearchResultStore(searchTerm: widget.searchTerm);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: ScreenSize.getPercentOfWidth(context, 1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildSearchBar(),
              _buildSpacing(),
              _buildHeading(),
              _buildContent(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return SearchInput(
      value: resultStore.searchTerm,
      onChanged: resultStore.searchTermChanged,
      onEditingComplete: resultStore.searchClicked,
    );
  }

  Widget _buildHeading() {
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

  Widget _buildContent() {
    return Observer(builder: (_) {
      if (resultStore.searchType == SearchType.people) {
        return _buildActors();
      }
      return _buildMoviesOrTv();
    });
  }

  Widget _buildMoviesOrTv() {
    return Flexible(
      child: LazyLoadScrollView(
        onEndOfPage: () {
          resultStore.onEndOfPageReached();
        },
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: resultStore.items.length,
          itemBuilder: (context, index) {
            BaseModel baseModel = resultStore.items[index];
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
      ),
    );
  }

  Widget _buildActors() {
    return Expanded(
      child: LazyLoadScrollView(
        onEndOfPage: () => resultStore.onEndOfPageReached(),
        child: GridView.builder(
          shrinkWrap: true,
          itemCount: resultStore.items.length,
          physics: BouncingScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: Style.movieTileWithTitleRatio,
          ),
          itemBuilder: (context, index) {
            return MovieTile(
              image:
                  "${Constants.imageBaseUrl}${Constants.posterSize}${resultStore.items[index].posterPath}",
              width: ScreenSize.getPercentOfWidth(
                context,
                0.29,
              ),
              showTitle: true,
              text: resultStore.items[index].title!,
              onClick: () {
                Navigator.pushNamed(
                  context,
                  DetailsPage.routeName,
                  arguments: resultStore.items[index],
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildSpacing({double percent = 0.02}) {
    return SizedBox(
      height: ScreenSize.getPercentOfHeight(context, percent),
    );
  }

  void _onSearchTypeChanged(int index) {
    switch (index) {
      case 0:
        resultStore.searchTypeChanged(SearchType.movie);
        break;
      case 1:
        resultStore.searchTypeChanged(SearchType.tv);
        break;
      case 2:
        resultStore.searchTypeChanged(SearchType.people);
        break;
    }
  }
}
