import 'package:cinenexa/store/user/user_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cinenexa/components/mobile/details_header.dart';
import 'package:cinenexa/components/mobile/details_more_details.dart';

import 'package:cinenexa/services/constants.dart';
import 'package:cinenexa/store/details/details_store.dart';
import 'package:cinenexa/store/extensions/extensions_store.dart';
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
    var list = Provider.of<ExtensionsStore>(context, listen: false)
        .installedExtensions;
    bool trakt = Provider.of<UserStore>(context, listen: false).isTraktLogged;
    detailsStore = DetailsStore(
      baseModel: widget.baseModel,
      noOfExtensions: list.length,
      installedExtensions: list,
      isTraktLogged: trakt,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        detailsStore.cancelStreams();
        return true;
      },
      child: Scaffold(
        body: NotificationListener<ScrollEndNotification>(
          onNotification: (_) {
            _snapBehaviour();
            return false;
          },
          child: CustomScrollView(
            key: PageStorageKey("scrollkey"),
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
                child: Container(
                  height: 1,
                ),
              ),
              SliverToBoxAdapter(
                child: DetailsMoreDetails(
                  detailsStore: detailsStore,
                  controller: _controller,
                  height: ScreenSize.getPercentOfHeight(context, 1) - minHeight,
                ),
              )
            ],
          ),
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
