import 'package:cinenexa/components/home_bottom_nav_bar.dart';
import 'package:cinenexa/components/trakt_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import '../store/watchlist/watchlist_store.dart';
import 'list_details_page.dart';

class WatchListPage extends StatefulWidget {
  const WatchListPage({Key? key}) : super(key: key);

  @override
  State<WatchListPage> createState() => _WatchListPageState();
}

class _WatchListPageState extends State<WatchListPage> {
  late WatchListStore watchListStore;

  @override
  void initState() {
    watchListStore = Provider.of<WatchListStore>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      watchListStore.watchLists;
      return ListView.separated(
        itemCount: watchListStore.watchLists.length + 1,
        separatorBuilder: (context, index) => Divider(),
        itemBuilder: (context, index) {
          if (index == watchListStore.watchLists.length) {
            return SizedBox(
              height: HomeBottomNavBar.bottomNavHeight,
            );
          }
          return TraktListTile(
            list: watchListStore.watchLists[index],
            onClick: () => Navigator.pushNamed(
              context,
              ListDetailsPage.routeName,
              arguments: {
                "list": watchListStore.watchLists[index],
                "personal": true
              },
            ),
          );
        },
      );
    });
  }
}
