import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:watrix/components/actor_details_page_header.dart';
import 'package:watrix/resources/my_theme.dart';
import 'package:watrix/resources/strings.dart';
import 'package:watrix/screens/see_more_page.dart';
import 'package:watrix/store/actor_details/actor_details_store.dart';
import 'package:watrix/utils/screen_size.dart';
import 'package:watrix/widgets/horizontal_list.dart';

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
      backgroundColor:
          Provider.of<MyTheme>(context).darkMode ? Colors.black : Colors.white,
      body: CustomScrollView(
        controller: _controller,
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            floating: true,
            delegate: ActorDetailsPageHeader(
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
                    child: HorizontalList.fromInititalValues(
                      items: actorDetailsStore.credits,
                      heading: Strings.knownFor,
                      itemWidthPercent: 0.3,
                      showTitle: true,
                      limitItems: 10,
                      onClick: (baseModel) =>
                          actorDetailsStore.onItemClicked(context, baseModel),
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
