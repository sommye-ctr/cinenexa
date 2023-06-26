import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

import '../../store/tv_list/tv_list_store.dart';
import '../../utils/keycode.dart';
import '../../utils/screen_size.dart';
import '../../widgets/rounded_button.dart';
import '../../widgets/tv_drawer.dart';
import '../../widgets/tv_horizontal_list.dart';

class TvDetailsDrawer<T> extends StatefulWidget {
  final List<String> leftChildren;
  final List<T> rightChildren;
  final int? initialyFocusLeft;
  final Function(int index) onLeftChildClicked;
  final Container Function(Object item) onRightWidgetBuild;

  final Function(Object item)? onRightWidgetClicked;

  const TvDetailsDrawer({
    required this.leftChildren,
    required this.rightChildren,
    required this.onLeftChildClicked,
    required this.onRightWidgetBuild,
    this.initialyFocusLeft,
    this.onRightWidgetClicked,
    Key? key,
  }) : super(key: key);

  @override
  State<TvDetailsDrawer> createState() => _TvDetailsDrawerState();
}

class _TvDetailsDrawerState<T> extends State<TvDetailsDrawer> {
  final FocusNode focus = FocusNode();
  final List<RoundedButtonController> controllers = [];
  late TvListStore<T> tvListStore;

  int yFocusLeft = 0;

  @override
  void initState() {
    for (var _ in widget.leftChildren) {
      controllers.add(RoundedButtonController(type: RoundedButtonType.text));
    }

    yFocusLeft = widget.initialyFocusLeft ?? 0;
    if (controllers.isNotEmpty)
      controllers[yFocusLeft].changeType(RoundedButtonType.filled);

    tvListStore = TvListStore<T>(
      focusChange: (item) {},
      items: widget.rightChildren.asObservable() as ObservableList<T>,
    );

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      focus.requestFocus();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: focus,
      onKey: _handleKeyboard,
      child: TvDrawer(
        leftChild: ListView.builder(
            itemCount: widget.leftChildren.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: UnconstrainedBox(
                  child: RoundedButton.controller(
                    onPressed: () {
                      widget.onLeftChildClicked(index);
                      controllers[index].changeType(RoundedButtonType.outlined);
                    },
                    controller: controllers[index],
                    child: Text(
                      widget.leftChildren[index],
                    ),
                  ),
                ),
              );
            }),
        rightChild: Observer(builder: (_) {
          if (widget.rightChildren.isEmpty) {
            return Container();
          }

          return TvHorizontalList<T>.fromInititalValues(
            heading: "",
            widthPercentItem: ScreenSize.getPercentOfWidth(context, 0.2),
            tvListStore: tvListStore,
            onWidgetBuild: (T) => widget.onRightWidgetBuild(T as Object),
            direction: Axis.vertical,
          );
        }),
      ),
    );
  }

  void _handleKeyboard(RawKeyEvent event) {
    if (!(event is RawKeyDownEvent)) {
      return;
    }
    RawKeyEventDataAndroid rawKeyEventData =
        event.data as RawKeyEventDataAndroid;

    int left = widget.leftChildren.length;
    switch (rawKeyEventData.keyCode) {
      case KEY_RIGHT:
        if (!tvListStore.isListFocused) {
          tvListStore.changeFocus(true);
          controllers[yFocusLeft].changeType(RoundedButtonType.text);
        }
        break;

      case KEY_LEFT:
        if (tvListStore.isListFocused) {
          tvListStore.changeFocus(false);
          controllers[yFocusLeft].changeType(RoundedButtonType.filled);
        }
        break;
      case KEY_DOWN:
        if (tvListStore.isListFocused) {
          tvListStore.changeIndex(KEY_RIGHT);
          return;
        }
        if (yFocusLeft != left - 1) {
          controllers[yFocusLeft].changeType(RoundedButtonType.text);
          yFocusLeft++;
          _changeSeasonConfig();
        }
        break;
      case KEY_UP:
        if (tvListStore.isListFocused) {
          tvListStore.changeIndex(KEY_LEFT);
          return;
        }
        if (yFocusLeft != 0) {
          controllers[yFocusLeft].changeType(RoundedButtonType.text);
          yFocusLeft--;
          _changeSeasonConfig();
        }
        break;
      case KEY_CENTER:
        if (tvListStore.isListFocused) {
          widget.onRightWidgetClicked
              ?.call(widget.rightChildren[tvListStore.focusedIndex]);
        }
        break;
      default:
    }
  }

  void _changeSeasonConfig() {
    controllers[yFocusLeft].changeType(RoundedButtonType.filled);
    widget.onLeftChildClicked(yFocusLeft);
  }
}
