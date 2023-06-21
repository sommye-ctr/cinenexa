import 'package:cinenexa/resources/style.dart';
import 'package:cinenexa/widgets/tv_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TvSwitch extends StatefulWidget {
  final TvWidgetController widgetController;
  final String title, subtitle;
  const TvSwitch({
    required this.subtitle,
    required this.title,
    required this.widgetController,
    Key? key,
  }) : super(key: key);

  @override
  State<TvSwitch> createState() => _TvSwitchState();
}

class _TvSwitchState extends State<TvSwitch> {
  late bool value = widget.widgetController.value;
  late bool active = widget.widgetController.active;

  @override
  void initState() {
    widget.widgetController.addListener(() {
      active = widget.widgetController.active;
      value = widget.widgetController.value;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: active ? Theme.of(context).cardColor : Colors.transparent,
      child: Style.getListTile(
        context: context,
        title: widget.title,
        subtitle: widget.subtitle,
        transparent: true,
        trailing: CupertinoSwitch(
          value: value,
          onChanged: (value) async {},
        ),
      ),
    );
  }
}
