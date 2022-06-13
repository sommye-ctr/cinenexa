import 'package:flutter/material.dart';
import 'package:watrix/resources/style.dart';

class SearchHistoryTile extends StatelessWidget {
  final String text;
  final Function(String text) onClick;
  final Function() onClearClick;

  const SearchHistoryTile({
    Key? key,
    required this.text,
    required this.onClick,
    required this.onClearClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Theme.of(context).colorScheme.onBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Style.smallRoundEdgeRadius),
      ),
      title: Text(text),
      trailing: IconButton(
        onPressed: onClearClick,
        icon: Icon(Icons.remove_circle_outline),
      ),
      onTap: () => onClick(text),
    );
  }
}
