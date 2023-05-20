import 'package:cinenexa/resources/style.dart';
import 'package:cinenexa/store/watchlist/watchlist_store.dart';
import 'package:cinenexa/widgets/custom_checkbox_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/network/base_model.dart';
import '../../models/network/trakt/trakt_list.dart';
import '../../resources/strings.dart';
import '../../widgets/rounded_button.dart';

class DetailsAddList extends StatefulWidget {
  final BaseModel baseModel;
  final bool isInFavs;
  final VoidCallback onFavAdded;
  final VoidCallback onFavRemoved;
  const DetailsAddList(
      {required this.baseModel,
      required this.isInFavs,
      required this.onFavAdded,
      required this.onFavRemoved,
      Key? key})
      : super(key: key);

  @override
  State<DetailsAddList> createState() => _DetailsAddListState();
}

class _DetailsAddListState extends State<DetailsAddList> {
  late WatchListStore watchListStore;

  Map<int, TraktList?> selectedMap = {};
  bool favAdded = false;

  @override
  void initState() {
    watchListStore = Provider.of<WatchListStore>(context, listen: false);
    favAdded = widget.isInFavs;
    getCurrentListsForItem();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Center(
          child: Text(
            Strings.manageList,
            style: Style.headingStyle,
          ),
        ),
        Center(
          child: Text(
            Strings.manageListSubheading,
            style: TextStyle(color: Colors.grey),
          ),
        ),
        Style.getVerticalSpacing(context: context),
        UnconstrainedBox(
          child: AnimatedCrossFade(
            duration: Duration(milliseconds: 500),
            sizeCurve: Curves.decelerate,
            firstChild: RoundedButton(
              onPressed: () {
                setState(() {
                  favAdded = !favAdded;
                });
                widget.onFavAdded();
              },
              type: RoundedButtonType.filled,
              child: Row(
                children: [
                  Text(Strings.addToFav),
                  Icon(Icons.favorite, size: 20),
                ],
              ),
            ),
            secondChild: RoundedButton(
              onPressed: () {
                setState(() {
                  favAdded = !favAdded;
                });
                widget.onFavRemoved();
              },
              type: RoundedButtonType.outlined,
              child: Row(
                children: [
                  Text(Strings.removeFromFav),
                  Icon(Icons.favorite),
                ],
              ),
            ),
            layoutBuilder: (topChild, topKey, bottomChild, bottomKey) {
              return Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: 0,
                    child: bottomChild,
                    key: bottomKey,
                  ),
                  Positioned(
                    child: topChild,
                    key: topKey,
                  ),
                ],
              );
            },
            crossFadeState:
                favAdded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 24,
          ),
          child: CustomCheckBoxList(
            children: watchListStore.watchLists
                .map((element) => element.name)
                .toList(),
            selectedItems: selectedMap.keys.toList(),
            type: CheckBoxListType.grid,
            alwaysEnabled: false,
            singleSelect: false,
            onSelectionAdded: (values) {
              watchListStore.addItemtoList(
                baseModel: widget.baseModel,
                listId: watchListStore.watchLists
                    .singleWhere((element) => element.name == values.last)
                    .traktId,
              );
            },
            onSelectionRemoved: (values) {
              watchListStore.removeItemtoList(
                baseModel: widget.baseModel,
                listId: watchListStore.watchLists
                    .singleWhere((element) => element.name == values.last)
                    .traktId,
              );
            },
            delegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: 48 / 9,
              mainAxisSpacing: 8,
            ),
          ),
        ),
      ],
    );
  }

  void getCurrentListsForItem() {
    for (int i = 0; i < watchListStore.watchLists.length; i++) {
      TraktList element = watchListStore.watchLists[i];
      if (element.items
              .indexWhere((element) => element.id == widget.baseModel.id!) !=
          -1) {
        selectedMap.putIfAbsent(i, () => element);
      }
    }
  }
}
