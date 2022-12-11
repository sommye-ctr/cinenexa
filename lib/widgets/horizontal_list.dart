import 'package:flutter/material.dart';
import 'package:watrix/resources/style.dart';
import 'package:watrix/services/constants.dart';

class HorizontalList<T> extends StatefulWidget {
  final Future<List<T>>? future;
  final int? limitItems;
  final List<T>? items;

  final String heading;
  final Function(List<T> items)? onRightTrailClicked;
  final Widget Function(T item) buildWidget;
  final Widget Function() buildPlaceHolder;
  final double height;

  HorizontalList({
    Key? key,
    required this.future,
    required this.heading,
    required this.buildWidget,
    required this.buildPlaceHolder,
    required this.height,
    this.onRightTrailClicked,
  })  : limitItems = null,
        items = null,
        super(key: key);

  HorizontalList.fromInititalValues({
    Key? key,
    required this.items,
    required this.heading,
    required this.buildWidget,
    required this.buildPlaceHolder,
    required this.height,
    this.onRightTrailClicked,
    this.limitItems,
  })  : future = null,
        super(key: key);

  @override
  State<HorizontalList<T>> createState() => _HorizontalListState<T>();
}

class _HorizontalListState<T> extends State<HorizontalList<T>> {
  late List<T> items = widget.items ?? [];

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
    if (widget.future == null && items.isEmpty) {
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
    if (items.isEmpty) {
      return _buildList(
        (context, index) {
          return widget.buildPlaceHolder();
        },
        Constants.placeHolderListLimit,
      );
    }
    return _buildList(
      (context, index) {
        return widget.buildWidget(items[index]);
      },
      _getLength(),
    );
  }

  Widget _buildList(
    Widget Function(BuildContext context, int index) builder,
    int count,
  ) {
    return Container(
      height: widget.height,
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
}
