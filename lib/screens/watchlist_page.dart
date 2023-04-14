import 'package:cinenexa/components/home_bottom_nav_bar.dart';
import 'package:cinenexa/components/trakt_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../models/network/trakt/trakt_list.dart';
import '../resources/asset.dart';
import '../resources/strings.dart';
import '../resources/style.dart';
import '../store/user/user_store.dart';
import '../store/watchlist/watchlist_store.dart';
import '../utils/screen_size.dart';
import '../widgets/custom_checkbox_list.dart';
import 'list_details_page.dart';

class WatchListPage extends StatefulWidget {
  const WatchListPage({Key? key}) : super(key: key);

  @override
  State<WatchListPage> createState() => _WatchListPageState();
}

class _WatchListPageState extends State<WatchListPage> {
  late WatchListStore watchListStore;
  late UserStore userStore;

  @override
  void initState() {
    watchListStore = Provider.of<WatchListStore>(context, listen: false);
    userStore = Provider.of<UserStore>(context, listen: false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      watchListStore.watchLists;
      userStore.isTraktLogged;
      watchListStore.currentIsLiked;

      if (!userStore.isTraktLogged) {
        return Column(
          children: [
            SvgPicture.asset(
              Asset.traktConnect,
              width: ScreenSize.getPercentOfWidth(context, 0.7),
            ),
            Style.getVerticalSpacing(context: context),
            Text(
              Strings.loginToSeeList,
            )
          ],
        );
      }

      List<TraktList> currentList = watchListStore.currentIsLiked
          ? watchListStore.likedLists
          : watchListStore.watchLists;

      return Column(
        children: [
          _buildHeading(currentList, watchListStore.currentIsLiked),
          Style.getVerticalSpacing(context: context),
          Expanded(
            child: ListView.separated(
              itemCount: currentList.length + 1,
              separatorBuilder: (context, index) => Divider(),
              itemBuilder: (context, index) {
                if (index == currentList.length) {
                  return SizedBox(
                    height: HomeBottomNavBar.bottomNavHeight,
                  );
                }
                return TraktListTile(
                  list: currentList[index],
                  onClick: () => Navigator.pushNamed(
                    context,
                    ListDetailsPage.routeName,
                    arguments: {
                      "list": currentList[index],
                      "personal": !watchListStore.currentIsLiked
                    },
                  ),
                );
              },
            ),
          ),
        ],
      );
    });
  }

  Widget _buildHeading(List list, bool isLiked) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "${list.length} Items",
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Style.largeRoundEdgeRadius),
            border: Border.all(
              color: Theme.of(context).highlightColor,
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              alignment: Alignment.centerLeft,
              borderRadius: BorderRadius.circular(Style.largeRoundEdgeRadius),
              value: isLiked ? Strings.liked : Strings.personal,
              menuMaxHeight: ScreenSize.getPercentOfHeight(context, 0.25),
              items: [
                DropdownMenuItem(
                  child: Text(
                    Strings.personal,
                  ),
                  value: Strings.personal,
                ),
                DropdownMenuItem(
                  child: Text(
                    Strings.liked,
                  ),
                  value: Strings.liked,
                ),
              ],
              onChanged: (value) {
                watchListStore.changeSelection(value == Strings.liked);
              },
            ),
          ),
        ),
      ],
    );
  }
}
