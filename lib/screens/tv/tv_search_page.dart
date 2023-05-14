import 'package:cinenexa/models/network/enums/entity_type.dart';
import 'package:cinenexa/resources/custom_scroll_behavior.dart';
import 'package:cinenexa/resources/strings.dart';
import 'package:cinenexa/resources/style.dart';
import 'package:cinenexa/screens/tv/tv_home_first.dart';
import 'package:cinenexa/services/network/repository.dart';
import 'package:cinenexa/store/home/tv_home_store.dart';
import 'package:cinenexa/store/tv_list/tv_list_store.dart';
import 'package:cinenexa/utils/keycode.dart';
import 'package:cinenexa/widgets/tv_horizontal_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../models/network/base_model.dart';
import '../details_page.dart';

class TvSearchPage extends StatefulWidget {
  final Stream<int> clickEvents;
  final TvHomeStore tvHomeStore;

  const TvSearchPage(
      {required this.clickEvents, required this.tvHomeStore, Key? key})
      : super(key: key);

  @override
  State<TvSearchPage> createState() => _TvSearchPageState();
}

class _TvSearchPageState extends State<TvSearchPage> {
  FocusNode textFocus = FocusNode();
  final TextEditingController textEditingController = TextEditingController();
  late TvListStore<BaseModel> movieListStore;
  late TvListStore<BaseModel> showListStore;
  final ItemScrollController scrollController = ItemScrollController();
  final Duration duration = Duration(milliseconds: 500);

  BaseModel? selected;

  @override
  void initState() {
    widget.clickEvents.listen((event) => onKeyEvent(event));
    movieListStore = TvListStore(
      focusChange: (item) {
        selected = item;
      },
    );
    showListStore = TvListStore(
      focusChange: (item) {
        selected = item;
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: TvHomeFirst.CHILDREN_PADDING_TOP,
        right: TvHomeFirst.CHILDREN_PADDING_RIGHT,
      ),
      child: Column(
        children: [
          TextField(
            autofocus: true,
            focusNode: textFocus,
            controller: textEditingController,
            onChanged: (value) {},
            onEditingComplete: () {
              if (textEditingController.value.text.isEmpty) {
                movieListStore.changeFuture(null);
                return;
              }
              movieListStore.changeFuture(Repository.search(
                textEditingController.value.text,
                EntityType.movie,
              ));
              showListStore.changeFuture(Repository.search(
                textEditingController.value.text,
                EntityType.tv,
              ));

              textFocus.unfocus();
              movieListStore.changeFocus(true);
            },
            textInputAction: TextInputAction.search,
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(
              hintText: Strings.searchTextFieldHint,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Style.smallRoundEdgeRadius),
              ),
            ),
          ),
          Style.getVerticalSpacing(context: context, percent: 0.08),
          ScrollConfiguration(
            behavior: CustomScrollBehavior(),
            child: Expanded(
              child: ScrollablePositionedList.separated(
                itemScrollController: scrollController,
                itemCount: 2,
                separatorBuilder: (context, index) =>
                    Style.getVerticalSpacing(context: context),
                itemBuilder: (context, index) {
                  bool movie = index == 0;
                  return TvHorizontalList(
                    heading: movie ? Strings.movies : Strings.shows,
                    height: Style.getMovieTileHeight(
                        context: context, widthPercent: 0.145),
                    widthPercentItem: 0.145,
                    tvListStore: movie ? movieListStore : showListStore,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onKeyEvent(int event) {
    bool railFocused = widget.tvHomeStore.railFocused;
    switch (event) {
      case KEY_CENTER:
        if (selected != null) {
          Navigator.pushNamed(
            context,
            DetailsPage.routeName,
            arguments: selected,
          );
        }
        break;
      case KEY_LEFT:
        if (movieListStore.isListFocused) {
          if (movieListStore.focusedIndex == 0) {
            widget.tvHomeStore.changeRailFocused(true);
            return;
          }
          movieListStore.changeIndex(KEY_LEFT);
          return;
        }

        if (showListStore.isListFocused) {
          if (showListStore.focusedIndex == 0) {
            widget.tvHomeStore.changeRailFocused(true);
            return;
          }
          showListStore.changeIndex(KEY_LEFT);
          return;
        }

        if (!railFocused) {
          widget.tvHomeStore.changeRailFocused(true);
          return;
        }

        break;
      case KEY_RIGHT:
        if (railFocused) {
          widget.tvHomeStore.changeRailFocused(false);
          if (!movieListStore.isListFocused && !showListStore.isListFocused)
            textFocus.requestFocus();
          return;
        }
        if (movieListStore.isListFocused) {
          movieListStore.changeIndex(KEY_RIGHT);
          return;
        }
        if (showListStore.isListFocused) showListStore.changeIndex(KEY_RIGHT);
        break;
      case KEY_DOWN:
        if (railFocused) {
          widget.tvHomeStore.changeIndex(1);
          return;
        }

        if (movieListStore.isListFocused) {
          movieListStore.changeFocus(false);
          showListStore.changeFocus(true);
          scrollController.scrollTo(index: 1, duration: duration);
          return;
        }

        if (!showListStore.isListFocused) {
          textFocus.unfocus();
          movieListStore.changeFocus(true);
        }

        break;
      case KEY_UP:
        if (!railFocused) {
          if (movieListStore.isListFocused) {
            textFocus.requestFocus();
            movieListStore.changeFocus(false);
            return;
          }

          if (showListStore.isListFocused) {
            showListStore.changeFocus(false);
            movieListStore.changeFocus(true);
            scrollController.scrollTo(index: 0, duration: duration);
          }
        }
        break;
      case KEY_BACKSPACE:
        if (!widget.tvHomeStore.railFocused) {
          textFocus.unfocus();
        }
        break;

      default:
    }
    SystemSound.play(SystemSoundType.click);
  }
}
