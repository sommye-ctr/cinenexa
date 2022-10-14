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
      sections: [
        SettingsSection(
          title: Text(Strings.general),
          tiles: [
            SettingsTile.switchTile(
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
          title: Text("Integrations"),
          tiles: [
            SettingsTile.navigation(
              title: Text("Trakt"),
              onPressed: (context) {},
            ),
          ],
        ),
      ],
    );
  }
}
