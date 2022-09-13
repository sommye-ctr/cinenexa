import 'package:flutter/material.dart';
import 'package:watrix/services/network/repository.dart';

import '../models/network/base_model.dart';
import '../resources/strings.dart';
import '../models/network/enums/duration_type.dart';
import '../models/network/enums/entity_type.dart';
import '../resources/style.dart';
import '../services/network/requests.dart';
import '../widgets/horizontal_list.dart';

class HomeTv extends StatefulWidget {
  final Function(BaseModel data) onItemClicked;
  final Function(String future, List<BaseModel> items, String heading)?
      onSeeMoreClicked;

  const HomeTv({
    Key? key,
    required this.onItemClicked,
    this.onSeeMoreClicked,
  }) : super(key: key);

  @override
  State<HomeTv> createState() => _HomeTvState();
}

class _HomeTvState extends State<HomeTv> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView(
      physics: BouncingScrollPhysics(),
      children: [
        HorizontalList<BaseModel>(
          future: Repository.getTitles(
              Requests.trending(EntityType.tv, DurationType.day)),
          heading: Strings.trendingToday,
          buildPlaceHolder: () => Style.getMovieTilePlaceHolder(
              context: context, widthPercent: 0.3),
          buildWidget: (item) => Style.getMovieTile(
            item: item,
            widhtPercent: 0.3,
            showTitle: false,
            context: context,
            onClick: widget.onItemClicked,
          ),
          height: Style.getMovieTileHeight(context: context, widthPercent: 0.3),
          onRightTrailClicked: (items) {
            if (widget.onSeeMoreClicked != null) {
              widget.onSeeMoreClicked!(
                Requests.trending(EntityType.tv, DurationType.day),
                items,
                Strings.trendingToday,
              );
            }
          },
        ),
        Style.getVerticalSpacing(context: context),
        HorizontalList<BaseModel>(
          future: Repository.getTitles(Requests.topRated(EntityType.tv)),
          heading: Strings.topRated,
          buildPlaceHolder: () => Style.getMovieTilePlaceHolder(
              context: context, widthPercent: 0.3),
          buildWidget: (item) => Style.getMovieTile(
            item: item,
            widhtPercent: 0.3,
            showTitle: false,
            context: context,
            onClick: widget.onItemClicked,
          ),
          height: Style.getMovieTileHeight(context: context, widthPercent: 0.3),
          onRightTrailClicked: (items) {
            if (widget.onSeeMoreClicked != null) {
              widget.onSeeMoreClicked!(
                Requests.topRated(EntityType.tv),
                items,
                Strings.topRated,
              );
            }
          },
        ),
        Style.getVerticalSpacing(context: context),
        HorizontalList<BaseModel>(
          future: Repository.getTitles(Requests.popular(EntityType.tv)),
          heading: Strings.popular,
          buildPlaceHolder: () => Style.getMovieTilePlaceHolder(
              context: context, widthPercent: 0.3),
          buildWidget: (item) => Style.getMovieTile(
            item: item,
            widhtPercent: 0.3,
            showTitle: false,
            context: context,
            onClick: widget.onItemClicked,
          ),
          height: Style.getMovieTileHeight(context: context, widthPercent: 0.3),
          onRightTrailClicked: (items) {
            if (widget.onSeeMoreClicked != null) {
              widget.onSeeMoreClicked!(
                Requests.popular(EntityType.tv),
                items,
                Strings.popular,
              );
            }
          },
        ),
        Style.getVerticalSpacing(context: context),
        HorizontalList<BaseModel>(
          future: Repository.getTitles(
              Requests.trending(EntityType.tv, DurationType.week)),
          heading: Strings.trendingThisWeek,
          buildPlaceHolder: () => Style.getMovieTilePlaceHolder(
              context: context, widthPercent: 0.3),
          buildWidget: (item) => Style.getMovieTile(
            item: item,
            widhtPercent: 0.3,
            showTitle: false,
            context: context,
            onClick: widget.onItemClicked,
          ),
          height: Style.getMovieTileHeight(context: context, widthPercent: 0.3),
          onRightTrailClicked: (items) {
            if (widget.onSeeMoreClicked != null) {
              widget.onSeeMoreClicked!(
                Requests.trending(EntityType.tv, DurationType.week),
                items,
                Strings.trendingThisWeek,
              );
            }
          },
        ),
        Style.getVerticalSpacing(
          context: context,
          percent: 0.08,
        ),
      ],
    );
  }
}
