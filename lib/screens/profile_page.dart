import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:cinenexa/resources/asset.dart';
import 'package:cinenexa/screens/extensions_page.dart';
import 'package:cinenexa/utils/size_formatter.dart';
import 'package:cinenexa/widgets/rounded_button.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:random_avatar/random_avatar.dart';
import 'package:cinenexa/resources/strings.dart';
import 'package:cinenexa/resources/style.dart';
import 'package:cinenexa/screens/intro_page.dart';
import 'package:cinenexa/screens/settings_page.dart';
import 'package:cinenexa/store/user/user_store.dart';
import 'package:cinenexa/utils/screen_size.dart';

import '../components/home_bottom_nav_bar.dart';

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
            _buildProfileTile(),
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
      ListTile(
        title: Text(Strings.general),
        leading: CircleAvatar(
          child: Icon(
            Icons.settings,
            color: Colors.black,
          ),
          backgroundColor: Color.fromRGBO(46, 196, 182, 1),
        ),
        trailing: Icon(Icons.arrow_right_outlined),
        tileColor: Theme.of(context).cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Style.smallRoundEdgeRadius),
        ),
        onTap: () => _navigateToSettings(SettingsPage.GENERAL),
      ),
      Style.getVerticalSpacing(context: context, percent: 0.01),
      ListTile(
        title: Text(Strings.extensions),
        leading: CircleAvatar(
          child: Icon(
            Icons.extension_rounded,
            color: Colors.black,
          ),
          backgroundColor: Color.fromRGBO(255, 159, 28, 1),
        ),
        trailing: Icon(Icons.arrow_right_outlined),
        tileColor: Theme.of(context).cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Style.smallRoundEdgeRadius),
        ),
        onTap: () => Navigator.pushNamed(context, ExtensionsPage.routeName),
      ),
      Style.getVerticalSpacing(context: context, percent: 0.01),
      ListTile(
        title: Text(Strings.integrations),
        leading: CircleAvatar(
          child: Icon(
            Icons.merge,
            color: Colors.black,
          ),
          backgroundColor: Color.fromRGBO(255, 191, 105, 1),
        ),
        trailing: Icon(Icons.arrow_right_outlined),
        tileColor: Theme.of(context).cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Style.smallRoundEdgeRadius),
        ),
        onTap: () => _navigateToSettings(SettingsPage.INTEGRATIONS),
      ),
      Style.getVerticalSpacing(context: context, percent: 0.01),
      ListTile(
        title: Text(Strings.player),
        leading: CircleAvatar(
          child: Icon(
            Icons.play_arrow_rounded,
            color: Colors.black,
          ),
          backgroundColor: Color.fromRGBO(203, 243, 240, 1),
        ),
        trailing: Icon(Icons.arrow_right_outlined),
        tileColor: Theme.of(context).cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Style.smallRoundEdgeRadius),
        ),
        onTap: () => _navigateToSettings(SettingsPage.PLAYER),
      ),
      Style.getVerticalSpacing(context: context, percent: 0.01),
      ListTile(
        title: Text(Strings.more),
        leading: CircleAvatar(
          child: Icon(
            Icons.more_horiz,
            color: Colors.black,
          ),
          backgroundColor: Color.fromRGBO(233, 196, 106, 1),
        ),
        trailing: Icon(Icons.arrow_right_outlined),
        tileColor: Theme.of(context).cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Style.smallRoundEdgeRadius),
        ),
        onTap: () => _navigateToSettings(SettingsPage.MORE),
      ),
      Style.getVerticalSpacing(context: context, percent: 0.01),
      Style.getListTile(
        context: context,
        title: Strings.reportBug,
        trailing: Icon(Icons.arrow_right_outlined),
        leading: CircleAvatar(
          child: Icon(
            Icons.bug_report_rounded,
            color: Colors.black,
          ),
          backgroundColor: Color.fromRGBO(231, 111, 81, 1),
        ),
        onTap: _reportBug,
      ),
      Style.getListTile(
        context: context,
        title: "Rate CineNexa",
        leading: CircleAvatar(
          child: Icon(
            Icons.star_rounded,
            color: Colors.black,
          ),
          backgroundColor: Color.fromRGBO(255, 159, 28, 1),
        ),
        trailing: Icon(Icons.arrow_right_outlined),
        onTap: () {
          InAppReview.instance.openStoreListing();
        },
      ),
      Style.getVerticalSpacing(context: context),
      _buildAttribution(),
    ];
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

  Widget _buildProfileTile() {
    return Observer(builder: (_) {
      bool traktConnected =
          Provider.of<UserStore>(context, listen: false).traktStatus;

      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (userStore.user?.id != null)
                randomAvatar(
                  userStore.user!.id,
                  width: ScreenSize.getPercentOfWidth(context, 0.1),
                  height: ScreenSize.getPercentOfWidth(context, 0.1),
                ),
              if (userStore.user == null)
                randomAvatar(
                  SizeFormatter.getRandomString(10),
                  width: ScreenSize.getPercentOfWidth(context, 0.1),
                  height: ScreenSize.getPercentOfWidth(context, 0.1),
                ),
              SizedBox(
                width: 8,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userStore.user?.name ?? Strings.anonymous,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(Strings.trakt),
                      Padding(padding: EdgeInsets.all(2)),
                      Icon(
                        Icons.circle,
                        color: traktConnected ? Colors.green : Colors.red,
                        size: 12,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          if (userStore.user != null)
            IconButton(
              onPressed: () {
                Style.showConfirmationDialog(
                  context: context,
                  text: Strings.logoutConfirm,
                  onPressed: () => logout(),
                );
              },
              icon: Icon(Icons.logout_rounded),
            ),
          if (userStore.guestLogin)
            RoundedButton(
              child: Text(Strings.signIn),
              onPressed: () => logout(),
              type: RoundedButtonType.outlined,
            ),
        ],
      );
    });
  }

  void logout() async {
    Style.showLoadingDialog(context: context);
    await Provider.of<UserStore>(context, listen: false).logout();
    AdaptiveTheme.of(context).setLight();
    Navigator.pop(context);
    Navigator.pushNamedAndRemoveUntil(
      context,
      IntroPage.routeName,
      (route) => false,
    );
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
