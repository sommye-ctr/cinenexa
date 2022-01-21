import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:watrix/models/home.dart';
import 'package:watrix/services/requests.dart';
import 'package:watrix/utils/screen_size.dart';
import 'package:watrix/widgets/custom_tab.dart';
import 'package:watrix/widgets/horizontal_list.dart';
import 'package:watrix/widgets/user_profile.dart';

import 'package:http/http.dart' as http;

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  Future<List<Home>> getPopularMoviesFuture() async {
    final response = await http.get(Uri.parse(Requests.popularMovies));

    var parsedList = json.decode(response.body)['results'];

    return (parsedList as List).map((e) => Home.fromMap(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(
          left: ScreenSize.getPercentOfWidth(context, 0.02),
        ),
        child: ListView(
          children: [
            UserProfileView(),
            SizedBox(
              height: ScreenSize.getPercentOfHeight(
                context,
                0.02,
              ),
            ),
            CustomTab([
              "Movies",
              "TV Shows",
              "Anime",
              "My List",
            ]),
            SizedBox(
              height: ScreenSize.getPercentOfHeight(
                context,
                0.02,
              ),
            ),
            HorizontalList(
              Requests.homeMoviesFuture(Requests.popularMovies),
              "Popular",
              () {},
              0.3,
            ),
            SizedBox(
              height: ScreenSize.getPercentOfHeight(
                context,
                0.02,
              ),
            ),
            HorizontalList(
              Requests.homeMoviesFuture(Requests.topRatedMovies),
              "Top Rated",
              () {},
              0.3,
            ),
            SizedBox(
              height: ScreenSize.getPercentOfHeight(
                context,
                0.02,
              ),
            ),
            HorizontalList(
              Requests.homeMoviesFuture(Requests.nowPlayingMovies),
              "Now Playing",
              () {},
              0.3,
            ),
          ],
        ),
      ),
    );
  }
}
