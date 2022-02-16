import 'package:flutter/material.dart';

class CustomCheckBox extends StatefulWidget {
  final String text;
  final Function()? onSelected;
  ValueNotifier<bool> controller;

  CustomCheckBox({
    Key? key,
    required this.text,
    this.onSelected,
    ValueNotifier<bool>? controller,
  })  : controller = controller ?? ValueNotifier(false),
        super(key: key);

  @override
  _CustomCheckBoxState createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      splashColor: Theme.of(context).colorScheme.inverseSurface,
      focusColor: Theme.of(context).colorScheme.inverseSurface,
      onTap: () {
        widget.controller.value = !widget.controller.value;

        if (widget.onSelected != null) {
          widget.onSelected!();
        }
      },
      child: ValueListenableBuilder(
        valueListenable: widget.controller,
        builder: (context, bool value, child) {
          return Ink(
            decoration: BoxDecoration(
              color: value
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Center(
                child: Text(
                  widget.text,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }
}
