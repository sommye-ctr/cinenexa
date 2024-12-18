import 'package:flutter/material.dart';

class CustomRangeSlider extends StatefulWidget {
  final RangeValues values;
  final double min, max;
  final int? divisions;
  final RangeLabels? labels;
  final Color? activeColor, inactiveColor;
  final Function(RangeValues rangeValues)? onChanged;

  CustomRangeSlider({
    Key? key,
    required this.values,
    required this.min,
    required this.max,
    this.onChanged,
    this.divisions,
    this.labels,
    this.activeColor,
    this.inactiveColor,
  }) : super(key: key);

  @override
  _CustomRangeSliderState createState() => _CustomRangeSliderState();
}

class _CustomRangeSliderState extends State<CustomRangeSlider> {
  late double _startValue, _endValue;

  @override
  void initState() {
    super.initState();
    _startValue = widget.values.start;
    _endValue = widget.values.end;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RangeSlider(
          values: RangeValues(_startValue, _endValue),
          min: widget.min,
          max: widget.max,
          activeColor: widget.activeColor,
          inactiveColor: widget.inactiveColor,
          labels: widget.labels,
          divisions: widget.divisions,
          onChanged: (changedValue) {
            setState(() {
              _startValue = changedValue.start;
              _endValue = changedValue.end;
            });
            if (widget.onChanged != null) {
              widget.onChanged!(changedValue);
            }
          },
        ),
        Text("${_startValue.toInt()} - ${_endValue.toInt()}"),
      ],
    );
  }
}
