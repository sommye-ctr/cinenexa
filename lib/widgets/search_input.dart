import 'package:flutter/material.dart';

import '../resources/strings.dart';
import '../resources/style.dart';
import '../utils/screen_size.dart';

class SearchInput extends StatefulWidget {
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Function() onEditingComplete;
  final Function()? onCancelSearch;
  final Function()? onSearchFocused;
  final String? value, hint;
  late final FocusNode focusNode;

  SearchInput({
    Key? key,
    this.onChanged,
    required this.onEditingComplete,
    this.controller,
    this.value,
    this.hint,
    this.onCancelSearch,
    this.onSearchFocused,
    FocusNode? focus,
  }) {
    if (focus == null) {
      focusNode = FocusNode();
      return;
    }
    focusNode = focus;
  }

  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  Widget? suffixWidget;

  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(() {
      if (widget.focusNode.hasFocus) {
        widget.onSearchFocused?.call();
        setState(() {
          suffixWidget = IconButton(
            onPressed: () {
              setState(() {
                suffixWidget = null;
              });
              widget.focusNode.unfocus();
              widget.controller?.clear();
              widget.onCancelSearch?.call();
            },
            icon: Icon(
              Icons.clear_rounded,
              color: Theme.of(context).focusColor,
            ),
          );
        });
        return;
      }
      suffixWidget = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenSize.getPercentOfWidth(context, 0.95),
      child: TextFormField(
        focusNode: widget.focusNode,
        initialValue: widget.value,
        controller: widget.controller,
        onChanged: widget.onChanged,
        onEditingComplete: widget.onEditingComplete,
        style: TextStyle(color: Theme.of(context).focusColor),
        decoration: InputDecoration(
          fillColor: Theme.of(context).cardColor,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Style.largeRoundEdgeRadius),
            borderSide: BorderSide.none,
          ),
          hintText: widget.hint ?? Strings.search,
          hintStyle: TextStyle(color: Theme.of(context).focusColor),
          prefixIcon: Icon(
            Icons.search_rounded,
            color: Theme.of(context).focusColor,
          ),
          suffixIcon: suffixWidget,
        ),
        textInputAction: TextInputAction.search,
        textCapitalization: TextCapitalization.words,
      ),
    );
  }
}
