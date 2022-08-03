import 'package:mobx/mobx.dart';
import 'package:watrix/services/network/requests.dart';

import '../../models/network/base_model.dart';

part 'see_more_store.g.dart';

class SeeMoreStore extends _SeeMoreStore with _$SeeMoreStore {
  SeeMoreStore(
      {required String? future,
      required List<BaseModel> list,
      required bool isLazyLoad})
      : super(future: future, list: list, isLazyLoad: isLazyLoad);
}

abstract class _SeeMoreStore with Store {
  final String? future;
  final bool isLazyLoad;

  @observable
  ObservableList<BaseModel> items;

  @observable
  int page = 1;

  _SeeMoreStore({
    required this.future,
    required List<BaseModel> list,
    required this.isLazyLoad,
  }) : items = list.asObservable();

  @action
  Future _fetchItems() async {
    List<BaseModel> list = await Requests.titlesFuture(
      future!,
      page: page,
    );
    items.addAll(list);
  }

  @action
  void pageEndReached() {
    if (isLazyLoad) {
      page++;
      _fetchItems();
    }
  }
}
