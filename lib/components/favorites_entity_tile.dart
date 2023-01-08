import 'package:flutter/material.dart';
import 'package:cinenexa/components/movie_tile.dart';

class FavoritesEntityTile extends StatefulWidget {
  final String image, text;
  final double width;
  final bool showTitle;
  final bool showCheckIcon;
  final bool checked;
  final VoidCallback? onClick;
  final Function(bool checked)? onCheckClick;
  final VoidCallback? onLongClick;

  const FavoritesEntityTile({
    Key? key,
    required this.image,
    this.text = "",
    required this.width,
    this.checked = false,
    this.showTitle = false,
    this.onClick,
    this.onCheckClick,
    this.onLongClick,
    this.showCheckIcon = false,
  }) : super(key: key);

  @override
  State<FavoritesEntityTile> createState() => FavoritesEntityTileState();
}

class FavoritesEntityTileState extends State<FavoritesEntityTile> {
  late bool checked = widget.checked;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MovieTile(
          image: widget.image,
          width: widget.width,
          onClick: () {
            if (widget.showCheckIcon) {
              toggle();
              return;
            }
            widget.onClick?.call();
          },
          darken: widget.showCheckIcon && !checked,
          showTitle: widget.showTitle,
          text: widget.text,
          onLongClick: widget.onLongClick,
        ),
        if (widget.showCheckIcon)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.topRight,
              child: Icon(checked ? Icons.check_circle : Icons.circle_outlined),
            ),
          ),
      ],
    );
  }

  void toggle() {
    widget.onCheckClick?.call(!checked);
    changeChecked();
  }

  void changeChecked({bool? check}) {
    setState(() {
      checked = check ?? !checked;
    });
  }
}
