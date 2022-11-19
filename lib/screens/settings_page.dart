import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:watrix/resources/strings.dart';

import '../resources/my_theme.dart';

class SettingsPage extends StatelessWidget {
  static const String routeName = "/settings";
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SettingsList(
      physics: BouncingScrollPhysics(),
      platform: DevicePlatform.iOS,
      shrinkWrap: true,
      darkTheme: SettingsThemeData(
        settingsListBackground: Theme.of(context).backgroundColor,
      ),
      lightTheme: SettingsThemeData(
        settingsListBackground: Theme.of(context).backgroundColor,
      ),
      sections: [
        SettingsSection(
          tiles: [
            SettingsTile.switchTile(
              leading: Icon(Icons.dark_mode_rounded),
              initialValue:
                  Provider.of<MyTheme>(context, listen: false).darkMode,
              onToggle: (value) {
                Provider.of<MyTheme>(context, listen: false).changeTheme(value);
              },
              title: Text(Strings.darkMode),
            ),
          ],
        ),
        SettingsSection(
          tiles: [
            SettingsTile.navigation(
              leading: Icon(Icons.settings),
              title: Text("General"),
              onPressed: (context) {},
            ),
            SettingsTile.navigation(
              leading: Icon(Icons.play_arrow_rounded),
              title: Text("Player"),
              onPressed: (context) {},
            ),
            SettingsTile.navigation(
              leading: Icon(Icons.play_arrow_rounded),
              title: Text("Extensions"),
              onPressed: (context) {},
            ),
            SettingsTile.navigation(
              leading: Icon(Icons.play_arrow_rounded),
              title: Text("Account"),
              onPressed: (context) {},
            ),
            SettingsTile.navigation(
              leading: Icon(Icons.play_arrow_rounded),
              title: Text("More"),
              onPressed: (context) {},
            ),
          ],
        ),
      ],
    );
  }
}
