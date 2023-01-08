import 'package:flutter/cupertino.dart';
import 'package:cinenexa/resources/strings.dart';
import 'package:cinenexa/resources/style.dart';
import 'package:cinenexa/services/local/database.dart';
import 'package:cinenexa/services/network/trakt_oauth_client.dart';
import 'package:cinenexa/widgets/custom_checkbox_list.dart';

class SettingsPlayer extends StatefulWidget {
  const SettingsPlayer({Key? key}) : super(key: key);

  @override
  State<SettingsPlayer> createState() => _SettingsPlayerState();
}

class _SettingsPlayerState extends State<SettingsPlayer> {
  bool alwaysExternalPlayer = false;
  bool autoSubtitle = false;
  int? seekDuration;

  late Database database;

  @override
  void initState() {
    super.initState();
    database = Database();
    _fetch();
  }

  void _fetch() async {
    alwaysExternalPlayer = await database.getAlwaysExternalPlayer();
    autoSubtitle = await database.getAutoSelectSubtitle();
    seekDuration = await database.getSeekDuration();
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          Strings.player,
          style: Style.headingStyle,
        ),
        Expanded(
          child: ListView(
            children: [
              Style.getListTile(
                context: context,
                title: Strings.alwaysExternalPlayer,
                trailing: CupertinoSwitch(
                  value: alwaysExternalPlayer,
                  onChanged: (value) async {
                    alwaysExternalPlayer = value;
                    await database.addAlwaysExternalPlayer(value);
                    setState(() {});
                  },
                ),
              ),
              Style.getListTile(
                context: context,
                title: Strings.autoSelectSubtitle,
                trailing: CupertinoSwitch(
                  value: autoSubtitle,
                  onChanged: (value) async {
                    autoSubtitle = value;
                    await database.addAutoSelectSubtitle(value);
                    setState(() {});
                  },
                ),
              ),
              Style.getListTile(
                context: context,
                title: Strings.seekDuration,
                trailing: seekDuration != null
                    ? CustomCheckBoxList(
                        children: ["10s", "30s"],
                        type: CheckBoxListType.list,
                        selectedItems: [_getSelectedIndex()],
                        alwaysEnabled: true,
                        singleSelect: true,
                        onSelectionAdded: (values) async {
                          String value = values.first;
                          if (value == "10s") {
                            await database.addSeekDuration(10);
                          } else {
                            await database.addSeekDuration(30);
                          }
                        },
                      )
                    : null,
              ),
            ],
          ),
        ),
      ],
    );
  }

  int _getSelectedIndex() {
    if (seekDuration == 30) {
      return 1;
    }
    return 0;
  }
}
