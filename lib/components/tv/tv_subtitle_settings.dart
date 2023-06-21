import 'package:cinenexa/components/mobile/settings_subtitle_setting.dart';
import 'package:cinenexa/resources/strings.dart';
import 'package:cinenexa/services/local/database.dart';
import 'package:cinenexa/utils/keycode.dart';
import 'package:cinenexa/widgets/tv_drawer.dart';
import 'package:cinenexa/widgets/tv_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../resources/style.dart';
import '../../utils/screen_size.dart';
import '../../widgets/tv_switch.dart';

class TvSubtitleSettings extends StatefulWidget {
  const TvSubtitleSettings({Key? key}) : super(key: key);

  @override
  State<TvSubtitleSettings> createState() => _TvSubtitleSettingsState();
}

class _TvSubtitleSettingsState extends State<TvSubtitleSettings> {
  final FocusNode focusNode = FocusNode();
  final Database database = Database();

  int fontSize = 14;
  int position = 20;
  bool enableBg = false;
  bool autoSubtitle = false;

  int yfocus = 0;

  late List<TvWidgetController> controller;
  @override
  void initState() {
    _fetch();
    controller = [
      TvWidgetController<double>(
        value: fontSize.toDouble(),
        active: true,
        max: SubtitleSettings.FONT_SIZE_MAX,
        min: SubtitleSettings.FONT_SIZE_MIN,
        step: SubtitleSettings.FONT_SIZE_STEP,
      ),
      TvWidgetController<double>(
        value: position.toDouble(),
        active: false,
        max: SubtitleSettings.POSITION_MAX,
        min: SubtitleSettings.POSITION_MIN,
        step: SubtitleSettings.POSITION_STEP,
      ),
      TvWidgetController<bool>(value: enableBg, active: false),
      TvWidgetController<bool>(value: autoSubtitle, active: false),
    ];
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      focusNode.requestFocus();
    });
    super.initState();
  }

  Future _fetch() async {
    fontSize = await database.getSubFontSize();
    position = await database.getSubPosition();
    enableBg = await database.getSubBg();
    autoSubtitle = await database.getAutoSelectSubtitle();

    controller[0].changeValue(fontSize.toDouble());
    controller[1].changeValue(position.toDouble());
    controller[2].changeValue(enableBg);
    controller[3].changeValue(autoSubtitle);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RawKeyboardListener(
        focusNode: focusNode,
        onKey: (event) {
          if (!(event is RawKeyDownEvent)) {
            return;
          }
          RawKeyEventDataAndroid rawKeyEventData =
              event.data as RawKeyEventDataAndroid;

          _onKey(rawKeyEventData.keyCode);
        },
        child: TvDrawer(
          leftChild: Container(
            height: ScreenSize.getPercentOfHeight(context, 0.24),
            child: Style.getCardListTile(
              context: context,
              title: Style.tvSettingTiles[4].string,
              leading: CircleAvatar(
                child: Icon(
                  Style.tvSettingTiles[4].icon,
                  color: Colors.black,
                ),
                backgroundColor: Style.tvSettingTiles[4].bgColor,
              ),
            ),
          ),
          rightChild: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TvSlider(
                  controller: controller[0],
                  heading: Strings.fontSize,
                ),
                Style.getVerticalSpacing(context: context),
                TvSlider(
                  controller: controller[1],
                  heading: Strings.position,
                ),
                Style.getVerticalSpacing(context: context),
                TvSwitch(
                  widgetController: controller[2],
                  title: Strings.backGround,
                  subtitle: "",
                ),
                Style.getVerticalSpacing(context: context),
                TvSwitch(
                  widgetController: controller[3],
                  title: Strings.autoSelectSubtitle,
                  subtitle: Strings.autoSelectSubtitleSub,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onKey(int keycode) {
    switch (keycode) {
      case KEY_DOWN:
        controller[yfocus].changeStatus(false);
        yfocus++;
        controller[yfocus].changeStatus(true);
        break;
      case KEY_RIGHT:
        if (yfocus == 0) {
          double value = controller[yfocus].seekForwardSlider();
          database.addSubFontSize(value.toInt());
        } else if (yfocus == 1) {
          double value = controller[yfocus].seekForwardSlider();
          database.addSubPosition(value.toInt());
        }

        break;
      case KEY_LEFT:
        if (yfocus == 0) {
          double value = controller[yfocus].seekBackwardSlider();
          database.addSubFontSize(value.toInt());
        } else if (yfocus == 1) {
          double value = controller[yfocus].seekBackwardSlider();
          database.addSubPosition(value.toInt());
        }
        break;
      case KEY_UP:
        controller[yfocus].changeStatus(false);
        yfocus--;
        controller[yfocus].changeStatus(true);
        break;
      case KEY_CENTER:
        if (yfocus == 2) {
          controller[yfocus].changeValue(!controller[yfocus].value);
          database.addSubBgEnabled(controller[yfocus].value);
        } else if (yfocus == 3) {
          controller[yfocus].changeValue(!controller[yfocus].value);
          database.addAutoSelectSubtitle(controller[yfocus].value);
        }
        break;
      default:
    }
  }
}
