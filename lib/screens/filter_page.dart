import 'package:flutter/material.dart';
import 'package:cinenexa/models/network/enums/languages.dart';
import 'package:cinenexa/resources/strings.dart';
import 'package:cinenexa/resources/style.dart';
import 'package:cinenexa/models/network/enums/entity_type.dart';
import 'package:cinenexa/services/network/repository.dart';
import 'package:cinenexa/services/network/requests.dart';
import 'package:cinenexa/utils/screen_size.dart';
import 'package:cinenexa/widgets/custom_checkbox_list.dart';
import 'package:cinenexa/widgets/custom_rangle_slider.dart';

import '../models/local/enums/sort_movies.dart';
import '../models/local/enums/sort_tv.dart';
import '../models/network/certification.dart';
import '../models/network/discover.dart';
import '../models/network/genre.dart';

class FilterPage extends StatelessWidget {
  static const POPULARITY_INDEX = 0;
  static const VOTE_AVERAGE_INDEX = 1;
  static const DATE_INDEX = 2;
  static final DEFAULT_VOTE_AVERAGE = RangeValues(0, 10);
  static final DEFAULT_YEAR = RangeValues(
    DateTime.now().year - 100,
    DateTime.now().year.toDouble(),
  );

  final Discover discover;
  final EntityType type;

