import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:watrix/resources/strings.dart';
import 'package:watrix/screens/see_more_page.dart';
import 'package:watrix/services/constants.dart';
import 'package:watrix/store/actor_details/actor_details_store.dart';
import 'package:watrix/utils/date_time_formatter.dart';
import 'package:watrix/utils/screen_size.dart';
import 'package:watrix/widgets/horizontal_list.dart';
import 'package:watrix/widgets/rounded_image.dart';
import 'package:watrix/widgets/screen_background_image.dart';

import '../models/base_model.dart';
import '../resources/style.dart';
import '../services/utils.dart';

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

  @override
  void initState() {
    actorDetailsStore = ActorDetailsStore(baseModel: widget.baseModel);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            ScreenBackgroundImage(
              image: CachedNetworkImageProvider(
                Utils.getPosterUrl(
                  actorDetailsStore.baseModel.posterPath!,
                ),
              ),
              heightPercent: 0.65,
              child: Container(),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: BackButton(),
            ),
            _buildTitle(),
            _buildMainDetailsRow(),
            _buildKnownFor(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 8,
      ),
      child: Align(
        alignment: Alignment(0, 0.15),
        child: Text(
          actorDetailsStore.baseModel.title!,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildMainDetailsRow() {
    return Observer(
      builder: (_) {
        return Align(
          alignment: Alignment(0, 0.28),
          child: ClipRRect(
            borderRadius:
                BorderRadius.all(Radius.circular(Style.largeRoundEdgeRadius)),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 10,
                sigmaY: 10,
              ),
              child: Opacity(
                opacity: 0.5,
                child: Container(
                  color: Theme.of(context).primaryColor,
                  width: ScreenSize.getPercentOfWidth(context, 0.9),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildMainDetailColumn(
                        Text(
                          _getPlaceOfBirth(),
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        "Birthplace",
                      ),
                      _buildMainDetailColumn(
                        Text(
                          actorDetailsStore.baseModel.voteAverage!
                              .toStringAsFixed(1),
                          style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        "Popularity",
                      ),
                      _buildMainDetailColumn(
                        Text(
                          _getBirthday(),
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        "Birthday",
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMainDetailColumn(Widget top, String text) {
    return Container(
      height: ScreenSize.getPercentOfHeight(context, 0.08),
      padding: EdgeInsets.only(top: 4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          top,
          Text(text),
        ],
      ),
    );
  }

  Widget _buildKnownFor() {
    return Observer(builder: (_) {
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
                    borderRadius:
                        BorderRadius.circular(Style.largeRoundEdgeRadius),
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
    });
  }

  String _getPlaceOfBirth() {
    if (actorDetailsStore.actor == null) {
      return "";
    }
    String string = actorDetailsStore.actor!.placeOfBirth!;
    return string.substring(string.lastIndexOf(',') + 2);
  }

  String _getBirthday() {
    return (actorDetailsStore.actor == null
        ? ""
        : DateTimeFormatter.getMonthYearFromString(
            actorDetailsStore.actor!.birthday!));
  }
}
