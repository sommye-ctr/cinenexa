import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:lottie/lottie.dart';
import 'package:mobx/mobx.dart';
import 'package:cinenexa/resources/asset.dart';
import 'package:cinenexa/resources/strings.dart';
import 'package:cinenexa/resources/style.dart';
import 'package:cinenexa/screens/actor_details_page.dart';
import 'package:cinenexa/store/search/search_store.dart';
import 'package:cinenexa/utils/screen_size.dart';
import 'package:cinenexa/widgets/search_input.dart';

import '../components/search_result_tile.dart';
import '../models/network/base_model.dart';
import '../services/network/utils.dart';
import 'details_page.dart';

class SearchPage extends StatefulWidget {
  final Function({int? index})? onBack;

  SearchPage({Key? key, this.onBack}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with TickerProviderStateMixin {
  late SearchStore searchStore;
  late TextEditingController textEditingController;
  late FocusNode focusNode;
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  late TabController tabController;

  @override
  void initState() {
    searchStore = SearchStore();
    textEditingController = TextEditingController();
    focusNode = FocusNode();
    tabController = TabController(length: 3, vsync: this);
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

  Future<bool> _onBackClicked() async {
    if (searchStore.searchDone) {
      searchStore.backClicked();
      textEditingController.clear();
      return false;
    }
    if (widget.onBack != null) {
      widget.onBack!();
      return false;
    }
    return true;
  }

  Widget _buildSearchBar() {
    return SearchInput(
      onEditingComplete: () =>
          searchStore.searchClicked(textEditingController.text),
      controller: textEditingController,
      focus: focusNode,
      onChanged: searchStore.searchTermChanged,
      onSearchFocused: searchStore.searchBoxFocused,
      onCancelSearch: searchStore.searchCancelled,
      onListening: () {
        searchStore.speakToTextClicked(true);
      },
    );
  }

  Widget _buildMainBody() {
    return Observer(builder: (_) {
      if (searchStore.speaking) {
        return _buildSpeakingOverlay();
      }
      if (searchStore.searchDone) {
        return _buildSearchResults();
      }
      if (searchStore.searchFocused) {
        if (searchStore.searchTerm.isEmpty) return _buildSearchHistory();
        return _buildSearchAutocomplete();
      }

      return _buildSearchHint();
    });
  }

  Widget _buildSearchAutocomplete() {
    if (searchStore.autoCompleteTerms.status == FutureStatus.fulfilled) {
      var list = searchStore.autoCompleteTerms.value!.take(10).toList();
      return Expanded(
        child: ListView.builder(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          itemCount: list.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(list[index].title!),
              onTap: () {
                _onAutocompleteClicked(list[index]);
              },
            );
          },
        ),
      );
    }
    return Container();
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

  Widget _buildSpeakingOverlay() {
    return AvatarGlow(
      endRadius: 80,
      animate: searchStore.speaking,
      glowColor: Theme.of(context).colorScheme.primary,
      child: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.circle,
          size: 35,
        ),
      ),
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
        ValueListenableBuilder<AdaptiveThemeMode>(
          valueListenable: AdaptiveTheme.of(context).modeChangeNotifier,
          builder: (context, value, child) {
            bool isDarkMode = value == AdaptiveThemeMode.dark;

            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildIconHint(
                  Strings.moviesTvShows,
                  isDarkMode ? Asset.moviesTvLight : Asset.moviesTvDark,
                ),
                _buildIconHint(
                  Strings.actorsDirectors,
                  isDarkMode ? Asset.actorsLight : Asset.actorsDark,
                ),
              ],
            );
          },
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
              indicator: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(Style.largeRoundEdgeRadius),
                ),
                color: Theme.of(context).colorScheme.primary,
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorPadding: EdgeInsets.all(8),
              splashBorderRadius: BorderRadius.circular(40),
              isScrollable: true,
              onTap: _onSearchTypeChanged,
              controller: tabController,
              tabs: [
                Tab(
                  text: Strings.movies,
                ),
                Tab(
                  text: Strings.shows,
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
    if (searchStore.fetchItemsFuture.status == FutureStatus.pending &&
        searchStore.results.isEmpty) {
      return CircularProgressIndicator();
    }
    List<BaseModel> list = searchStore.results;
    if (searchStore.fetchItemsFuture.status == FutureStatus.fulfilled &&
        list.isEmpty) {
      return Center(
        child: SvgPicture.asset(
          Asset.notFound,
          width: ScreenSize.getPercentOfWidth(context, 0.75),
        ),
      );
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
              onClick: () async {
                var isRedirect = await Navigator.pushNamed(
                  context,
                  DetailsPage.routeName,
                  arguments: baseModel,
                );
                if (isRedirect != null && isRedirect as bool) {
                  widget.onBack?.call(index: 1);
                }
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildActors() {
    if (searchStore.fetchItemsFuture.status == FutureStatus.pending &&
        searchStore.results.isEmpty) {
      return CircularProgressIndicator();
    }
    List<BaseModel> list = searchStore.results;
    if (searchStore.fetchItemsFuture.status == FutureStatus.fulfilled &&
        list.isEmpty) {
      return Center(
        child: SvgPicture.asset(
          Asset.notFound,
          width: ScreenSize.getPercentOfWidth(context, 0.75),
        ),
      );
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
            return Style.getActorTile(
              callback: () => Navigator.pushNamed(
                context,
                ActorDetailsPage.routeName,
                arguments: list[index],
              ),
              context: context,
              poster: list[index].posterPath,
              title: list[index].title,
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

  void _onAutocompleteClicked(BaseModel baseModel) {
    focusNode.requestFocus();
    textEditingController.value = TextEditingValue(text: baseModel.title!);
    switch (baseModel.type) {
      case BaseModelType.movie:
        searchStore.changeSearchType(SearchType.movie);
        tabController.animateTo(0);
        break;
      case BaseModelType.people:
        searchStore.changeSearchType(SearchType.people);
        tabController.animateTo(2);
        break;
      case BaseModelType.tv:
        searchStore.changeSearchType(SearchType.tv);
        tabController.animateTo(1);
        break;
      default:
    }

    searchStore.searchClicked(baseModel.title!);
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
