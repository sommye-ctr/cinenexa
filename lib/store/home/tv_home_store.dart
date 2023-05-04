import 'package:cinenexa/models/network/base_model.dart';
import 'package:mobx/mobx.dart';
part 'tv_home_store.g.dart';

class TvHomeStore = _TvHomeStoreBase with _$TvHomeStore;

abstract class _TvHomeStoreBase with Store {
  @observable
  int tabIndex = 1;

  @observable
  BaseModel? currentFocused;

  @observable
  bool railFocused = false;

  @action
  void changeIndex(int index) {
    tabIndex = index;
  }

  @action
  void changeCurrentFocused(BaseModel baseModel) {
    currentFocused = baseModel;
  }

  @action
  void changeRailFocused(bool value) {
    railFocused = value;
  }
}
