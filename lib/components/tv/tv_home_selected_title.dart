import 'package:cinenexa/store/home/tv_home_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../resources/strings.dart';
import '../../resources/style.dart';
import '../../utils/date_time_formatter.dart';
import '../../utils/screen_size.dart';
import '../../widgets/custom_progress_indicator.dart';
import '../../widgets/rounded_button.dart';
import '../../widgets/vote_indicator.dart';

class TvHomeSelectedTile extends StatefulWidget {
  final TvHomeStore store;
  const TvHomeSelectedTile({required this.store, Key? key}) : super(key: key);

  @override
  State<TvHomeSelectedTile> createState() => _TvHomeSelectedTileState();
}

class _TvHomeSelectedTileState extends State<TvHomeSelectedTile>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 500),
        value: 0,
        lowerBound: 0,
        upperBound: 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        if (widget.store.currentFocused == null) {
          return Container();
        }

        String year =
            "(${DateTimeFormatter.getYearFromString(widget.store.currentFocused!.releaseDate!)})";

        _controller.forward();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              children: [
                Text(
                  "${widget.store.currentFocused?.title} $year",
                  style: Style.largeHeadingStyle.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Style.getVerticalHorizontalSpacing(context: context),
                VoteIndicator(
                    vote: widget.store.currentFocused?.voteAverage ?? 0),
              ],
            ),
            Style.getVerticalSpacing(context: context),
            Container(
              constraints: BoxConstraints(
                maxWidth: ScreenSize.getPercentOfWidth(context, 0.5),
              ),
              child: LayoutBuilder(
                builder: (p0, p1) {
                  final span = TextSpan(
                      text: widget.store.currentFocused?.overview,
                      style: TextStyle(color: Colors.white70));
                  final tp =
                      TextPainter(text: span, textDirection: TextDirection.ltr);
                  tp.layout(maxWidth: p1.maxWidth);
                  final numLines = tp.computeLineMetrics().length;

                  String string;

                  if (numLines == 0) {
                    string = "\n \n \n";
                  } else if (numLines == 1) {
                    string = "${span.text} \n \n";
                  } else if (numLines == 2) {
                    string = "${span.text} \n";
                  } else {
                    string = span.text ?? "\n \n \n";
                  }

                  return Text(
                    string,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white70),
                  );
                },
              ),
            ),
            Style.getVerticalSpacing(context: context),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
