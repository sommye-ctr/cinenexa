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
  final double? height;
  final double widthPercentItem;
  final TvListStore<T> tvListStore;

  final Axis direction;

  final Widget Function(T item)? onWidgetBuild;

  TvHorizontalList({
    Key? key,
    required this.heading,
    required this.height,
    required this.widthPercentItem,
    required this.tvListStore,
    this.onWidgetBuild,
    this.direction = Axis.horizontal,
  })  : limitItems = null,
        super(key: key);

  TvHorizontalList.fromInititalValues({
    Key? key,
    required this.heading,
    required this.widthPercentItem,
    required this.tvListStore,
    this.height,
    this.limitItems,
    this.onWidgetBuild,
    this.direction = Axis.horizontal,
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
            if (widget.heading.isNotEmpty)
              Text(
                widget.heading,
                style: Style.headingStyle,
              ),
            SizedBox(
              height: 4,
            ),
            if (widget.direction == Axis.vertical)
              Expanded(child: _buildContent()),
            if (widget.direction == Axis.horizontal) _buildContent()
          ],
        );
      },
    );
  }

  Widget _buildContent() {
    if (widget.tvListStore.items!.isEmpty) {
      if (widget.onWidgetBuild == null)
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
            bool focused = widget.tvListStore.isListFocused &&
                widget.tvListStore.focusedIndex == index;

            if (widget.onWidgetBuild != null) {
              return Transform.scale(
                scale: focused ? 1 : 0.9,
                child: widget.onWidgetBuild!(widget.tvListStore.items![index]),
              );
            }
            return Style.getTvMovieTile(
              item: widget.tvListStore.items![index] as BaseModel,
              widhtPercent: widget.widthPercentItem,
              showTitle: false,
              context: context,
              onClick: (baseModel) {},
              scale: focused ? 1 : 0.9,
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
    if (widget.direction == Axis.horizontal) {
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
    return ScrollConfiguration(
      behavior: CustomScrollBehavior(),
      child: ScrollablePositionedList.separated(
        itemScrollController: scrollController,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        separatorBuilder: (context, index) {
          return Divider();
        },
        itemCount: count,
        itemBuilder: builder,
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
}
