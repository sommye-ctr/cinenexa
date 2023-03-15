import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:cinenexa/components/mobile/actor_details_header.dart';
import 'package:cinenexa/resources/strings.dart';
import 'package:cinenexa/screens/see_more_page.dart';
import 'package:cinenexa/store/actor_details/actor_details_store.dart';
import 'package:cinenexa/utils/screen_size.dart';
import 'package:cinenexa/widgets/horizontal_list.dart';

import '../models/network/base_model.dart';
import '../resources/style.dart';
import '../services/constants.dart';

class ActorDetailsPage extends StatefulWidget {
  static const routeName = "/actorDetails";

  final BaseModel baseModel;

  const ActorDetailsPage({
    Key? key,
    required this.baseModel,
  }) : super(key: key);

  @override
  State<ActorDetailsPage> createState() => _ActorDetailsPageState();
}

class _ActorDetailsPageState extends State<ActorDetailsPage> {
  late ActorDetailsStore actorDetailsStore;
  final _controller = ScrollController();

  double get maxHeight => ScreenSize.getPercentOfHeight(context, 1);
  double get minHeight =>
      ScreenSize.getPercentOfHeight(context, 1) -
      (ScreenSize.getPercentOfWidth(context, 0.3) /
          Constants.posterAspectRatio); // total screen - height by the bottom

  @override
  void initState() {
    actorDetailsStore = ActorDetailsStore(baseModel: widget.baseModel);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark
          ? Colors.black
          : Colors.white,
      body: CustomScrollView(
        controller: _controller,
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            floating: true,
            delegate: ActorDetailsHeader(
              maxHeight: maxHeight,
              minHeight: minHeight,
              actorDetailsStore: actorDetailsStore,
            ),
          ),
          SliverToBoxAdapter(
            child: Observer(builder: (_) {
              if (actorDetailsStore.credits.isNotEmpty) {
                return Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: ScreenSize.getPercentOfWidth(context, 0.02),
                    ),
                    child: HorizontalList<BaseModel>.fromInititalValues(
                      items: actorDetailsStore.credits,
                      heading: Strings.knownFor,
                      buildPlaceHolder: () => Style.getMovieTilePlaceHolder(
                          context: context, widthPercent: 0.3),
                      buildWidget: (item) => Style.getMovieTile(
                        item: item,
                        widhtPercent: 0.3,
                        showTitle: true,
                        context: context,
                        onClick: (baseModel) =>
                            actorDetailsStore.onItemClicked(context, baseModel),
                      ),
                      height: Style.getMovieTileHeight(
                              context: context, widthPercent: 0.3) +
                          ScreenSize.getPercentOfHeight(context, 0.05),
                      limitItems: 10,
                      onRightTrailClicked: (list) {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                Style.largeRoundEdgeRadius),
                          ),
                          builder: (context) {
                            return FractionallySizedBox(
                              heightFactor: 0.75,
                              child: SeeMorePage(
                                initialItems: list,
                                heading: Strings.knownFor,
                                isLazyLoad: false,
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                );
              }
              return Container();
            }),
          ),
        ],
      ),
    );
  }
}
