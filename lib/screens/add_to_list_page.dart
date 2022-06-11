import 'package:flutter/material.dart';
import 'package:watrix/components/mylist_tile.dart';
import 'package:watrix/resources/strings.dart';
import 'package:watrix/resources/style.dart';

import '../widgets/rounded_button.dart';

class AddToListPage extends StatelessWidget {
  const AddToListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          Strings.addToList,
          style: Style.headingStyle,
        ),
        RoundedButton(
          child: Text(Strings.createList),
          onPressed: () {},
          type: RoundedButtonType.outlined,
        ),
        MyListTile(
          backdropUrl:
              "https://wallpapersmug.com/download/1600x900/be5725/avengers-infinity-war-movie-poster-international.jpg",
          noOfItems: 5,
          title: "Marvel",
          onClick: () {},
        ),
        MyListTile(
          backdropUrl:
              "https://www.themoviedb.org/t/p/w533_and_h300_bestv2/56v2KjBlU4XaOv9rVYEQypROD7P.jpg",
          noOfItems: 5,
          title: "Tv Shows",
          onClick: () {},
        ),
      ],
    );
  }
}
