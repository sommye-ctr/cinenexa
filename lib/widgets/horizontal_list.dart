import 'package:flutter/material.dart';
import 'package:watrix/resources/style.dart';
import 'package:watrix/services/constants.dart';
import 'package:watrix/services/network/utils.dart';
import 'package:watrix/utils/screen_size.dart';
import 'package:watrix/components/movie_tile.dart';
import 'package:watrix/widgets/rounded_image_placeholder.dart';

import '../models/network/base_model.dart';

class HorizontalList extends StatefulWidget {
  Future<List<BaseModel>>? future;
  int? limitItems;

  List<BaseModel>? items;
  final String heading;
  final Function(BaseModel data) onClick;
  final Function(List<BaseModel> items)? onRightTrailClicked;
  final double itemWidthPercent;
  final bool showTitle;

  HorizontalList({
    Key? key,
    required this.future,
    required this.heading,
    required this.onClick,
    required this.itemWidthPercent,
    required this.showTitle,
    this.onRightTrailClicked,
  }) : super(key: key);

  HorizontalList.fromInititalValues({
    Key? key,
    required this.items,
    required this.heading,
    required this.onClick,
    required this.itemWidthPercent,
    required this.showTitle,
    this.onRightTrailClicked,
    this.limitItems,
  }) : super(key: key);

  @override
  State<HorizontalList> createState() => _HorizontalListState();
}

class _HorizontalListState extends State<HorizontalList> {
  late List<BaseModel> items = widget.items ?? [];

  @override
  void initState() {
    if (widget.future != null) {
      _fetchItems();
    }
    super.initState();
  }

  void _fetchItems() async {
    items.addAll(await widget.future!);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.heading,
              style: Style.headingStyle,
            ),
            if (_showRightTrail())
              IconButton(
                onPressed: () {
                  if (widget.onRightTrailClicked != null)
                    widget.onRightTrailClicked!(items);
                },
                icon: Icon(
                  Icons.keyboard_arrow_right_rounded,
                ),
              ),
          ],
        ),
        SizedBox(
          height: 4,
        ),
        _buildContent(),
      ],
    );
  }

  Widget _buildContent() {
    if (items.isNotEmpty) {
      return _buildWidgetList(
        (context, index) {
          BaseModel item = items[index];
          return MovieTile(
            image: Utils.getPosterUrl(item.posterPath ?? ""),
            text: item.title!,
            width:
                ScreenSize.getPercentOfWidth(context, widget.itemWidthPercent),
            showTitle: widget.showTitle,
            onClick: () {
              widget.onClick(item);
            },
          );
        },
        _getLength(),
      );
    }
    return _buildWidgetList(
      (context, index) {
        return RoundedImagePlaceholder(
          width: ScreenSize.getPercentOfWidth(context, widget.itemWidthPercent),
          ratio: Constants.posterAspectRatio,
        );
      },
      Constants.placeHolderListLimit,
    );
  }

  int _getLength() {
    if (widget.limitItems == null) return items.length;
    if (widget.limitItems! <= items.length) {
      return widget.limitItems!;
    }
    return items.length;
  }

  bool _showRightTrail() {
    if (widget.onRightTrailClicked == null) return false;
    if (widget.limitItems == null) return true;
    if (items.length >= widget.limitItems!) return true;
    return false;
  }

  Widget _buildWidgetList(
    Widget Function(BuildContext context, int index) builder,
    int count,
  ) {
    double height =
        ScreenSize.getPercentOfWidth(context, widget.itemWidthPercent) /
            Constants.posterAspectRatio;
    if (widget.showTitle) {
      height += ScreenSize.getPercentOfHeight(context, 0.04);
    }
    return Container(
      height: height,
      child: ListView.separated(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) {
          return SizedBox(
            width: 5,
          );
        },
        itemCount: count,
        itemBuilder: builder,
      ),
    );
  }
}
