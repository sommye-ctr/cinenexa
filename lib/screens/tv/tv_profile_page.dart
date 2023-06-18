import 'package:cinenexa/resources/settings_tile_obj.dart';
import 'package:cinenexa/screens/tv/tv_home_first.dart';
import 'package:cinenexa/store/tv_list/tv_list_store.dart';
import 'package:cinenexa/utils/keycode.dart';
import 'package:cinenexa/utils/screen_size.dart';
import 'package:cinenexa/widgets/tv_horizontal_list.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import '../../resources/style.dart';
import '../../store/home/tv_home_store.dart';
import '../../store/user/user_store.dart';
import '../../widgets/user_profile.dart';

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
  late TvListStore<SettingsTileObj> tvListStore;

  @override
  void initState() {
    tvListStore = TvListStore(
      focusChange: (item) {},
      items: Style.tvSettingTiles.asObservable(),
    );
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
        default:
      }
    });
    super.initState();
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
            onWidgetBuild: (item) {
              return Style.getCardListTile(
                context: context,
                title: item.string,
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
}
