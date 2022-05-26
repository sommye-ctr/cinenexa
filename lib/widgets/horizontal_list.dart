import 'package:flutter/material.dart';
import 'package:watrix/models/base_model.dart';
import 'package:watrix/resources/style.dart';
import 'package:watrix/services/constants.dart';
import 'package:watrix/services/utils.dart';
import 'package:watrix/utils/screen_size.dart';
import 'package:watrix/components/movie_tile.dart';
import 'package:watrix/widgets/rounded_image_placeholder.dart';

class HorizontalList extends StatefulWidget {
  final Future<List<BaseModel>> future;
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

  @override
  State<HorizontalList> createState() => _HorizontalListState();
}

class _HorizontalListState extends State<HorizontalList> {
  List<BaseModel> items = [];

  @override
  void initState() {
    _fetchItems();
    super.initState();
  }

  void _fetchItems() async {
    items.addAll(await widget.future);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.heading,
              style: Style.headingStyle,
            ),
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
        items.length,
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
