import 'package:flutter/material.dart';
import 'package:watrix/utils/screen_size.dart';
import 'package:watrix/widgets/custom_checkbox.dart';

enum CheckBoxListType {
  list,
  grid,
}

class CustomCheckBoxList extends StatefulWidget {
  final List<String> children;
  final CheckBoxListType type;
  final SliverGridDelegate? delegate;
  final bool singleSelect, alwaysEnabled;
  final Function(List<String> values)? onSelectionChanged;
  final Function(List<String> values)? onSelectionAdded;
  final Function(List<String> values)? onSelectionRemoved;

  final List<int>? selectedItems;
  final List<String>? tooltips;

  const CustomCheckBoxList({
    Key? key,
    required this.children,
    required this.type,
    this.onSelectionChanged,
    this.singleSelect = false,
    this.alwaysEnabled = false,
    this.delegate,
    this.selectedItems,
    this.onSelectionAdded,
    this.onSelectionRemoved,
    this.tooltips,
  }) : super(key: key);

  @override
  State<CustomCheckBoxList> createState() => _CustomCheckBoxListState();
}

class _CustomCheckBoxListState extends State<CustomCheckBoxList> {
  late List<ValueNotifier<bool>> notifiers;
  List<String> selectedItems = [];

  @override
  void initState() {
    super.initState();
    notifiers = createNotifiers();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.type == CheckBoxListType.list) {
      return Container(
        height: 50,
        child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: widget.children.length,
          physics: BouncingScrollPhysics(),
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(
              width: ScreenSize.getPercentOfWidth(
                context,
                0.025,
              ),
            );
          },
          itemBuilder: (BuildContext context, int index) {
            return widget.tooltips != null
                ? Tooltip(
                    message: widget.tooltips?[index],
                    child: customCheckBox(index),
                  )
                : customCheckBox(index);
          },
        ),
      );
    } else if (widget.type == CheckBoxListType.grid) {
      return GridView.builder(
        shrinkWrap: true,
        itemCount: widget.children.length,
        physics: BouncingScrollPhysics(),
        gridDelegate: widget.delegate!,
        itemBuilder: (context, index) {
          return widget.tooltips != null
              ? Tooltip(
                  message: widget.tooltips?[index],
                  child: customCheckBox(index),
                )
              : customCheckBox(index);
        },
      );
    }
    throw UnimplementedError();
  }

  CustomCheckBox customCheckBox(int index) {
    return CustomCheckBox(
      text: widget.children[index],
      controller: notifiers[index],
      onSelected: () {
        onSelectChanged(index);
      },
    );
  }

  List<ValueNotifier<bool>> createNotifiers() {
    List<ValueNotifier<bool>> valueNotifiers = [];
    for (int i = 0; i < widget.children.length; i++) {
      bool value = false;
      if (widget.selectedItems != null && widget.selectedItems!.contains(i)) {
        value = true;
        selectedItems.add(widget.children[i]);
      }
      valueNotifiers.add(ValueNotifier(value));
    }
    return valueNotifiers;
  }

  void clearSelection(int except) {
    for (int i = 0; i < notifiers.length; i++) {
      if (i != except) {
        notifiers[i].value = false;
      }
    }
  }

  void onSelectChanged(int index) {
    if (widget.singleSelect) {
      clearSelection(index);
    }
    if (!selectedItems.contains(widget.children[index])) {
      if (widget.singleSelect) {
        selectedItems.clear();
      }
      selectedItems.add(widget.children[index]);
      widget.onSelectionAdded?.call(selectedItems);
    } else {
      if (!widget.alwaysEnabled) {
        selectedItems.remove(widget.children[index]);
        widget.onSelectionRemoved?.call(selectedItems);
      } else {
        notifiers[index].value = true;
      }
    }
    widget.onSelectionChanged?.call(selectedItems);
  }
}
