import 'package:flutter/material.dart';
import 'package:watrix/resources/strings.dart';
import 'package:watrix/resources/style.dart';

class CreateListPage extends StatelessWidget {
  const CreateListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          Strings.createList,
          style: Style.headingStyle,
        ),
      ],
    );
  }
}
