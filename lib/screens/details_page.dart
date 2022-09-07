import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:watrix/components/details_header.dart';
import 'package:watrix/components/details_more_details.dart';

import 'package:watrix/services/constants.dart';
import 'package:watrix/store/details/details_store.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../models/network/base_model.dart';
import '../utils/screen_size.dart';

class DetailsPage extends StatefulWidget {
  static const routeName = "/details";

  final BaseModel baseModel;

  DetailsPage({
    Key? key,
    required this.baseModel,
  }) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  late final DetailsStore detailsStore;
  final _controller = ScrollController();
  YoutubePlayerController? videoController;

  double get maxHeight => ScreenSize.getPercentOfHeight(context, 1);
  double get minHeight => (ScreenSize.getPercentOfWidth(context, 0.75) /
      Constants.backdropAspectRatio);

  @override
  void initState() {
    detailsStore = DetailsStore(baseModel: widget.baseModel);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener<ScrollEndNotification>(
        onNotification: (_) {
          _snapBehaviour();
          return false;
        },
        child: CustomScrollView(
          controller: _controller,
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              floating: true,
              delegate: DetailsHeader(
                maxHeight: maxHeight,
                minHeight: minHeight,
                detailsStore: detailsStore,
                scrollController: _controller,
              ),
            ),
            SliverToBoxAdapter(
              child: DetailsMoreDetails(
                detailsStore: detailsStore,
                height: ScreenSize.getPercentOfHeight(context, 1) - minHeight,
              ),
            )
          ],
        ),
      ),
    );
  }

  void _snapBehaviour() {
    final double distance = maxHeight - minHeight;
    if (_controller.offset > 0 && _controller.offset < distance) {
      final double snapOffset =
          _controller.offset / distance > 0.4 ? distance : 0;

      Future.microtask(() => _controller.animateTo(snapOffset,
          duration: Duration(milliseconds: 200), curve: Curves.easeIn));
    }
  }
}
