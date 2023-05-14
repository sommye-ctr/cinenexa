import 'package:cinenexa/utils/keycode.dart';
import 'package:cinenexa/widgets/tv_onscreen_keyboard_key.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TvOnScreenKeyboard extends StatefulWidget {
  final VoidCallback? onExitRight;
  const TvOnScreenKeyboard({this.onExitRight, Key? key}) : super(key: key);

  @override
  State<TvOnScreenKeyboard> createState() => _TvOnScreenKeyboardState();
}

class _TvOnScreenKeyboardState extends State<TvOnScreenKeyboard> {
  final FocusNode focus = FocusNode();
  int index = 0;

  final List<Widget> keys = [];

  @override
  Widget build(BuildContext context) {
    focus.requestFocus();

    return RawKeyboardListener(
      focusNode: focus,
      onKey: (event) {
        if (!(event is RawKeyDownEvent)) {
          return;
        }
        RawKeyEventDataAndroid rawKeyEventData =
            event.data as RawKeyEventDataAndroid;

        switch (rawKeyEventData.keyCode) {
          case KEY_DOWN:
            index += 6;
            keys[index] = TvOnScreenKeyboardKey(
              child: keys[index],
              isFocused: true,
            );
            setState(() {});
            break;
          case KEY_UP:
          default:
        }
      },
      child: Container(
        width: 23 * 6,
        child: Column(
          children: _buildColumns(),
        ),
      ),
    );
  }

  List<Widget> _buildColumns() {
    return [
      Row(
        children: keys.sublist(0, 6),
      ),
      Row(
        children: keys.sublist(6, 12),
      ),
      Row(
        children: keys.sublist(12, 18),
      ),
      Row(
        children: keys.sublist(18, 24),
      ),
      Row(
        children: keys.sublist(24, 30),
      ),
      Row(
        children: keys.sublist(30, 36),
      ),
      Row(
        children: [
          TvOnScreenKeyboardKey(
            child: Icon(Icons.space_bar_rounded),
            width: 48 * 3,
          ),
          TvOnScreenKeyboardKey(
            child: Icon(Icons.backspace_rounded),
            width: 48 * 3,
          )
        ],
      ),
    ];
  }

  @override
  void initState() {
    keys.addAll([
      TvOnScreenKeyboardKey(
        child: Text("a"),
        isFocused: true,
      ),
      TvOnScreenKeyboardKey(
        child: Text("b"),
      ),
      TvOnScreenKeyboardKey(
        child: Text("c"),
      ),
      TvOnScreenKeyboardKey(
        child: Text("d"),
      ),
      TvOnScreenKeyboardKey(
        child: Text("e"),
      ),
      TvOnScreenKeyboardKey(
        child: Text("f"),
      ),
      TvOnScreenKeyboardKey(
        child: Text("g"),
      ),
      TvOnScreenKeyboardKey(
        child: Text("h"),
      ),
      TvOnScreenKeyboardKey(
        child: Text("i"),
      ),
      TvOnScreenKeyboardKey(
        child: Text("j"),
      ),
      TvOnScreenKeyboardKey(
        child: Text("k"),
      ),
      TvOnScreenKeyboardKey(
        child: Text("l"),
      ),
      TvOnScreenKeyboardKey(
        child: Text("m"),
      ),
      TvOnScreenKeyboardKey(
        child: Text("n"),
      ),
      TvOnScreenKeyboardKey(
        child: Text("o"),
      ),
      TvOnScreenKeyboardKey(
        child: Text("p"),
      ),
      TvOnScreenKeyboardKey(
        child: Text("q"),
      ),
      TvOnScreenKeyboardKey(
        child: Text("r"),
      ),
      TvOnScreenKeyboardKey(
        child: Text("s"),
      ),
      TvOnScreenKeyboardKey(
        child: Text("t"),
      ),
      TvOnScreenKeyboardKey(
        child: Text("u"),
      ),
      TvOnScreenKeyboardKey(
        child: Text("v"),
      ),
      TvOnScreenKeyboardKey(
        child: Text("w"),
      ),
      TvOnScreenKeyboardKey(
        child: Text("x"),
      ),
      TvOnScreenKeyboardKey(
        child: Text("y"),
      ),
      TvOnScreenKeyboardKey(
        child: Text("z"),
      ),
      TvOnScreenKeyboardKey(
        child: Text("1"),
      ),
      TvOnScreenKeyboardKey(
        child: Text("2"),
      ),
      TvOnScreenKeyboardKey(
        child: Text("3"),
      ),
      TvOnScreenKeyboardKey(
        child: Text("4"),
      ),
      TvOnScreenKeyboardKey(
        child: Text("5"),
      ),
      TvOnScreenKeyboardKey(
        child: Text("6"),
      ),
      TvOnScreenKeyboardKey(
        child: Text("7"),
      ),
      TvOnScreenKeyboardKey(
        child: Text("8"),
      ),
      TvOnScreenKeyboardKey(
        child: Text("9"),
      ),
      TvOnScreenKeyboardKey(
        child: Text("0"),
      ),
    ]);
    super.initState();
  }
}
