import 'package:flutter/material.dart';
import 'package:watrix/models/movie.dart';
import 'package:watrix/resources/strings.dart';
import 'package:watrix/services/constants.dart';
import 'package:watrix/services/requests.dart';
import 'package:watrix/utils/screen_size.dart';
import 'package:watrix/widgets/rounded_image.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String _searchTerm = "";
  Future<List<Movie>>? future;

  void onSearchTermChanged(String value) {
    setState(() {
      _searchTerm = value;
    });
  }

  void onSearhClicked() {
    setState(() {
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
            crossAxisCount: 2,
            childAspectRatio: Constants.posterAspectRatio,
          ),
          itemBuilder: (context, index) {
            return RoundedImage(
                "${Constants.imageBaseUrl}${Constants.posterSize}${snapshot.data![index].posterPath}",
                ScreenSize.getPercentOfWidth(
                  context,
                  0.4,
                ));
          },
        ),
      );
    }
    return Text("Loading...");
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
          FutureBuilder(
            builder: futureBuilder,
            future: future,
          ),
        ],
      ),
    );
  }
}
