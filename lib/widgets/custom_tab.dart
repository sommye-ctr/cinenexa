import 'package:flutter/material.dart';

class CustomTab extends StatefulWidget {
  final List<String> texts;
  const CustomTab(this.texts, {Key? key}) : super(key: key);

  @override
  _CustomTabState createState() => _CustomTabState();
}

class _CustomTabState extends State<CustomTab> {
  int _selectedIndex = 0;

  void clickHandler(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        for (String item in widget.texts)
          TextButton(
            child: Text(
              item,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            onPressed: () {},
          )
      ],
    );
  }
}
