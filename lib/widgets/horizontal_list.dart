import 'package:flutter/material.dart';
import 'package:watrix/models/base_model.dart';
import 'package:watrix/resources/style.dart';
import 'package:watrix/services/constants.dart';
import 'package:watrix/services/utils.dart';
import 'package:watrix/utils/screen_size.dart';
import 'package:watrix/components/movie_tile.dart';
import 'package:watrix/widgets/rounded_image_placeholder.dart';

class HorizontalList extends StatefulWidget {
  Future<List<BaseModel>>? future;
  int? limitItems;

  List<BaseModel> items = [];
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
  @override
  void initState() {
    if (widget.future != null) {
      _fetchItems();
    }
    super.initState();
  }

  void _fetchItems() async {
    widget.items.addAll(await widget.future!);
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
            if (widget.onRightTrailClicked != null)
              IconButton(
                onPressed: () {
                  if (widget.onRightTrailClicked != null)
                    widget.onRightTrailClicked!(widget.items);
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
    if (widget.items.isNotEmpty) {
      return _buildWidgetList(
        (context, index) {
          BaseModel item = widget.items[index];
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
    if (widget.limitItems == null) return widget.items.length;
    if (widget.limitItems! <= widget.items.length) {
      return widget.limitItems!;
    }
    return widget.items.length;
  }

  Widget _buildWidgetList(
    Widget Function(BuildContext context, int index) builder,
    int count,
  ) {
    return Container(
      height: ScreenSize.getPercentOfWidth(context, widget.itemWidthPercent) /
              Constants.posterAspectRatio +
          ScreenSize.getPercentOfHeight(
            context,
            0.03,
          ),
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
