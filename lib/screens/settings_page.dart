import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:watrix/resources/strings.dart';

class SettingsPage extends StatefulWidget {
  static const String routeName = "/settings";
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AdaptiveThemeMode>(
      valueListenable: AdaptiveTheme.of(context).modeChangeNotifier,
      builder: (context, value, child) {
        return SettingsList(
          physics: BouncingScrollPhysics(),
          platform: DevicePlatform.iOS,
          shrinkWrap: true,
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
      },
    );
  }
}