  FilterPage({
    Key? key,
    required this.type,
    Discover? discover,
  })  : this.discover = discover ?? Discover(),
        super(key: key);

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
              ..._buildSortBy(context),
              Divider(),
              ..._buildCertification(context),
              Divider(),
              ..._buildVoteAverage(context),
              Divider(),
              ..._buildReleaseYear(context),
              Divider(),
              ..._buildLanguages(context),
              Divider(),
              ..._buildGenres(context),
              SizedBox(
                height: ScreenSize.getPercentOfHeight(context, 0.05),
              ),
            ],
          ),
          _buildButtons(context),
        ],
      ),
    );
  }

  List<Widget> _buildSortBy(context) {
    return [
      Style.getVerticalSpacing(context: context),
      Text(
        Strings.sortBy,
        style: Style.headingStyle,
      ),
      Style.getVerticalSpacing(context: context),
      CustomCheckBoxList(
        type: CheckBoxListType.list,
        singleSelect: true,
        selectedItems:
            getSelectedSortBy() == null ? null : [getSelectedSortBy()!],
        children: [
          Strings.popularity,
          Strings.voteAverage,
          type == EntityType.movie ? Strings.releaseDate : Strings.airDate,
        ],
        onSelectionAdded: (values) {
          if (type == EntityType.movie) {
            switch (values.first) {
              // as it is single select only 1 item will be there
              case Strings.popularity:
                discover.sortMoviesBy = SortMoviesBy.popularity;
                break;
              case Strings.voteAverage:
                discover.sortMoviesBy = SortMoviesBy.voteAverage;
                break;
              case Strings.releaseDate:
                discover.sortMoviesBy = SortMoviesBy.releaseDate;
                break;
            }
          } else if (type == EntityType.tv) {
            switch (values.first) {
              case Strings.popularity:
                discover.sortTvBy = SortTvBy.popularity;
                break;
              case Strings.voteAverage:
                discover.sortTvBy = SortTvBy.voteAverage;
                break;
              case Strings.airDate:
                discover.sortTvBy = SortTvBy.firstAirDate;
                break;
            } // as it is single select only 1 item will be there
          }
        },
        onSelectionRemoved: (values) {
          if (type == EntityType.movie) {
            discover.sortMoviesBy = null;
          } else if (type == EntityType.tv) {
            discover.sortTvBy = null;
          }
        },
        onSelectionChanged: (values) {},
      ),
    ];
  }

  List<Widget> _buildCertification(context) {
    if (type == EntityType.movie) {
      return [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: Strings.certification,
                style: Style.headingStyle,
              ),
              TextSpan(
                text: " ${Strings.certificationSubtitle}",
                style: TextStyle(
                  color: Theme.of(context).hintColor,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
        Style.getVerticalSpacing(context: context),
        FutureBuilder<List<Certification>>(
          future: Repository.getCertification(
            Requests.certifications(type),
          ),
          builder: _buildCertificationList,
        ),
      ];
    }
    return [];
  }

  List<Widget> _buildVoteAverage(context) {
    return [
      Text(
        Strings.voteAverage,
        style: Style.headingStyle,
      ),
      Style.getVerticalSpacing(context: context),
      CustomRangeSlider(
        values: getDefaultVoteAverage(),
        min: DEFAULT_VOTE_AVERAGE.start,
        max: DEFAULT_VOTE_AVERAGE.end,
        onChanged: (changedValue) {
          discover.voteAverage = changedValue;
        },
      ),
    ];
  }

  List<Widget> _buildReleaseYear(context) {
    return [
      Text(
        Strings.year,
        style: Style.headingStyle,
      ),
      Style.getVerticalSpacing(context: context),
      CustomRangeSlider(
        values: getDefaultYearValues(),
        max: DEFAULT_YEAR.end,
        min: DEFAULT_YEAR.start,
        onChanged: (changedValues) {
          discover.releaseDateRange = DateTimeRange(
            start: DateTime(
              changedValues.start.toInt(),
            ),
            end: DateTime(
              changedValues.end.toInt(),
            ),
          );
        },
      ),
    ];
  }

  List<Widget> _buildGenres(context) {
    return [
      Text(
        Strings.genres,
        style: Style.headingStyle,
      ),
      SizedBox(
        height: ScreenSize.getPercentOfHeight(context, 0.01),
      ),
      FutureBuilder<List<Genre>>(
        future: Repository.getGenre(Requests.genres(type)),
        builder: _buildGenresGrid,
      ),
    ];
  }

  List<Widget> _buildLanguages(context) {
    List<String> lang = [];
    for (var element in Languages.values) {
      lang.add(element.getName());
    }
    return [
      Text(
        Strings.languages,
        style: Style.headingStyle,
      ),
      SizedBox(
        height: ScreenSize.getPercentOfHeight(context, 0.01),
      ),
      CustomCheckBoxList(
        children: lang,
        type: CheckBoxListType.grid,
        selectedItems: getSelectedLanguages(Languages.values),
        onSelectionChanged: (values) {
          discover.languages
            ..clear()
            ..addAll(values.map((e) => e.getLanguage()).toList());
        },
        delegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 16 / 9,
          crossAxisSpacing: ScreenSize.getPercentOfWidth(context, 0.025),
          mainAxisSpacing: ScreenSize.getPercentOfWidth(context, 0.025),
        ),
      ),
    ];
  }

  Widget _buildButtons(context) {
    return Align(
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
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () => onSubmitClick(context),
                child: Text(Strings.submit),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCertificationList(
      BuildContext context, AsyncSnapshot<List<Certification>> snapshot) {
    if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
      List<String> items = snapshot.data!.map((e) => e.certification).toList();
      return CustomCheckBoxList(
        children: items,
        type: CheckBoxListType.list,
        singleSelect: true,
        selectedItems: getSelectedCertification(items) == null
            ? null
            : [
                getSelectedCertification(items)!,
              ],
        tooltips: snapshot.data!.map((e) => e.meaning).toList(),
        onSelectionAdded: (values) {
          discover.certification = values.first; //as it is single select
        },
        onSelectionRemoved: (values) {
          discover.certification = null;
        },
      );
    }
    return SizedBox(
      width: ScreenSize.getPercentOfWidth(context, 0.1),
      child: Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildGenresGrid(
      BuildContext context, AsyncSnapshot<List<Genre>> snapshot) {
    if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
      return CustomCheckBoxList(
        type: CheckBoxListType.grid,
        children: snapshot.data!.map((e) => e.name!).toList(),
        selectedItems: getSelectedGenres(snapshot.data!),
        onSelectionChanged: (values) {
          discover.genres
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
    return SizedBox(
      width: ScreenSize.getPercentOfWidth(context, 0.1),
      child: Center(child: CircularProgressIndicator()),
    );
  }

  void onSubmitClick(BuildContext context) {
    if (discover.certification == null &&
        (discover.sortMoviesBy == null && discover.sortTvBy == null) &&
        discover.releaseDateRange == null &&
        discover.voteAverage == null &&
        discover.genres.isEmpty &&
        discover.languages.isEmpty) {
      return;
    }
    Navigator.pop(context, discover);
  }

  void onResetClick(BuildContext context) {
    Navigator.pop(context, -1);
  }

  RangeValues getDefaultYearValues() {
    if (discover.releaseDateRange != null) {
      return RangeValues(
        discover.releaseDateRange!.start.year.toDouble(),
        discover.releaseDateRange!.end.year.toDouble(),
      );
    }
    return RangeValues(
      DateTime.now().year - 100,
      DateTime.now().year.toDouble(),
    );
  }

  RangeValues getDefaultVoteAverage() {
    if (discover.voteAverage != null) {
      return RangeValues(
        discover.voteAverage!.start,
        discover.voteAverage!.end,
      );
    }
    return RangeValues(0, 10);
  }

  List<int> getSelectedGenres(List<Genre> list) {
    List<int> indexes = [];
    for (Genre genre in discover.genres) {
      if (list.contains(genre)) {
        indexes.add(list.indexOf(genre));
      }
    }
    return indexes;
  }

  List<int> getSelectedLanguages(List<Languages> list) {
    List<int> indexes = [];
    for (var element in discover.languages) {
      if (list.contains(element)) {
        indexes.add(list.indexOf(element));
      }
    }
    return indexes;
  }

  int? getSelectedCertification(List<String> list) {
    if (discover.certification != null &&
        list.contains(discover.certification)) {
      return list.indexOf(discover.certification!);
    }
    return null;
  }

  int? getSelectedSortBy() {
    if (type == EntityType.movie) {
      switch (discover.sortMoviesBy) {
        case SortMoviesBy.popularity:
          return POPULARITY_INDEX;
        case SortMoviesBy.voteAverage:
          return VOTE_AVERAGE_INDEX;
        case SortMoviesBy.releaseDate:
          return DATE_INDEX;
        default:
          return null;
      }
    } else if (type == EntityType.tv) {
      switch (discover.sortTvBy) {
        case SortTvBy.popularity:
          return POPULARITY_INDEX;
        case SortTvBy.voteAverage:
          return VOTE_AVERAGE_INDEX;
        case SortTvBy.firstAirDate:
          return DATE_INDEX;
        default:
          return null;
      }
    }
    return null;
  }

  int? getIndexOfSelectedSort() {
    switch (discover.sortMoviesBy) {
      case SortMoviesBy.popularity:
        return POPULARITY_INDEX;
      case SortMoviesBy.voteAverage:
        return VOTE_AVERAGE_INDEX;
      case SortMoviesBy.releaseDate:
        return DATE_INDEX;
      default:
        return null;
    }
  }
}
