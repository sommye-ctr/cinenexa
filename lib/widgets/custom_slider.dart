import 'package:flutter/material.dart';

class CustomSlider extends StatefulWidget {
  final double value;
  final double min, max;
  final int? divisions;
  final Color? activeColor, inactiveColor;
  final Function(double value)? onChanged;
  const CustomSlider(
      {Key? key,
      required this.value,
      required this.min,
      required this.max,
      this.divisions,
      this.activeColor,
      this.inactiveColor,
      this.onChanged})
      : super(key: key);

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  @override
  Widget build(BuildContext context) {
    return Column();
  }
}
