import 'package:flutter/material.dart';
import 'package:cinenexa/components/settings_general.dart';
import 'package:cinenexa/components/settings_integrations.dart';
import 'package:cinenexa/components/settings_more.dart';
import 'package:cinenexa/components/settings_player.dart';
import 'package:cinenexa/utils/screen_size.dart';
import 'package:cinenexa/widgets/custom_back_button.dart';

class SettingsPage extends StatefulWidget {
  static const String routeName = "/settings";
  static const int GENERAL = 0;
  static const int INTEGRATIONS = 1;
  static const int PLAYER = 2;
  static const int MORE = 4;

  final int type;
  const SettingsPage({
    Key? key,
    required this.type,
  }) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
            top: kToolbarHeight,
            left: ScreenSize.getPercentOfWidth(context, 0.01),
            right: ScreenSize.getPercentOfWidth(context, 0.01)),
        child: Stack(
          children: [
            LayoutBuilder(
              builder: (p0, p1) {
                switch (widget.type) {
                  case SettingsPage.GENERAL:
                    return SettingsGeneral();
                  case SettingsPage.INTEGRATIONS:
                    return SettingsIntegrations();
                  case SettingsPage.PLAYER:
                    return SettingsPlayer();
                  case SettingsPage.MORE:
                    return SettingsMore();
                  default:
                    return Container();
                }
              },
            ),
            Align(
              alignment: Alignment.topLeft,
              child: CustomBackButton(),
            ),
          ],
        ),
      ),
    );

    /* return ValueListenableBuilder<AdaptiveThemeMode>(
      valueListenable: AdaptiveTheme.of(context).modeChangeNotifier,
      builder: (context, value, child) {
        return Expanded(
          child: SettingsList(
            physics: BouncingScrollPhysics(),
            platform: DevicePlatform.iOS,
            shrinkWrap: true,
            contentPadding: EdgeInsets.only(bottom: kBottomNavigationBarHeight),
            sections: [
              SettingsSection(
                title: Text(Strings.general),
                tiles: [
                  SettingsTile.switchTile(
                    initialValue: value == AdaptiveThemeMode.dark,
                    onToggle: (boolean) {
                      if (boolean) {
                        AdaptiveTheme.of(context).setDark();
                        return;
                      }
                      AdaptiveTheme.of(context).setLight();
                    },
                    title: Text(Strings.darkMode),
                  ),
                  SettingsTile(title: Text("data")),
                ],
              ),
              SettingsSection(
                title: Text(Strings.integrations),
                tiles: [
                  SettingsTile.navigation(
                    title: Text("Trakt"),
                    onPressed: (context) {},
                  ),
                ],
              ),
              SettingsSection(
                title: Text(Strings.player),
                tiles: [
                  SettingsTile.navigation(
                    title: Text("Trakt"),
                    onPressed: (context) {},
                  ),
                ],
              ),
              SettingsSection(
                title: Text(Strings.extensions),
                tiles: [
                  SettingsTile.navigation(
                    title: Text("Trakt"),
                    onPressed: (context) {},
                  ),
                ],
              ),
              SettingsSection(
                title: Text(Strings.more),
                tiles: [
                  SettingsTile(
                    title: Text("Website"),
                  ),
                  SettingsTile(
                    title: Text("Extensions Documentation"),
                    description: Text("https://www.cinenexa.com/developer/"),
                  ),
                  SettingsTile(
                    title: Text("Telegram"),
                    description: Text("https://t.me/cinenexaa"),
                    leading: Icon(Icons.telegram),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    ); */
  }
}
