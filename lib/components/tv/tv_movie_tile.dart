import 'package:flutter/material.dart';
import 'package:cinenexa/resources/style.dart';
import 'package:cinenexa/widgets/rounded_image.dart';

import '../../services/constants.dart';

class TvMovieTile extends StatelessWidget {
  final String image, text;
  final double width;
  final bool showTitle;
  final bool darken;
  final bool requestFocusOnBuild;
  final double scale;
  final double height;

  final VoidCallback? onClick;
  final VoidCallback? onLongClick;

  TvMovieTile({
    required this.image,
    this.text = "",
    required this.width,
    required this.scale,
    this.showTitle = false,
    this.onClick,
    this.onLongClick,
    this.darken = false,
    this.requestFocusOnBuild = false,
    double? height,
    Key? key,
  })  : this.height = height ?? width / Constants.posterAspectRatio,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: scale,
      child: GestureDetector(
        onTap: onClick,
        onLongPress: onLongClick,
        child: Container(
          width: width,
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
                      image: image,
                      width: width,
                      ratio: Constants.posterAspectRatio,
                      radius: Style.smallRoundEdgeRadius,
                    ),
                  ),
                  if (darken)
                    Container(
                      height: height,
                      width: width,
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
    );
  }

  List<Widget> getConditionedWidgets(context) {
    if (showTitle) {
      return [
        Style.getVerticalSpacing(context: context, percent: 0.01),
        Text(
          text,
          maxLines: 1,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
        ),
      ];
    }
    return [];
  }
}
