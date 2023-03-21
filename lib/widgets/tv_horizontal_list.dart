import 'package:cinenexa/models/network/base_model.dart';
import 'package:cinenexa/store/tv_list/tv_list_store.dart';
import 'package:flutter/material.dart';
import 'package:cinenexa/resources/style.dart';
import 'package:cinenexa/services/constants.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../resources/custom_scroll_behavior.dart';

class TvHorizontalList<T> extends StatefulWidget {
  final int? limitItems;
  final String heading;
  final Function(List<T> items)? onRightTrailClicked;
  final double height;
  final double widthPercentItem;
  final TvListStore<T> tvListStore;

  TvHorizontalList({
    Key? key,
    required this.heading,
    required this.height,
    required this.widthPercentItem,
    required this.tvListStore,
    this.onRightTrailClicked,
  })  : limitItems = null,
        super(key: key);

  TvHorizontalList.fromInititalValues({
    Key? key,
    required this.heading,
    required this.height,
    this.onRightTrailClicked,
    required this.widthPercentItem,
    required this.tvListStore,
    this.limitItems,
  }) : super(key: key);

  @override
  State<TvHorizontalList<T>> createState() => _TvHorizontalListState<T>();
}

class _TvHorizontalListState<T> extends State<TvHorizontalList<T>> {
  late final ItemScrollController scrollController;

  @override
  void initState() {
    scrollController = ItemScrollController();
    widget.tvListStore.setScrollController(scrollController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        widget.tvListStore.items;
        if (widget.tvListStore.items == null ||
            (widget.tvListStore.items?.isEmpty ?? true)) {
          return Container();
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
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
                        widget.onRightTrailClicked!(widget.tvListStore.items!);
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
      },
    );
  }

  Widget _buildContent() {
    if (widget.tvListStore.items!.isEmpty) {
      return _buildList(
        (context, index) {
          return Style.getMovieTileBackdropPlaceHolder(
            context: context,
            widthPercent: widget.widthPercentItem,
          );
        },
        Constants.placeHolderListLimit,
      );
    }
    return Observer(
      builder: (context) {
        widget.tvListStore.focusedIndex;
        widget.tvListStore.items;
        widget.tvListStore.isListFocused;

        return _buildList(
          (context, index) {
            return Style.getTvMovieTile(
              item: widget.tvListStore.items![index] as BaseModel,
              widhtPercent: widget.widthPercentItem,
              showTitle: false,
              context: context,
              onClick: (baseModel) {},
              scale: widget.tvListStore.isListFocused &&
                      widget.tvListStore.focusedIndex == index
                  ? 1
                  : 0.9,
            );
          },
          _getLength(),
        );
      },
    );
  }

  Widget _buildList(
    Widget Function(BuildContext context, int index) builder,
    int count,
  ) {
    return Container(
      height: widget.height,
      child: ScrollConfiguration(
        behavior: CustomScrollBehavior(),
        child: ScrollablePositionedList.separated(
          itemScrollController: scrollController,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          separatorBuilder: (context, index) {
            return SizedBox(
              width: 8,
            );
          },

          itemCount: count,
          itemBuilder: builder,
        ),
      ),
    );
  }

  int _getLength() {
    if (widget.limitItems == null) return widget.tvListStore.items!.length;
    if (widget.limitItems! <= widget.tvListStore.items!.length) {
      return widget.limitItems!;
    }
    return widget.tvListStore.items!.length;
  }

  bool _showRightTrail() {
    if (widget.onRightTrailClicked == null) return false;
    if (widget.limitItems == null) return true;
    if (widget.tvListStore.items!.length >= widget.limitItems!) return true;
    return false;
  }
}
