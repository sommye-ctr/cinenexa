import 'package:flutter/material.dart';
import 'package:cinenexa/resources/style.dart';
import 'package:cinenexa/widgets/rounded_image.dart';

import '../../services/constants.dart';

class TvMovieTile extends StatefulWidget {
  final String image, text;
  final double width;
  final bool showTitle;
  final bool darken;
  final bool requestFocusOnBuild;

  final VoidCallback? onClick;
  final VoidCallback? onLongClick;
  final Function(bool hasFocus)? onFocusChange;

  TvMovieTile({
    required this.image,
    this.text = "",
    required this.width,
    this.showTitle = false,
    this.onClick,
    this.onLongClick,
    this.darken = false,
    this.onFocusChange,
    this.requestFocusOnBuild = false,
    Key? key,
  }) : super(key: key);

  @override
  State<TvMovieTile> createState() => _TvMovieTileState();
}

class _TvMovieTileState extends State<TvMovieTile> {
  late double height;
  double scale = 0.9;

  @override
  void initState() {
    height = (widget.width / Constants.backdropAspectRatio);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      canRequestFocus: true,
      onFocusChange: (value) {
        widget.onFocusChange?.call(value);
        if (value) {
          scale = 1;
          setState(() {});
        } else {
          scale = 0.8;
          setState(() {});
        }
      },
      child: Transform.scale(
        scale: scale,
        child: GestureDetector(
          onTap: widget.onClick,
          onLongPress: widget.onLongClick,
          child: Container(
            width: widget.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Container(
                      height: height,
                      decoration: BoxDecoration(
                        border: scale == 1
                            ? Border.all(
                                color: Theme.of(context).colorScheme.primary,
                                width: 2,
                              )
                            : null,
                        borderRadius:
                            BorderRadius.circular(Style.smallRoundEdgeRadius),
                      ),
                      child: RoundedImage(
                        image: widget.image,
                        width: widget.width,
                        ratio: Constants.backdropAspectRatio,
                        radius: Style.smallRoundEdgeRadius,
                      ),
                    ),
                    if (widget.darken)
                      Container(
                        height: height,
                        width: widget.width,
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(
                            Style.smallRoundEdgeRadius,
                          ),
                        ),
                      ),
                  ],
                ),
                ...getConditionedWidgets(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> getConditionedWidgets(context) {
    if (widget.showTitle) {
      return [
        Style.getVerticalSpacing(context: context, percent: 0.01),
        Text(
          widget.text,
          maxLines: 1,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
        ),
      ];
    }
    return [];
  }
}
