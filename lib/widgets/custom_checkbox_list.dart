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
  final bool singleSelect;
  const CustomCheckBoxList({
    Key? key,
    required this.children,
    required this.type,
    this.singleSelect = false,
    this.delegate,
  }) : super(key: key);

  @override
  State<CustomCheckBoxList> createState() => _CustomCheckBoxListState();
}

class _CustomCheckBoxListState extends State<CustomCheckBoxList> {
  late List<ValueNotifier<bool>> notifiers;

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
            return CustomCheckBox(
              text: widget.children[index],
              controller: notifiers[index],
              onSelected: () {
                print("selected is $index");
                if (widget.singleSelect) {
                  clearSelection(index);
                }
                print("is selected ${notifiers[index].value}");
              },
            );
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
          return CustomCheckBox(
            text: widget.children[index],
            onSelected: () {
              if (widget.singleSelect) {
                clearSelection(index);
              }
            },
          );
        },
      );
    }
    throw new FlutterError("Unidentified type!");
  }

  List<ValueNotifier<bool>> createNotifiers() {
    List<ValueNotifier<bool>> valueNotifiers = [];
    // ignore: unused_local_variable
    for (var ignore in widget.children) {
      valueNotifiers.add(ValueNotifier(false));
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
}
