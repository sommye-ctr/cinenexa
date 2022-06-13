import 'package:flutter/material.dart';

import '../resources/strings.dart';
import '../resources/style.dart';
import '../utils/screen_size.dart';

class SearchInput extends StatefulWidget {
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
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  final FocusNode focusNode = FocusNode();

  Widget suffixWidget = IconButton(
    icon: Icon(Icons.search),
    onPressed: () {},
    color: Colors.black,
  );

  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          suffixWidget = IconButton(
            onPressed: () {
              focusNode.unfocus();
              widget.controller?.clear();
            },
            icon: Icon(
              Icons.cancel,
              color: Colors.black,
            ),
          );
        });
        return;
      }
      suffixWidget = IconButton(
        icon: Icon(
          Icons.search_rounded,
          color: Colors.black,
        ),
        onPressed: () {},
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenSize.getPercentOfWidth(context, 0.95),
      child: TextFormField(
        focusNode: focusNode,
        initialValue: widget.value,
        controller: widget.controller,
        onChanged: widget.onChanged,
        onEditingComplete: widget.onEditingComplete,
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
          hintText: widget.hint ?? Strings.search,
          hintStyle: TextStyle(color: Colors.black),
          suffixIcon: suffixWidget,
        ),
        textInputAction: TextInputAction.search,
        textCapitalization: TextCapitalization.words,
      ),
    );
  }
}
