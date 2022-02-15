import 'package:flutter/material.dart';

class CustomCheckBox extends StatefulWidget {
  final String text;
  final Function()? onSelected;

  bool selectable;
  bool isSelected = false;

  CustomCheckBox({
    Key? key,
    required this.text,
    required this.selectable,
    this.onSelected,
  }) : super(key: key);

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
        if (widget.selectable) {
          setState(() {
            widget.isSelected = !widget.isSelected;
          });
          if (widget.onSelected != null) {
            widget.onSelected!();
          }
        }
      },
      child: Ink(
        decoration: BoxDecoration(
          color: widget.isSelected
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
      ),
    );
  }
}
