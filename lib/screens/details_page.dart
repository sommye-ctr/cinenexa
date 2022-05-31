import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:watrix/components/vote_indicator.dart';
import 'package:watrix/models/base_model.dart';
import 'package:watrix/resources/strings.dart';
import 'package:watrix/screens/see_more_page.dart';
import 'package:watrix/services/utils.dart';
import 'package:watrix/store/details/details_page1_store.dart';
import 'package:watrix/store/details/details_store.dart';
import 'package:watrix/utils/date_time_formatter.dart';
import 'package:watrix/widgets/horizontal_list.dart';
import 'package:watrix/widgets/rounded_button.dart';
import 'package:watrix/widgets/screen_background_image.dart';

import '../utils/screen_size.dart';

class DetailsPage extends StatefulWidget {
  static const routeName = "/details";

  final BaseModel baseModel;

  DetailsPage({
    Key? key,
    required this.baseModel,
  }) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  late final DetailsStore detailsStore;

  @override
  void initState() {
    detailsStore = DetailsStore(baseModel: widget.baseModel);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            PageView(
              pageSnapping: true,
              onPageChanged: detailsStore.onPageChanged,
              scrollDirection: Axis.vertical,
              children: [
                _Page1(
                  page1store: detailsStore.page1,
                  overview: detailsStore.baseModel.overview ?? "",
                  voteAverage: detailsStore.baseModel.voteAverage ?? 0,
                  type: detailsStore.baseModel.type!,
                  title: detailsStore.baseModel.title ?? "",
                  poster: detailsStore.baseModel.posterPath ?? "",
                ),
                Observer(builder: (_) {
                  return _Page2(
                    cast: detailsStore.credits,
                    recommended: detailsStore.recommendedMovies,
                  );
                }),
              ],
            ),
            /* Align(
              alignment: Alignment.topLeft,
              child: BackButton(),
            ) */ //TODO Add back button
          ],
        ),
      ),
    );
  }
}

class _Page1 extends StatelessWidget {
  //final BaseModel baseModel;
  final DetailsPage1Store page1store;
  final String title, poster, overview;
  final double voteAverage;
  final BaseModelType type;
  //final String? runtime;
  //final String? tvShowEndTime;

  _Page1({
    Key? key,
    required this.page1store,
    required this.overview,
    required this.voteAverage,
    required this.type,
    required this.title,
    required this.poster,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenBackgroundImage(
      image: CachedNetworkImageProvider(
        Utils.getPosterUrl(
          poster,
        ),
      ),
      child: Align(
        alignment: Alignment(0, 0.7),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: ScreenSize.getPercentOfWidth(context, 0.025)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildEntityType(),
              _buildMainDetails(),
              _buildSpacing(context),
              Row(
                children: [
                  VoteIndicator(
                    vote: voteAverage,
                  ),
                  _buildSpacing(context),
                  _buildGenres(),
                ],
              ),
              _buildSpacing(context),
              Text(
                overview,
                maxLines: 15,
              ),
              _buildSpacing(context),
              _buildButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSpacing(context) {
    return SizedBox(
      height: ScreenSize.getPercentOfHeight(context, 0.01),
      width: ScreenSize.getPercentOfHeight(context, 0.01),
    );
  }

  Widget _buildEntityType() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Utils.getColorByEntity(type),
      ),
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Text(
          "${Utils.getEntityTypeBy(type)}",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  Widget _buildMainDetails() {
    return Observer(
      builder: (_) {
        return Flexible(
          child: Text.rich(
            TextSpan(
              children: [
                _buildTitle(),
                _buildReleaseInfo(),
                if (page1store.runtime != null) _buildRuntime(),
              ],
            ),
          ),
        );
      },
    );
  }

  TextSpan _buildTitle() {
    return TextSpan(
      text: title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  TextSpan _buildReleaseInfo() {
    return TextSpan(
      text: _getReleaseInfo(),
      style: TextStyle(
        color: Colors.grey.shade300,
      ),
    );
  }

  TextSpan _buildRuntime() {
    return TextSpan(
      text: " - ${DateTimeFormatter.getTimeFromMin(page1store.runtime!)}",
      style: TextStyle(
        color: Colors.grey.shade300,
      ),
    );
  }

  Widget _buildGenres() {
    return Observer(
      builder: (context) {
        List<Widget> widgets = [];
        for (var item in page1store.genres) {
          widgets.add(Padding(
            padding: EdgeInsets.only(
              right: ScreenSize.getPercentOfWidth(context, 0.01),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey.withOpacity(0.4),
              ),
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: Text(
                  "${item.name}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ));
        }

        return Flexible(
          child: Wrap(
            runSpacing: ScreenSize.getPercentOfWidth(context, 0.01),
            children: widgets,
          ),
        );
      },
    );
  }

  Widget _buildButtons(context) {
    return Row(
      children: [
        RoundedButton(
          onPressed: () {},
          child: Text(Strings.addToList),
          type: RoundedButtonType.filled,
        ),
        _buildSpacing(context),
        RoundedButton(
          onPressed: () {},
          child: Text(Strings.viewInfo),
          type: RoundedButtonType.outlined,
        ),
      ],
    );
  }

  String _getReleaseInfo() {
    int startYear =
        DateTimeFormatter.getYearFromString(page1store.releaseDate!);
    String date = " ($startYear)";
    if (page1store.tvShowEndTime != null) {
      int endYear =
          DateTimeFormatter.getYearFromString(page1store.tvShowEndTime!);
      if (startYear != endYear) {
        date = date.substring(0, date.length - 1);
        date = date +
            " - ${DateTimeFormatter.getYearFromString(page1store.tvShowEndTime!)})";
      }
    }
    return date;
  }
}

class _Page2 extends StatelessWidget {
  final List<BaseModel> cast;
  final List<BaseModel> recommended;
  const _Page2({
    Key? key,
    required this.cast,
    required this.recommended,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Container(
        color: Theme.of(context).backgroundColor,
        width: double.infinity,
        height: ScreenSize.getPercentOfHeight(context, 0.85),
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                _buildList("Cast", context, cast),
                _buildList("Recommended Movies", context, recommended)
              ],
            )),
      ),
    );
  }

  Widget _buildList(String heading, context, List<BaseModel> items) {
    return HorizontalList.fromInititalValues(
      items: items,
      heading: heading,
      onClick: (item) {},
      itemWidthPercent: 0.3,
      showTitle: true,
      limitItems: 10,
      onRightTrailClicked: (list) {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          builder: (context) {
            return FractionallySizedBox(
              heightFactor: 0.75,
              child: SeeMorePage(
                initialItems: list,
                heading: Strings.knownFor,
                isLazyLoad: false,
              ),
            );
          },
        );
      },
    );
  }
}
