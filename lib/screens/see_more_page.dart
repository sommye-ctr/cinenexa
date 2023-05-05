import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:cinenexa/store/see_more/see_more_store.dart';

import '../components/mobile/movie_tile.dart';
import '../models/network/base_model.dart';
import '../resources/style.dart';
import '../services/constants.dart';
import '../utils/screen_size.dart';
import 'actor_details_page.dart';
import 'details_page.dart';

enum SeeMoreChildType {
  squicircle,
  circle,
}

class SeeMorePage extends StatefulWidget {
  final String? future;
  final List<BaseModel> initialItems;
  final String heading;
  final bool isLazyLoad;
  final SeeMoreChildType type;

  const SeeMorePage({
    Key? key,
    required this.initialItems,
    required this.heading,
    this.future,
    this.isLazyLoad = true,
    this.type = SeeMoreChildType.squicircle,
  }) : super(key: key);

  @override
  State<SeeMorePage> createState() => _SeeMorePageState();
}

class _SeeMorePageState extends State<SeeMorePage> {
  late SeeMoreStore seeMoreStore;

  @override
  void initState() {
    seeMoreStore = SeeMoreStore(
      future: widget.future,
      list: widget.initialItems,
      isLazyLoad: widget.isLazyLoad,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          widget.heading,
          style: Style.headingStyle,
        ),
        SizedBox(
          height: ScreenSize.getPercentOfHeight(context, 0.02),
        ),
        Expanded(
          child: Observer(
            builder: (_) {
              return LazyLoadScrollView(
                onEndOfPage: () => seeMoreStore.pageEndReached(),
                child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: seeMoreStore.items.length,
                  physics: BouncingScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: widget.type == SeeMoreChildType.squicircle
                        ? Style.movieTileWithTitleRatio
                        : 1 / 1.33,
                  ),
                  itemBuilder: (context, index) {
                    return _buildChild(index);
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildChild(index) {
    if (widget.type == SeeMoreChildType.squicircle) {
      return MovieTile(
        image:
            "${Constants.tmdbImageBase}${Constants.posterSize}${seeMoreStore.items[index].posterPath}",
        width: ScreenSize.getPercentOfWidth(
          context,
          0.29,
        ),
        showTitle: true,
        text: seeMoreStore.items[index].title!,
        onClick: () {
          String name;
          if (seeMoreStore.items[index].type == BaseModelType.people) {
            name = ActorDetailsPage.routeName;
          } else {
            name = DetailsPage.routeName;
          }
          Navigator.pushNamed(
            context,
            name,
            arguments: seeMoreStore.items[index],
          );
        },
      );
    }
    return Style.getActorTile(
        callback: () {
          String name;
          if (seeMoreStore.items[index].type == BaseModelType.people) {
            name = ActorDetailsPage.routeName;
          } else {
            name = DetailsPage.routeName;
          }
          Navigator.pushNamed(
            context,
            name,
            arguments: seeMoreStore.items[index],
          );
        },
        context: context,
        title: seeMoreStore.items[index].title,
        poster: seeMoreStore.items[index].posterPath);
  }
}
