import 'package:flutter/material.dart';
import 'package:watrix/models/movie.dart';
import 'package:watrix/resources/strings.dart';
import 'package:watrix/resources/style.dart';
import 'package:watrix/services/constants.dart';
import 'package:watrix/services/requests.dart';
import 'package:watrix/utils/screen_size.dart';
import 'package:watrix/widgets/movie_tile.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String _searchTerm = "";
  Future<List<Movie>> future = Requests.moviesFuture(Requests.popularMovies);
  bool _isSearchDone = false;

  void onSearchTermChanged(String value) {
    setState(() {
      _searchTerm = value;
    });
  }

  void onSearhClicked() {
    setState(() {
      _isSearchDone = true;
      future = Requests.searchMovie(_searchTerm);
    });
  }

  Widget futureBuilder(
      BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
    if (snapshot.connectionState == ConnectionState.done) {
      return Expanded(
        child: GridView.builder(
          shrinkWrap: true,
          itemCount: snapshot.data!.length,
          physics: BouncingScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: Constants.posterAspectRatio,
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
              text: snapshot.data![index].title,
            );
          },
        ),
      );
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenSize.getPercentOfWidth(context, 1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: ScreenSize.getPercentOfWidth(context, 0.95),
            child: TextField(
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
          SizedBox(
            height: ScreenSize.getPercentOfHeight(context, 0.02),
          ),
          Visibility(
            visible: !_isSearchDone,
            child: Text(
              Strings.frequentSearch,
              style: Style.headingStyle,
            ),
          ),
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
    );
  }
}
