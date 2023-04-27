// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../resources/style.dart';

class RoundedButton extends StatefulWidget {
  final void Function()? onPressed;
  final Widget child;
  final FocusNode? focusNode;
  final RoundedButtonType type;

  final RoundedButtonController? controller;

  RoundedButton({
    Key? key,
    required this.child,
    required this.onPressed,
    required this.type,
    this.focusNode,
  })  : controller = null,
        super(key: key);

  RoundedButton.controller({
    Key? key,
    required this.child,
    required this.onPressed,
    required this.controller,
    this.focusNode,
  })  : type = controller!.type,
        super(key: key);

  @override
  State<RoundedButton> createState() => _RoundedButtonState();
}

class _RoundedButtonState extends State<RoundedButton> {
  @override
  void initState() {
    widget.controller?.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    RoundedButtonType type =
        widget.controller != null ? widget.controller!.type : widget.type;

    var rounded = ElevatedButton(
      onPressed: widget.onPressed,
      child: widget.child,
      focusNode: widget.focusNode,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Style.largeRoundEdgeRadius),
        ),
      ),
    );
    var outlined = OutlinedButton(
      onPressed: widget.onPressed,
      child: widget.child,
      focusNode: widget.focusNode,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Style.largeRoundEdgeRadius),
        ),
      ),
    );

    if (type == RoundedButtonType.filled) {
      return rounded;
    } else if (type == RoundedButtonType.outlined) {
      return outlined;
    }
    throw FlutterError("Invalid button type");
  }
}

class RoundedButtonController extends ChangeNotifier {
  RoundedButtonType type;
  RoundedButtonController({
    required this.type,
  });

  void changeType(RoundedButtonType newType) {
    type = newType;
    notifyListeners();
  }
}

enum RoundedButtonType {
  filled,
  outlined,
}
