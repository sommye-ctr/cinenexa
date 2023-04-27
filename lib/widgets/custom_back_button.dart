import 'package:flutter/material.dart';

class CustomBackButton extends StatefulWidget {
  final VoidCallback? onClick;
  final FocusNode? focusNode;
  const CustomBackButton({
    Key? key,
    this.onClick,
    this.focusNode,
  }) : super(key: key);

  @override
  State<CustomBackButton> createState() => _CustomBackButtonState();
}

class _CustomBackButtonState extends State<CustomBackButton> {
  bool focused = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(4),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: InkResponse(
          focusNode: widget.focusNode,
          onFocusChange: (value) {
            setState(() {
              focused = !focused;
            });
          },
          splashColor: Theme.of(context).colorScheme.primary,
          highlightColor: Theme.of(context).colorScheme.primary,
          focusColor: Theme.of(context).colorScheme.primary,
          onTap: () {
            widget.onClick?.call();
            Navigator.maybePop(context);
          },
          child: Container(
            color: focused
                ? Theme.of(context).colorScheme.primary
                : Colors.white.withOpacity(0.5),
            height: 50,
            width: 50,
            child: Icon(Icons.arrow_back_rounded),
          ),
        ),
      ),
    );
  }
}
