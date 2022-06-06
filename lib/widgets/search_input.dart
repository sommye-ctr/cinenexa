import 'package:flutter/material.dart';

import '../resources/strings.dart';
import '../resources/style.dart';
import '../utils/screen_size.dart';

class SearchInput extends StatelessWidget {
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Function() onEditingComplete;
  final String? value, hint;
  SearchInput({
    Key? key,
    this.onChanged,
    required this.onEditingComplete,
    this.controller,
    this.value,
    this.hint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenSize.getPercentOfWidth(context, 0.95),
      child: TextFormField(
        initialValue: value,
        controller: controller,
        onChanged: onChanged,
        onEditingComplete: onEditingComplete,
        style: TextStyle(
          color: Colors.black,
        ),
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Style.largeRoundEdgeRadius),
            borderSide: BorderSide.none,
          ),
          hintText: hint ?? Strings.search,
          hintStyle: TextStyle(color: Colors.black),
          suffixIcon: Icon(
            Icons.search,
            color: Colors.black,
          ),
        ),
        textInputAction: TextInputAction.search,
        textCapitalization: TextCapitalization.words,
      ),
    );
  }
}
