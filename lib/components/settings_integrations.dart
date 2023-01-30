import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinenexa/screens/extension_config_page.dart';
import 'package:cinenexa/store/extensions/extensions_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restart_app/restart_app.dart';
import 'package:cinenexa/models/network/trakt_user.dart';
import 'package:cinenexa/resources/strings.dart';
import 'package:cinenexa/resources/style.dart';
import 'package:cinenexa/screens/login_configure_page.dart';
import 'package:cinenexa/store/user/user_store.dart';

class SettingsIntegrations extends StatefulWidget {
  const SettingsIntegrations({Key? key}) : super(key: key);

  @override
  State<SettingsIntegrations> createState() => _SettingsIntegrationsState();
}

class _SettingsIntegrationsState extends State<SettingsIntegrations> {
  bool traktConnected = false;
  TraktUser? user;

  @override
  void initState() {
    super.initState();
    traktConnected = Provider.of<UserStore>(context, listen: false).traktStatus;
    if (traktConnected) _fetch();
  }

  void _fetch() async {
    user = await Provider.of<UserStore>(context, listen: false)
        .fetchUserTraktProfile();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          Strings.integrations,
          style: Style.headingStyle,
        ),
        Expanded(
          child: ListView(
            children: [
              Style.getListTile(
                context: context,
                title: Strings.traktStatus,
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.circle,
                      color: traktConnected ? Colors.green : Colors.red,
                      size: 12,
                    ),
                    Padding(padding: EdgeInsets.all(2)),
                    Text(traktConnected
                        ? Strings.connected
                        : Strings.disconnected),
                  ],
                ),
              ),
              if (traktConnected)
                Style.getListTile(
                  context: context,
                  title: Strings.traktProfile,
                  trailing: user != null
                      ? Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircleAvatar(
                              backgroundImage: CachedNetworkImageProvider(
                                  user?.avatar ?? ""),
                            ),
                            Padding(padding: EdgeInsets.all(2)),
                            Text("${user?.name}"),
                          ],
                        )
                      : null,
                ),
              if (!traktConnected)
                Style.getListTile(
                  context: context,
                  title: Strings.connectTrakt,
                  onTap: () => Navigator.pushNamed(
                    context,
                    LoginConfigurePage.routeName,
                    arguments: false,
                  ),
                ),
              if (traktConnected)
                Style.getListTile(
                  context: context,
                  title: Strings.disconnectTrakt,
                  onTap: () async {
                    Style.showConfirmationDialog(
                      context: context,
                      text: Strings.disconnectTraktConfirm,
                      onPressed: () async {
                        await Provider.of<UserStore>(context, listen: false)
                            .disconnectTrakt();
                        Restart.restartApp();
                      },
                    );
                  },
                ),
              Style.getListTile(
                context: context,
                title: "FOrm",
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    ExtensionConfig.routeName,
                    arguments: {
                      "extension":
                          Provider.of<ExtensionsStore>(context, listen: false)
                              .discoverExtensions!
                              .first,
                      "json":
                          "[{\"id\":\"q-genre\",\"type\":\"checkbox\",\"title\":\"Genres\",\"description\":\"Selectthegenres\",\"fields\":[\"Action\",\"Adventure\",\"Comedy\",\"Drama\"],\"required\":true},{\"id\":\"q-country\",\"type\":\"dropdown\",\"title\":\"Country\",\"description\":\"Selectthecountries\",\"fields\":[\"USA\",\"UK\",\"Germany\",\"France\"],\"required\":false},{\"id\":\"q-lang\",\"type\":\"radio\",\"title\":\"Language\",\"description\":\"Selectthelanguage\",\"fields\":[\"English\",\"German\",\"Hindi\",\"Arabic\"],\"required\":true},{\"id\":\"q-key\",\"type\":\"text\",\"title\":\"APIkey\",\"description\":\"Enteryourapikey\",\"required\":true,\"maxLines\":4,\"inputType\":\"string|number\"},{\"id\":\"q-cars\",\"type\":\"checkbox\",\"title\":\"Cars\",\"description\":\"Selectthecars\",\"fields\":[\"Mustang\",\"GWagon\",\"Audi\",\"Ferrari\"],\"required\":true}]",
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
