import 'package:cinenexa/components/tv/tv_subtitle_settings.dart';
import 'package:cinenexa/resources/settings_tile_obj.dart';
import 'package:cinenexa/screens/tv/tv_home_first.dart';
import 'package:cinenexa/store/tv_list/tv_list_store.dart';
import 'package:cinenexa/utils/keycode.dart';
import 'package:cinenexa/utils/screen_size.dart';
import 'package:cinenexa/utils/settings_indexer.dart';
import 'package:cinenexa/widgets/tv_horizontal_list.dart';
import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:mobx/mobx.dart';
import '../../resources/strings.dart';
import '../../resources/style.dart';
import '../../services/local/database.dart';
import '../../store/home/tv_home_store.dart';
import '../../store/user/user_store.dart';
import '../../widgets/user_profile.dart';
import 'package:provider/provider.dart';

import '../intro_page.dart';

class TvProfilePage extends StatefulWidget {
  final Stream<int> clickEvents;
  final TvHomeStore homeStore;
  const TvProfilePage(
      {required this.clickEvents, required this.homeStore, Key? key})
      : super(key: key);

  @override
  State<TvProfilePage> createState() => _TvProfilePageState();
}

class _TvProfilePageState extends State<TvProfilePage> {
  final int SEEK_INDEX = 2;
  final int FIT_INDEX = 3;
  Database database = Database();

  late TvListStore<SettingsTileObj> tvListStore;
  late List<VoidCallback> onClicks;
  late int seekDuration;
  late int defaultFit;

  @override
  void initState() {
    _fetch();
    tvListStore = TvListStore(
      focusChange: (item) {},
      items: Style.tvSettingTiles.asObservable(),
    );
    onClicks = [
      () {}, //trakt
      () {}, //sync
      _onSeek, // seek
      _onFit, // default fit
      _onSubtitle, // subtitle
      () async {
        Style.showLoadingDialog(context: context);
        await Provider.of<UserStore>(context, listen: false).logout();
        Navigator.pop(context);
        Navigator.pushNamedAndRemoveUntil(
          context,
          IntroPage.routeName,
          (route) => false,
        );
      }, //logout
      InAppReview.instance.openStoreListing, //rate
    ];

    widget.clickEvents.listen((event) {
      switch (event) {
        case KEY_RIGHT:
          if (widget.homeStore.railFocused) {
            widget.homeStore.changeRailFocused(false);
            tvListStore.changeFocus(true);
            return;
          }
          tvListStore.changeIndex(KEY_RIGHT);
          break;
        case KEY_LEFT:
          if (tvListStore.focusedIndex == 0 && !widget.homeStore.railFocused) {
            tvListStore.changeFocus(false);
            widget.homeStore.changeRailFocused(true);
            return;
          }
          tvListStore.changeIndex(KEY_LEFT);
          break;
        case KEY_CENTER:
          if (widget.homeStore.railFocused) return;
          onClicks[tvListStore.focusedIndex].call();
          break;
        default:
      }
    });
    super.initState();
  }

  void _fetch() async {
    seekDuration = await database.getSeekDuration();
    defaultFit = await database.getDefaultFit();
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: TvHomeFirst.CHILDREN_PADDING_RIGHT,
        top: 4,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          UserProfile(
            showSignIn: false,
            vertical: true,
          ),
          Style.getVerticalSpacing(context: context),
          TvHorizontalList<SettingsTileObj>.fromInititalValues(
            heading: "",
            widthPercentItem: 0.12,
            height: ScreenSize.getPercentOfHeight(context, 0.24),
            tvListStore: tvListStore,
            direction: Axis.horizontal,
            onWidgetBuildIndex: (item, index) {
              String title = item.string;
              if (index == SEEK_INDEX) {
                title += "\n${seekDuration.toString()}";
              } else if (index == FIT_INDEX) {
                title += "\n${Strings.fitTypes[defaultFit]}";
              }
              return Style.getCardListTile(
                context: context,
                title: title,
                leading: CircleAvatar(
                  child: Icon(
                    item.icon,
                    color: Colors.black,
                  ),
                  backgroundColor: item.bgColor,
                ),
              );
            },
          ),
          Text("Trakt info will show up here"),
        ],
      ),
    );
  }

  void _onSeek() {
    if (seekDuration == 10) {
      seekDuration = 30;
      database.addSeekDuration(30);
    } else {
      seekDuration = 10;
      database.addSeekDuration(10);
    }
    setState(() {});
  }

  void _onFit() {
    defaultFit = SettingsIndexer.getToggledFitIndex(defaultFit);
    database.addDefaultFit(defaultFit);
    setState(() {});
  }

  void _onSubtitle() {
    showDialog(
      context: context,
      builder: (context) {
        return TvSubtitleSettings();
      },
    );
  }
}
