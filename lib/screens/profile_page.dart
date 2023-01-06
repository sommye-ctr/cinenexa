import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:random_avatar/random_avatar.dart';
import 'package:cinenexa/resources/strings.dart';
import 'package:cinenexa/resources/style.dart';
import 'package:cinenexa/screens/intro_page.dart';
import 'package:cinenexa/screens/settings_page.dart';
import 'package:cinenexa/store/user/user_store.dart';
import 'package:cinenexa/utils/screen_size.dart';

class ProfilePage extends StatefulWidget {
  final Function()? onBack;
  const ProfilePage({Key? key, this.onBack}) : super(key: key);

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
    return WillPopScope(
      onWillPop: () async {
        if (widget.onBack != null) {
          widget.onBack!();
          return false;
        }
        return true;
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Style.getVerticalHorizontalSpacing(context: context),
              _buildProfileTile(),
              Style.getVerticalHorizontalSpacing(context: context),
              _buildStatCardsTile(),
              Style.getVerticalHorizontalSpacing(context: context),
              _buildSettingsTabs(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsTabs() {
    return Expanded(
      child: ListView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(bottom: kBottomNavigationBarHeight),
        children: [
          ListTile(
            title: Text(Strings.general),
            leading: Icon(Icons.settings),
            trailing: Icon(Icons.arrow_right_outlined),
            tileColor: Theme.of(context).cardColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Style.smallRoundEdgeRadius),
            ),
            onTap: () => _navigateToSettings(SettingsPage.GENERAL),
          ),
          Style.getVerticalSpacing(context: context, percent: 0.01),
          ListTile(
            title: Text(Strings.integrations),
            leading: Icon(Icons.merge),
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
            leading: Icon(Icons.play_arrow_rounded),
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
            leading: Icon(Icons.more_horiz),
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
            leading: Icon(Icons.bug_report_rounded),
            onTap: _reportBug,
          ),
        ],
      ),
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
              SizedBox(
                width: 8,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userStore.user?.name ?? Strings.unknown,
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
          IconButton(
            onPressed: () {
              Style.showConfirmationDialog(
                context: context,
                text: Strings.logoutConfirm,
                onPressed: () async {
                  Style.showLoadingDialog(context: context);
                  await Provider.of<UserStore>(context, listen: false).logout();
                  AdaptiveTheme.of(context).setLight();
                  Navigator.pop(context);
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    IntroPage.routeName,
                    (route) => false,
                  );
                },
              );
            },
            icon: Icon(Icons.logout_rounded),
          ),
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
