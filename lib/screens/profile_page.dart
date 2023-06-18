import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';

import 'package:cinenexa/resources/asset.dart';
import 'package:cinenexa/resources/strings.dart';
import 'package:cinenexa/resources/style.dart';
import 'package:cinenexa/screens/extensions_page.dart';
import 'package:cinenexa/screens/settings_page.dart';
import 'package:cinenexa/store/user/user_store.dart';
import 'package:cinenexa/utils/screen_size.dart';

import '../components/mobile/home_bottom_nav_bar.dart';
import '../resources/settings_tile_obj.dart';
import '../widgets/user_profile.dart';
import '../widgets/user_stat_card.dart';

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
      padding: EdgeInsets.only(
          bottom: HomeBottomNavBar.bottomNavHeight, right: 4, left: 4),
      child: Scaffold(
        body: ListView(
          children: [
            Style.getVerticalHorizontalSpacing(context: context),
            UserProfile(),
            Style.getVerticalHorizontalSpacing(context: context),
            _buildStatCardsTile(),
            Style.getVerticalHorizontalSpacing(context: context),
            ..._buildSettingsTabs(),
          ],
        ),
      ),
    );
  }

  Widget _buildAttribution() {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            Asset.traktBranding,
            width: ScreenSize.getPercentOfWidth(context, 0.1),
          ),
          Style.getVerticalHorizontalSpacing(context: context, percent: 0.05),
          SvgPicture.asset(
            Asset.tmdbBranding,
            width: ScreenSize.getPercentOfWidth(context, 0.15),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildSettingsTabs() {
    return [
      _buildTile(
        Style.settingTiles[0],
        () => _navigateToSettings(SettingsPage.GENERAL),
      ),
      Style.getVerticalSpacing(context: context, percent: 0.01),
      _buildTile(
        Style.settingTiles[1],
        () => Navigator.pushNamed(context, ExtensionsPage.routeName),
      ),
      Style.getVerticalSpacing(context: context, percent: 0.01),
      _buildTile(
        Style.settingTiles[2],
        () => _navigateToSettings(SettingsPage.INTEGRATIONS),
      ),
      Style.getVerticalSpacing(context: context, percent: 0.01),
      _buildTile(
        Style.settingTiles[3],
        () => _navigateToSettings(SettingsPage.PLAYER),
      ),
      Style.getVerticalSpacing(context: context, percent: 0.01),
      _buildTile(
        Style.settingTiles[4],
        () => _navigateToSettings(SettingsPage.MORE),
      ),
      Style.getVerticalSpacing(context: context, percent: 0.01),
      _buildTile(
        Style.settingTiles[5],
        _reportBug,
      ),
      Style.getVerticalSpacing(context: context, percent: 0.01),
      _buildTile(
        Style.settingTiles[6],
        () {
          InAppReview.instance.openStoreListing();
        },
      ),
      Style.getVerticalSpacing(context: context),
      _buildAttribution(),
    ];
  }

  Widget _buildTile(SettingsTileObj obj, VoidCallback onClick) {
    return Style.getListTile(
      context: context,
      title: obj.string,
      leading: CircleAvatar(
        child: Icon(
          obj.icon,
          color: Colors.black,
        ),
        backgroundColor: obj.bgColor,
      ),
      trailing: Icon(Icons.arrow_right_outlined),
      onTap: onClick,
    );
  }

  void _reportBug() {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(Strings.reportBug),
          content: Text(Strings.reportBugInfo),
          actions: [
            CupertinoDialogAction(
              child: Text(Strings.continueSt),
              onPressed: () async {
                PackageInfo packageInfo = await PackageInfo.fromPlatform();
                String package =
                    "--------------App Info--------------\nversion: ${packageInfo.version}\nname: ${packageInfo.appName}\nbuildNumber: ${packageInfo.buildNumber}\npackage: ${packageInfo.packageName}\n";

                AndroidDeviceInfo deviceInfo =
                    await DeviceInfoPlugin().androidInfo;

                String device =
                    "--------------Device Info--------------\nbrand: ${deviceInfo.brand}\n device: ${deviceInfo.device}\nisPhysicalDevice: ${deviceInfo.isPhysicalDevice}\nmanufacturer: ${deviceInfo.brand}\nmodel: ${deviceInfo.model}\nversion: ${deviceInfo.version.release}\n";

                final email = Email(
                  subject: "Bug Report",
                  body: "${package} ${device}",
                  recipients: ['support@cinenexa.com'],
                );

                await FlutterEmailSender.send(email);
              },
            ),
            CupertinoDialogAction(
              child: Text(Strings.cancel),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  void _navigateToSettings(int type) {
    Navigator.pushNamed(context, SettingsPage.routeName, arguments: type);
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
              UserStatCard(
                title: userStore.userStats!.moviesWatched,
                heading: Strings.watchedMovies,
              ),
              UserStatCard(
                title: userStore.userStats!.showsWatched,
                heading: Strings.watchedShows,
              ),
              UserStatCard(
                title: userStore.userStats!.moviesMinutes,
                heading: Strings.minSpentMovies,
              ),
              UserStatCard(
                title: userStore.userStats!.showsMinutes,
                heading: Strings.minSpentShows,
              ),
            ],
          ),
        );
      },
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
