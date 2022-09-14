import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:watrix/resources/strings.dart';
import 'package:watrix/resources/style.dart';
import 'package:watrix/store/user/user_store.dart';
import 'package:watrix/utils/screen_size.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late UserStore userStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    userStore = Provider.of<UserStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Style.getVerticalHorizontalSpacing(context: context),
          _buildProfileTile(),
          Style.getVerticalHorizontalSpacing(context: context),
          _buildStatCardsTile(),
        ],
      ),
    );
  }

  Widget _buildProfileTile() {
    return Observer(builder: (_) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: ScreenSize.getPercentOfWidth(context, 0.075),
                backgroundImage:
                    CachedNetworkImageProvider(userStore.user?.avatar ?? ""),
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                userStore.user?.name ?? Strings.unknown,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
          Icon(Icons.settings),
        ],
      );
    });
  }

  Widget _buildStatCardsTile() {
    return Observer(
      builder: (_) {
        if (userStore.userStats == null) return Container();
        return Container(
          height: ScreenSize.getPercentOfHeight(context, 0.2),
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            children: [
              _buildStatCard(
                  userStore.userStats!.moviesWatched, Strings.watchedMovies),
              _buildStatCard(
                  userStore.userStats!.showsWatched, Strings.watchedShows),
              _buildStatCard(
                  userStore.userStats!.moviesMinutes, Strings.minSpentMovies),
              _buildStatCard(
                  userStore.userStats!.showsMinutes, Strings.minSpentShows),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatCard(int title, String heading) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Style.largeRoundEdgeRadius),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: 4,
          bottom: 4,
          right: ScreenSize.getPercentOfWidth(context, 0.1),
          left: ScreenSize.getPercentOfWidth(context, 0.1),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title.toString(),
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              heading,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /* bool value = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenSize.getPercentOfWidth(
          context,
          0.02,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserProfileView(
            "Somye",
            "anyone.mahajan@gmail.com",
            0.12,
          ),
          SizedBox(
            height: ScreenSize.getPercentOfHeight(
              context,
              0.05,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () async {},
                  icon: Icon(
                    Icons.timelapse,
                    color: Colors.blue,
                  ),
                  label: Text(
                    "Trakt login",
                  ),
                ),
              ),
              SizedBox(
                width: ScreenSize.getPercentOfWidth(
                  context,
                  0.02,
                ),
              ),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                  label: Text(
                    "Favorite",
                  ),
                ),
              ),
            ],
          ),
          Style.getVerticalSpacing(context: context),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                Strings.darkMode,
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
              CupertinoSwitch(
                value: value,
                activeColor: Theme.of(context).colorScheme.primary,
                onChanged: (changeValue) {
                  Provider.of<MyTheme>(context, listen: false)
                      .changeTheme(changeValue);
                  setState(() {
                    value = changeValue;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  } */
}
