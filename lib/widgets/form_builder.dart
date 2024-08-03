import 'package:cinenexa/resources/style.dart';
import 'package:cinenexa/services/network/utils.dart';
import 'package:cinenexa/widgets/custom_checkbox_list.dart';
import 'package:flutter/material.dart';

class FormBuilder extends StatefulWidget {
  final String json;
  FormBuilder({
    Key? key,
    required this.json,
  }) : super(key: key);

  @override
  State<FormBuilder> createState() => FormBuilderState();
}

class FormBuilderState extends State<FormBuilder> {
  List<Map<String, dynamic>> questions = [];
  Map<String, dynamic> results = {};

  @override
  void initState() {
    List jsonDecode = (Utils.parseJson(widget.json) as List);
    questions.addAll(jsonDecode.map((e) => e));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: _mapWidgets(context),
        ),
      ),
    );
  }

  String? validate() {
    for (var element in questions) {
      if (element['required'] == true && !results.containsKey(element['id'])) {
        Style.showToast(
          context: context,
          text: "${element['title']} is required",
        );
        return null;
      }
    }
    return Utils.encodeJson(results);
  }

  List<Widget> _mapWidgets(BuildContext context) {
    List<Widget> widgets = [];

    for (var element in questions) {
      widgets.add(_mapWidget(element, context));
    }
    return widgets;
  }

  Widget _mapWidget(Map<String, dynamic> json, BuildContext context) {
    switch (json['type']) {
      case "checkbox":
        return _wrapWithCard(_mapCheckbox(json, context));
      case "dropdown":
        return _wrapWithCard(_mapDropdown(json, context));
      case "radio":
        return _wrapWithCard(_mapRadio(json, context));
      case "text":
        return _wrapWithCard(_mapText(json, context));
      default:
        return Text("An unsupported format was provided!");
    }
  }

  Widget _wrapWithCard(Widget child) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: child,
      ),
      margin: EdgeInsets.all(16),
      color: Theme.of(context).scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.grey.shade800,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(Style.smallRoundEdgeRadius),
      ),
    );
  }

  Widget _mapCheckbox(Map<String, dynamic> map, BuildContext context) {
    return Column(
      children: [
        Text(map['title'], style: Style.headingStyle),
        Text(map['description']),
        if (map['required'] == true)
          Text(
            "* Required",
            style: TextStyle(color: Colors.red),
          ),
        Style.getVerticalSpacing(context: context),
        CustomCheckBoxList(
          children: (map['fields'] as List).map((e) => e.toString()).toList(),
          type: CheckBoxListType.grid,
          delegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 3,
          ),
          onSelectionAdded: (values) {
            results.update(
              map['id'],
              (incomingValue) => values,
              ifAbsent: () => values,
            );
          },
          onSelectionRemoved: (values) {
            if (values.isEmpty) {
              results.remove(map['id']);
              return;
            }
            results.update(
              map['id'],
              (incomingValue) => values,
              ifAbsent: () => values,
            );
          },
        ),
      ],
    );
  }

  Widget _mapRadio(Map<String, dynamic> map, BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(map['title'], style: Style.headingStyle),
        Text(map['description']),
        if (map['required'] == true)
          Text(
            "* Required",
            style: TextStyle(color: Colors.red),
          ),
        Style.getVerticalSpacing(context: context),
        CustomCheckBoxList(
          children: (map['fields'] as List).map((e) => e.toString()).toList(),
          type: CheckBoxListType.grid,
          delegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 3,
          ),
          singleSelect: true,
          onSelectionAdded: (values) {
            results.update(
              map['id'],
              (incomingValue) => values.first,
              ifAbsent: () => values.first,
            );
          },
          onSelectionRemoved: (values) {
            results.remove(map['id']);
          },
        ),
      ],
    );
  }

  Widget _mapDropdown(Map<String, dynamic> map, BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(map['title'], style: Style.headingStyle),
        Text(map['description']),
        if (map['required'] == true)
          Text(
            "* Required",
            style: TextStyle(color: Colors.red),
          ),
        Style.getVerticalSpacing(context: context),
        Container(
          width: double.infinity,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              items: (map['fields'] as List)
                  .map((e) => e.toString())
                  .map((e) => DropdownMenuItem<String>(
                        child: Text(e),
                        value: e,
                      ))
                  .toList(),
              value: results[map['id']],
              borderRadius: BorderRadius.circular(Style.largeRoundEdgeRadius),
              hint: Text("Select"),
              onChanged: (value) {
                results.update(
                  map['id'],
                  (newvalue) => value,
                  ifAbsent: () => value,
                );
                setState(() {});
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _mapText(Map<String, dynamic> map, BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(map['title'], style: Style.headingStyle),
        if (map['required'] == true)
          Text(
            "* Required",
            style: TextStyle(color: Colors.red),
          ),
        Style.getVerticalSpacing(context: context),
        TextField(
          decoration: InputDecoration(
            hintText: map['description'],
          ),
          keyboardType: map['inputType'] == "string"
              ? TextInputType.text
              : TextInputType.number,
          maxLines: map['maxLines'],
          onChanged: (value) {
            if (value.isEmpty) {
              results.remove(map['id']);
              return;
            }
            results.update(
              map['id'],
              (newvalue) => value,
              ifAbsent: () => value,
            );
          },
        ),
      ],
    );
  }
}
