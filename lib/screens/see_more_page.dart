import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:watrix/models/base_model.dart';
import 'package:watrix/store/see_more/see_more_store.dart';

import '../components/movie_tile.dart';
import '../resources/style.dart';
import '../services/constants.dart';
import '../utils/screen_size.dart';
import 'details_page.dart';

class SeeMorePage extends StatefulWidget {
  final String future;
  final List<BaseModel> initialItems;
  final String heading;
  const SeeMorePage({
    Key? key,
    required this.future,
    required this.initialItems,
    required this.heading,
  }) : super(key: key);

  @override
  State<SeeMorePage> createState() => _SeeMorePageState();
}

class _SeeMorePageState extends State<SeeMorePage> {
  late SeeMoreStore seeMoreStore;

  @override
  void initState() {
    seeMoreStore =
        SeeMoreStore(future: widget.future, list: widget.initialItems);
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
                    childAspectRatio: Style.movieTileWithTitleRatio,
                  ),
                  itemBuilder: (context, index) {
                    return MovieTile(
                      image:
                          "${Constants.imageBaseUrl}${Constants.posterSize}${seeMoreStore.items[index].posterPath}",
                      width: ScreenSize.getPercentOfWidth(
                        context,
                        0.29,
                      ),
                      showTitle: true,
                      text: seeMoreStore.items[index].title!,
                      onClick: () {
                        Navigator.pushNamed(
                          context,
                          DetailsPage.routeName,
                          arguments: seeMoreStore.items[index],
                        );
                      },
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
