import 'package:cinenexa/utils/screen_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:cinenexa/resources/strings.dart';
import 'package:cinenexa/resources/style.dart';
import 'package:cinenexa/services/local/database.dart';
import 'package:cinenexa/widgets/custom_checkbox_list.dart';
import 'package:flutter/material.dart';

class SettingsPlayer extends StatefulWidget {
  const SettingsPlayer({Key? key}) : super(key: key);

  @override
  State<SettingsPlayer> createState() => _SettingsPlayerState();
}

class _SettingsPlayerState extends State<SettingsPlayer> {
  bool autoSubtitle = false;
  int? seekDuration;
  int? defaultFit, maxCache;

  late Database database;

  @override
  void initState() {
    super.initState();
    database = Database();
    _fetch();
  }

  void _fetch() async {
    autoSubtitle = await database.getAutoSelectSubtitle();
    seekDuration = await database.getSeekDuration();
    defaultFit = await database.getDefaultFit();
    maxCache = await database.getMaxCache();
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
                title: Strings.autoSelectSubtitle,
                subtitle: Strings.autoSelectSubtitleSub,
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
                subtitle: Strings.seekDurationSub,
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
              Style.getListTile(
                context: context,
                title: Strings.defaultFit,
                subtitle: Strings.defaultFitSub,
                trailing: defaultFit != null
                    ? /* Container(
                        width: ScreenSize.getPercentOfWidth(context, 0.2),
                        child: CustomCheckBoxList(
                          children: Strings.fitTypes,
                          type: CheckBoxListType.grid,
                          selectedItems: [defaultFit!],
                          alwaysEnabled: true,
                          singleSelect: true,
                          delegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                          onSelectionAdded: (values) async {
                            await database.addDefaultFit(
                                Strings.fitTypes.indexOf(values.first));
                          },
                        ),
                      ) */
                    DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          alignment: Alignment.centerLeft,
                          borderRadius:
                              BorderRadius.circular(Style.largeRoundEdgeRadius),
                          value: Strings.fitTypes[defaultFit!],
                          menuMaxHeight:
                              ScreenSize.getPercentOfHeight(context, 0.25),
                          items: Strings.fitTypes.map((e) {
                            return DropdownMenuItem(
                              child: Text(e),
                              value: e,
                            );
                          }).toList(),
                          onChanged: (value) async {
                            if (value != Strings.fitTypes[defaultFit!]) {
                              defaultFit = Strings.fitTypes.indexOf(value!);
                              await database.addDefaultFit(defaultFit!);
                              setState(() {});
                            }
                          },
                        ),
                      )
                    : null,
              ),
              Style.getListTile(
                context: context,
                title: Strings.maxCacheSize,
                subtitle: Strings.maxCacheSub,
                trailing: maxCache != null
                    ? /* Container(
                        width: ScreenSize.getPercentOfWidth(context, 0.2),
                        child: CustomCheckBoxList(
                          children: Strings.maxCacheSizes,
                          type: CheckBoxListType.grid,
                          selectedItems: [defaultFit!],
                          alwaysEnabled: true,
                          delegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                          singleSelect: true,
                          onSelectionAdded: (values) async {
                            await database.addMaxCache(
                                Strings.maxCacheSizes.indexOf(values.first));
                            Style.showToast(
                                context: context,
                                text: Strings.restartAppToEffective);
                          },
                        ),
                      ) */
                    DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          alignment: Alignment.centerLeft,
                          borderRadius:
                              BorderRadius.circular(Style.largeRoundEdgeRadius),
                          value: Strings.maxCacheSizes[maxCache!],
                          menuMaxHeight:
                              ScreenSize.getPercentOfHeight(context, 0.25),
                          items: Strings.maxCacheSizes.map((e) {
                            return DropdownMenuItem(
                              child: Text(e),
                              value: e,
                            );
                          }).toList(),
                          onChanged: (value) async {
                            if (value != Strings.maxCacheSizes[maxCache!]) {
                              maxCache = Strings.maxCacheSizes.indexOf(value!);
                              await database.addMaxCache(maxCache!);
                              setState(() {});
                            }
                          },
                        ),
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
