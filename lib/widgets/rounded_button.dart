import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final void Function()? onPressed;
  final Widget child;
  final RoundedButtonType type;

  const RoundedButton({
    Key? key,
    required this.child,
    required this.onPressed,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (type == RoundedButtonType.filled) {
      return ElevatedButton(
        onPressed: onPressed,
        child: child,
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
      );
    } else if (type == RoundedButtonType.outlined) {
      return OutlinedButton(
        onPressed: onPressed,
        child: child,
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
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
