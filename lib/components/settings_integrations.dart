import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restart_app/restart_app.dart';
import 'package:watrix/models/network/cinenexa_user.dart';
import 'package:watrix/models/network/trakt_user.dart';
import 'package:watrix/resources/strings.dart';
import 'package:watrix/resources/style.dart';
import 'package:watrix/screens/home_first_screen.dart';
import 'package:watrix/screens/login_configure_page.dart';
import 'package:watrix/services/network/utils.dart';
import 'package:watrix/store/user/user_store.dart';

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
            ],
          ),
        ),
      ],
    );
  }
}
