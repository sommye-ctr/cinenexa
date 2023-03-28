import 'package:flutter/material.dart';

import '../resources/style.dart';

class RoundedButton extends StatelessWidget {
  final void Function()? onPressed;
  final Widget child;
  final RoundedButtonType type;
  final FocusNode? focusNode;

  const RoundedButton({
    Key? key,
    required this.child,
    required this.onPressed,
    required this.type,
    this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (type == RoundedButtonType.filled) {
      return ElevatedButton(
        onPressed: onPressed,
        child: child,
        focusNode: focusNode,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Style.largeRoundEdgeRadius),
          ),
        ),
      );
    } else if (type == RoundedButtonType.outlined) {
      return OutlinedButton(
        onPressed: onPressed,
        child: child,
        focusNode: focusNode,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Style.largeRoundEdgeRadius),
          ),
        ),
      );
    }
    throw FlutterError("Invalid button type");
  }
}

enum RoundedButtonType {
  filled,
  outlined,
}
