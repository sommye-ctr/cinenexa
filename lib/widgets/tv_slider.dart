import 'package:flutter/material.dart';

class TvSlider extends StatefulWidget {
  final TvWidgetController controller;
  final String heading;

  const TvSlider({required this.controller, required this.heading, Key? key})
      : super(key: key);

  @override
  State<TvSlider> createState() => _TvSliderState();
}

class _TvSliderState extends State<TvSlider> {
  late double value = widget.controller.value;
  late bool active = widget.controller.active;

  @override
  void initState() {
    widget.controller.addListener(() {
      active = widget.controller.active;
      value = widget.controller.value;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: active ? Theme.of(context).cardColor : Colors.transparent,
      child: Column(
        children: [
          Text("${widget.heading}: ${value}"),
          Slider(
            value: value,
            divisions: (widget.controller.max - widget.controller.min) ~/
                widget.controller.step,
            max: widget.controller.max,
            min: widget.controller.min,
            label: value.toString(),
            onChanged: (value) {},
          ),
        ],
      ),
    );
  }
}

class TvWidgetController<T> extends ChangeNotifier {
  bool active;
  T value;

  final double max;
  final double min;
  final int step;

  TvWidgetController({
    this.active = false,
    required this.value,
    this.max = 0,
    this.min = 0,
    this.step = 0,
  });

  void changeStatus(bool newValue) {
    active = newValue;
    notifyListeners();
  }

  void changeValue(T newVal) {
    value = newVal;
    notifyListeners();
  }

  T seekForwardSlider() {
    final newValue = (value as double) + (step);
    value = newValue.clamp(min, max) as T;
    notifyListeners();
    return value;
  }

  T seekBackwardSlider() {
    final newValue = (value as double) - (step);
    value = newValue.clamp(min, max) as T;
    notifyListeners();
    return value;
  }
}
