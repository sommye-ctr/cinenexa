import 'package:flutter/material.dart';
import 'package:watrix/models/sort_movies.dart';
import 'package:watrix/models/sort_tv.dart';
import 'package:watrix/resources/strings.dart';
import 'package:watrix/resources/style.dart';
import 'package:watrix/services/entity_type.dart';
import 'package:watrix/services/requests.dart';
import 'package:watrix/utils/screen_size.dart';
import 'package:watrix/widgets/custom_checkbox_list.dart';
import 'package:watrix/widgets/custom_rangle_slider.dart';

import '../models/genre.dart';

class FilterPage extends StatelessWidget {
  String? certification;
  SortMoviesBy? sortMoviesBy;
  SortTvBy? sortTvBy;
  DateTimeRange? releaseDateRange;
  RangeValues? voteAverage;
  List<Genre> genres = [];

  final EntityType type;

  FilterPage({
    Key? key,
    required this.type,
  }) : super(key: key);

  Widget certificationBuild(
      BuildContext context, AsyncSnapshot<List<String>> snapshot) {
    if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
      return CustomCheckBoxList(
        children: snapshot.data!.toList(),
        type: CheckBoxListType.list,
        singleSelect: true,
        onSelectionChanged: (values) {
          certification = values.first;
        },
      ); // TODO Add tooltip to explain the certitification
    }
    return Container();
  }

  Widget genreBuildGrid(
      BuildContext context, AsyncSnapshot<List<Genre>> snapshot) {
    if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
      return CustomCheckBoxList(
        type: CheckBoxListType.grid,
        children: snapshot.data!.map((e) => e.name).toList(),
        onSelectionChanged: (values) {
          genres
            ..clear()
            ..addAll(snapshot.data!
                .where((element) => values.contains(element.name)));
        },
        delegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 16 / 9,
          crossAxisSpacing: ScreenSize.getPercentOfWidth(context, 0.025),
          mainAxisSpacing: ScreenSize.getPercentOfWidth(context, 0.025),
        ),
      );
    }
    return Container();
  }

  Future? generateDiscoverRequest() {
    if (certification == null &&
        (sortMoviesBy == null && sortTvBy == null) &&
        releaseDateRange == null &&
        voteAverage == null &&
        genres.isEmpty) {
      return null;
    }
    return Requests.discover(
      type: type,
      certification: certification,
      releaseDateLessThan: releaseDateRange?.end,
      releaseDateMoreThan: releaseDateRange?.start,
      voteAverageGreaterThan: voteAverage?.start.toInt(),
      voteAverageLessThan: voteAverage?.end.toInt(),
      withGenres: genres,
      sortMoviesBy: sortMoviesBy,
    );
  }

  void onSubmitClick(BuildContext context) {
    Navigator.pop(context, generateDiscoverRequest());
  }

  void onResetClick(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenSize.getPercentOfWidth(context, 0.02),
      ),
      child: Stack(
        children: [
          ListView(
            physics: BouncingScrollPhysics(),
            children: [
              SizedBox(
                height: ScreenSize.getPercentOfHeight(context, 0.02),
              ),
              Text(
                Strings.sortBy,
                style: Style.headingStyle,
              ),
              SizedBox(
                height: ScreenSize.getPercentOfHeight(context, 0.01),
              ),
              CustomCheckBoxList(
                type: CheckBoxListType.list,
                singleSelect: true,
                onSelectionChanged: (values) {
                  if (type == EntityType.movie) {
                    switch (values.first) {
                      case Strings.popularity:
                        sortMoviesBy = SortMoviesBy.popularity;
                        break;
                      case Strings.voteAverage:
                        sortMoviesBy = SortMoviesBy.voteAverage;
                        break;
                      case Strings.releaseDate:
                        sortMoviesBy = SortMoviesBy.releaseDate;
                        break;
                    } // as it is single select only 1 item will be there
                  } else if (type == EntityType.tv) {
                    switch (values.first) {
                      case Strings.popularity:
                        sortTvBy = SortTvBy.popularity;
                        break;
                      case Strings.voteAverage:
                        sortTvBy = SortTvBy.voteAverage;
                        break;
                      case Strings.airDate:
                        sortTvBy = SortTvBy.firstAirDate;
                        break;
                    } // as it is single select only 1 item will be there
                  }
                },
                children: [
                  Strings.popularity,
                  Strings.voteAverage,
                  type == EntityType.movie
                      ? Strings.releaseDate
                      : Strings.airDate,
                ],
              ),
              Divider(),
              if (type == EntityType.movie) ...[
                Text(
                  Strings.certification,
                  style: Style.headingStyle,
                ),
                SizedBox(
                  height: ScreenSize.getPercentOfHeight(context, 0.01),
                ),
                FutureBuilder<List<String>>(
                  future: Requests.certificationsFuture(
                      Requests.certifications(type)),
                  builder: certificationBuild,
                ),
              ],
              Divider(),
              Text(
                Strings.voteAverage,
                style: Style.headingStyle,
              ),
              SizedBox(
                height: ScreenSize.getPercentOfHeight(context, 0.01),
              ),
              CustomRangeSlider(
                values: RangeValues(0, 10),
                onChanged: (changedValue) {
                  voteAverage = changedValue;
                },
              ),
              Divider(),
              Text(
                Strings.year,
                style: Style.headingStyle,
              ),
              SizedBox(
                height: ScreenSize.getPercentOfHeight(context, 0.01),
              ),
              CustomRangeSlider(
                  values: RangeValues(
                    DateTime.now().year - 100,
                    DateTime.now().year.toDouble(),
                  ),
                  onChanged: (changedValues) {
                    releaseDateRange = DateTimeRange(
                      start: DateTime(
                        changedValues.start.toInt(),
                      ),
                      end: DateTime(
                        changedValues.end.toInt(),
                      ),
                    );
                  }),
              Divider(),
              Text(
                Strings.genres,
                style: Style.headingStyle,
              ),
              SizedBox(
                height: ScreenSize.getPercentOfHeight(context, 0.01),
              ),
              FutureBuilder<List<Genre>>(
                future: Requests.genreFuture(Requests.genres(type)),
                builder: genreBuildGrid,
              ),
              SizedBox(
                height: ScreenSize.getPercentOfHeight(context, 0.05),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: ElevatedButton(
                        onPressed: () => onResetClick(context),
                        child: Text(Strings.reset),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white.withOpacity(0.5),
                        )),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () => onSubmitClick(context),
                      child: Text(Strings.submit),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white.withOpacity(0.5),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
