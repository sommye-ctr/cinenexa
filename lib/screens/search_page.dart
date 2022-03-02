import 'package:flutter/material.dart';
import 'package:watrix/models/base_model.dart';
import 'package:watrix/resources/strings.dart';
import 'package:watrix/resources/style.dart';
import 'package:watrix/services/constants.dart';
import 'package:watrix/services/entity_type.dart';
import 'package:watrix/services/requests.dart';
import 'package:watrix/services/utils.dart';
import 'package:watrix/utils/screen_size.dart';
import 'package:watrix/components/movie_tile.dart';
import 'package:watrix/components/search_result_tile.dart';

import 'details_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with TickerProviderStateMixin {
  String _searchTerm = "";
  Future<List<BaseModel>> future =
      Requests.titlesFuture(Requests.popular(EntityType.movie));
  bool _isSearchDone = false;
  late TextEditingController _textEditingController;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(onSearchTypeChanged);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (_isSearchDone) {
          setState(() {
            future = Requests.titlesFuture(Requests.popular(EntityType.movie));
            _isSearchDone = false;
            _textEditingController.clear();
          });
          return Future(() => false);
        }
        return Future(() => true);
      },
      child: Container(
        width: ScreenSize.getPercentOfWidth(context, 1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: ScreenSize.getPercentOfWidth(context, 0.95),
              child: TextField(
                controller: _textEditingController,
                onChanged: onSearchTermChanged,
                onEditingComplete: onSearhClicked,
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
            ),
            if (!_isSearchDone)
              SizedBox(
                height: ScreenSize.getPercentOfHeight(context, 0.02),
              ),
            getHeading(),
            SizedBox(
              height: ScreenSize.getPercentOfHeight(context, 0.02),
            ),
            FutureBuilder(
              builder: futureBuilder,
              future: future,
            ),
            SizedBox(
              height: ScreenSize.getPercentOfHeight(context, 0.08),
            ),
          ],
        ),
      ),
    );
  }

  Widget getHeading() {
    if (!_isSearchDone)
      return Text(
        Strings.frequentSearch,
        style: Style.headingStyle,
      );
    return DefaultTabController(
      length: 4,
      child: TabBar(
        labelColor: Colors.black,
        unselectedLabelColor: Colors.grey,
        indicatorColor: Colors.transparent,
        isScrollable: true,
        controller: _tabController,
        tabs: [
          Tab(
            text: Strings.all,
          ),
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

  void onSearchTypeChanged() {
    setState(() {
      _isSearchDone = true;
      String base = "";
      switch (_tabController.index) {
        case 0:
          base = Requests.search(EntityType.all);
          break;
        case 1:
          base = Requests.search(EntityType.movie);
          break;
        case 2:
          base = Requests.search(EntityType.tv);
          break;
        case 3:
          base = Requests.search(EntityType.people);
          break;
      }
      future = Requests.searchFuture(_searchTerm, base);
    });
  }

  void onSearchTermChanged(String value) {
    setState(() {
      _searchTerm = value;
    });
  }

  void onSearhClicked() {
    setState(() {
      _isSearchDone = true;
      future =
          Requests.searchFuture(_searchTerm, Requests.search(EntityType.all));
    });
  }

  Widget futureBuilder(
      BuildContext context, AsyncSnapshot<List<BaseModel>> snapshot) {
    if (snapshot.connectionState == ConnectionState.done) {
      if (_isSearchDone) {
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
      return frequentSearch(snapshot);
    }
    return Container();
  }

  Widget frequentSearch(AsyncSnapshot<List<BaseModel>> snapshot) {
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
}
