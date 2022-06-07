import 'package:flutter/material.dart';
import 'package:watrix/models/base_model.dart';
import 'package:watrix/services/entity_type.dart';
import 'package:watrix/services/requests.dart';
import 'package:watrix/widgets/horizontal_list.dart';

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
    return ListView(
      physics: BouncingScrollPhysics(),
      children: [
        HorizontalList(
          future: Requests.titlesFuture(Requests.popular(EntityType.movie)),
          heading: "Favorites",
          onClick: (item) {},
          itemWidthPercent: 0.3,
          showTitle: true,
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
