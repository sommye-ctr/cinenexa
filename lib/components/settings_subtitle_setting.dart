import 'package:cinenexa/resources/strings.dart';
import 'package:cinenexa/resources/style.dart';
import 'package:cinenexa/utils/screen_size.dart';
import 'package:cinenexa/widgets/custom_back_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../services/local/database.dart';

class SubtitleSettings extends StatefulWidget {
  static const String routeName = "/subtitle_settings";
  const SubtitleSettings({Key? key}) : super(key: key);

  @override
  State<SubtitleSettings> createState() => _SubtitleSettingsState();
}

class _SubtitleSettingsState extends State<SubtitleSettings> {
  final double FONT_SIZE_MIN = 10;
  final double FONT_SIZE_MAX = 30;
  final double POSITION_MIN = 20;
  final double POSITION_MAX = 200;

  int _fontSize = 14;
  int _position = 20;
  bool enableBg = false;
  bool autoSubtitle = false;

  final Database database = Database();

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    _fontSize = await database.getSubFontSize();
    _position = await database.getSubPosition();
    enableBg = await database.getSubBg();
    autoSubtitle = await database.getAutoSelectSubtitle();
    if (mounted) setState(() {});
  }

  double _calculatePosition(int padding) {
    double width = ScreenSize.getPercentOfWidth(context, 1);
    double emulatedHeight = ScreenSize.getPercentOfHeight(context, 0.25);

    return (emulatedHeight * padding) / width;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          top: kToolbarHeight,
          right: 8,
          left: 8,
        ),
        child: Column(
          children: [
            Stack(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: CustomBackButton(),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    Strings.subtitle,
                    style: Style.headingStyle,
                  ),
                ),
              ],
            ),
            Style.getVerticalSpacing(context: context),
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  width: ScreenSize.getPercentOfWidth(context, 1),
                  height: ScreenSize.getPercentOfHeight(context, 0.25),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius:
                        BorderRadius.circular(Style.smallRoundEdgeRadius),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(bottom: (_calculatePosition(_position))),
                  child: Text(
                    Strings.subtitlePreview,
                    textScaleFactor: MediaQuery.of(context).size.aspectRatio,
                    style: TextStyle(
                      fontSize: _fontSize.toDouble(),
                      backgroundColor: enableBg ? Colors.black : null,
                    ),
                  ),
                ),
              ],
            ),
            Style.getVerticalSpacing(context: context),
            _buildFontSize(),
            _buildPosition(),
            _buildBgColor(),
            Style.getVerticalSpacing(context: context),
            Divider(),
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
          ],
        ),
      ),
    );
  }

  Widget _buildBgColor() {
    return Style.getListTile(
      context: context,
      title: Strings.backGround,
      trailing: CupertinoSwitch(
        value: enableBg,
        onChanged: (value) async {
          enableBg = value;
          await database.addSubBgEnabled(value);
          setState(() {});
        },
      ),
    );
  }

  Widget _buildPosition() {
    return Style.getListTile(
      context: context,
      title: Strings.position,
      trailing: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.remove),
            onPressed: () async {
              final newValue = _position - 10;
              _position = newValue.clamp(POSITION_MIN, POSITION_MAX).toInt();
              await database.addSubPosition(_position);
              setState(() {});
            },
          ),
          Text('${_position}'),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {
              final newValue = _position + 10;
              _position = newValue.clamp(POSITION_MIN, POSITION_MAX).toInt();
              await database.addSubPosition(_position);
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFontSize() {
    return Style.getListTile(
      context: context,
      title: Strings.fontSize,
      trailing: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.remove),
            onPressed: () async {
              final newValue = _fontSize - 5;
              _fontSize = newValue.clamp(FONT_SIZE_MIN, FONT_SIZE_MAX).toInt();
              await database.addSubFontSize(_fontSize);
              setState(() {});
            },
          ),
          Text('${_fontSize}'),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {
              final newValue = _fontSize + 5;
              _fontSize = newValue.clamp(FONT_SIZE_MIN, FONT_SIZE_MAX).toInt();
              await database.addSubFontSize(_fontSize);
              setState(() {});
            },
          ),
        ],
      ),
    );
  }
}
