import 'package:mobx/mobx.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../utils/keycode.dart';
part 'tv_list_store.g.dart';

class TvListStore<T> = _TvListStoreBase<T> with _$TvListStore;

abstract class _TvListStoreBase<T> with Store {
  ItemScrollController? scrollController;
  final Future<List<T>>? future;
  Function(T item) focusChange;

  @observable
  ObservableList<T>? items;

  @observable
  int focusedIndex = 0;

  @observable
  bool isListFocused = false;

  _TvListStoreBase({required this.focusChange, this.future, this.items}) {
    _init();
  }

  void setScrollController(ItemScrollController scrollController) {
    this.scrollController = scrollController;
  }

  @action
  Future _init() async {
    if (future != null) {
      items = <T>[].asObservable();
      items!.addAll(await future!);
    }
  }

  @action
  void changeIndex(int tap) {
    switch (tap) {
      case KEY_LEFT:
        if (focusedIndex != 0) {
          focusedIndex--;
          focusChange.call(items![focusedIndex]);
        }
        break;
      case KEY_RIGHT:
        if (focusedIndex != (items!.length - 1)) {
          focusedIndex++;
          focusChange.call(items![focusedIndex]);
        }
        break;
      default:
    }
    scrollController?.scrollTo(
      index: focusedIndex,
      duration: Duration(milliseconds: 500),
    );
  }

  @action
  void changeFocus(bool focused) {
    isListFocused = focused;
    if (focused) focusChange.call(items![focusedIndex]);
  }
}
