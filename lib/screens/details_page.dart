import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:watrix/components/details_page_header.dart';

import 'package:watrix/components/vote_indicator.dart';
import 'package:watrix/models/base_model.dart';
import 'package:watrix/models/genre.dart';
import 'package:watrix/resources/strings.dart';
import 'package:watrix/resources/style.dart';
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
  final _controller = ScrollController();

  double get maxHeight => ScreenSize.getPercentOfHeight(context, 1);

  double get minHeight => MediaQuery.of(context).padding.top + kToolbarHeight;

  @override
  void initState() {
    detailsStore = DetailsStore(baseModel: widget.baseModel);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: NotificationListener<ScrollEndNotification>(
          onNotification: (_) {
            _snapBehaviour();
            return false;
          },
          child: CustomScrollView(
            controller: _controller,
            physics: BouncingScrollPhysics(),
            slivers: [
              SliverPersistentHeader(
                pinned: true,
                floating: true,
                delegate: DetailsPageHeader(
                  maxHeight: maxHeight,
                  minHeight: minHeight,
                  page1store: detailsStore.page1,
                  overview: detailsStore.baseModel.overview ?? "",
                  voteAverage: detailsStore.baseModel.voteAverage ?? 0,
                  title: detailsStore.baseModel.title ?? "",
                  poster: detailsStore.baseModel.posterPath ?? "",
                ),
              ),
              SliverToBoxAdapter(
                child: Observer(builder: (_) {
                  if (detailsStore.credits.isNotEmpty ||
                      detailsStore.recommendedMovies.isNotEmpty) {
                    return _AdditionalDetails(
                      cast: detailsStore.credits,
                      recommended: detailsStore.recommendedMovies,
                      genres: detailsStore.page1.genres,
                    );
                  }
                  return Container();
                }),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _snapBehaviour() {
    final double distance = maxHeight - minHeight;
    if (_controller.offset > 0 && _controller.offset < distance) {
      final double snapOffset =
          _controller.offset / distance > 0.4 ? distance : 0;

      Future.microtask(() => _controller.animateTo(snapOffset,
          duration: Duration(milliseconds: 200), curve: Curves.easeIn));
    }
  }
}

class _AdditionalDetails extends StatelessWidget {
  final List<BaseModel> cast;
  final List<BaseModel> recommended;
  final List<Genre> genres;
  const _AdditionalDetails({
    Key? key,
    required this.cast,
    required this.recommended,
    required this.genres,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: ScreenSize.getPercentOfHeight(context, 1),
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  _buildGenres(context),
                  _buildSpacing(context),
                  _buildList(Strings.cast, context, cast),
                  _buildSpacing(context),
                  _buildList(Strings.recommendedMovies, context, recommended)
                ],
              )),
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

  Widget _buildGenres(context) {
    List<Widget> widgets = [];
    for (var item in genres) {
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
        alignment: WrapAlignment.center,
        runSpacing: ScreenSize.getPercentOfWidth(context, 0.01),
        children: widgets,
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
                heading: heading,
                isLazyLoad: false,
              ),
            );
          },
        );
      },
    );
  }
}
