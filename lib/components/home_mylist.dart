import 'package:flutter/material.dart';
import 'package:watrix/components/mylist_tile.dart';
import 'package:watrix/models/base_model.dart';
import 'package:watrix/resources/strings.dart';
import 'package:watrix/resources/style.dart';
import 'package:watrix/services/entity_type.dart';
import 'package:watrix/services/requests.dart';
import 'package:watrix/widgets/horizontal_list.dart';
import 'package:watrix/widgets/rounded_button.dart';

class HomeMyList extends StatefulWidget {
  const HomeMyList({Key? key}) : super(key: key);

  @override
  State<HomeMyList> createState() => _HomeMyListState();
}

class _HomeMyListState extends State<HomeMyList>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView.separated(
      itemCount: 2 + 2,
      separatorBuilder: (context, index) {
        if (index == 0 || index == 1)
          return Style.getVerticalSpacing(context: context);
        return Style.getVerticalSpacing(context: context, percent: 0.01);
      },
      itemBuilder: (context, index) {
        if (index == 0) {
          return HorizontalList(
            future: Requests.titlesFuture(Requests.popular(EntityType.movie)),
            heading: Strings.favorites,
            onClick: (item) {},
            itemWidthPercent: 0.3,
            showTitle: true,
          );
        } else if (index == 1) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                Strings.myList,
                style: Style.headingStyle,
              ),
              RoundedButton(
                child: Text(Strings.createList),
                onPressed: () {},
                type: RoundedButtonType.outlined,
              )
            ],
          );
        } else if (index == 2) {
          return MyListTile(
            backdropUrl:
                "https://www.themoviedb.org/t/p/w533_and_h300_bestv2/56v2KjBlU4XaOv9rVYEQypROD7P.jpg",
            noOfItems: 8,
            title: "Tv Series",
            heightPercent: 0.12,
            onClick: () {},
          );
        } else if (index == 3) {
          return MyListTile(
            backdropUrl:
                "https://wallpapersmug.com/download/1600x900/be5725/avengers-infinity-war-movie-poster-international.jpg",
            noOfItems: 5,
            title: "Marvel",
            heightPercent: 0.12,
            onClick: () {},
          );
        }
        return Container();
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
