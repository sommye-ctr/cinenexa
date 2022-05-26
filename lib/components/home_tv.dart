import 'package:flutter/material.dart';

import '../models/base_model.dart';
import '../resources/strings.dart';
import '../services/duration_type.dart';
import '../services/entity_type.dart';
import '../services/requests.dart';
import '../utils/screen_size.dart';
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
        HorizontalList(
          future: Requests.titlesFuture(
              Requests.trending(EntityType.tv, DurationType.day)),
          heading: Strings.trendingToday,
          onClick: (data) => widget.onItemClicked(data),
          itemWidthPercent: 0.3,
          showTitle: true,
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
        SizedBox(
          height: ScreenSize.getPercentOfHeight(
            context,
            0.02,
          ),
        ),
        HorizontalList(
          future: Requests.titlesFuture(Requests.topRated(EntityType.tv)),
          heading: Strings.topRated,
          onClick: (data) => widget.onItemClicked(data),
          itemWidthPercent: 0.3,
          showTitle: true,
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
        SizedBox(
          height: ScreenSize.getPercentOfHeight(
            context,
            0.02,
          ),
        ),
        HorizontalList(
          future: Requests.titlesFuture(Requests.popular(EntityType.tv)),
          heading: Strings.popular,
          onClick: (data) => widget.onItemClicked(data),
          itemWidthPercent: 0.3,
          showTitle: true,
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
        SizedBox(
          height: ScreenSize.getPercentOfHeight(
            context,
            0.02,
          ),
        ),
        HorizontalList(
          future: Requests.titlesFuture(
              Requests.trending(EntityType.tv, DurationType.week)),
          heading: Strings.trendingThisWeek,
          onClick: (data) => widget.onItemClicked(data),
          itemWidthPercent: 0.3,
          showTitle: true,
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
        SizedBox(
          height: ScreenSize.getPercentOfHeight(
            context,
            0.02,
          ),
        ),
      ],
    );
  }
}
