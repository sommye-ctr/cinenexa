import 'package:mobx/mobx.dart';
import 'package:watrix/services/requests.dart';

import '../../models/base_model.dart';

part 'see_more_store.g.dart';

class SeeMoreStore extends _SeeMoreStore with _$SeeMoreStore {
  SeeMoreStore({required String future, required List<BaseModel> list})
      : super(future: future, list: list);
}

abstract class _SeeMoreStore with Store {
  final String future;

  @observable
  ObservableList<BaseModel> items;

  @observable
  int page = 1;

  _SeeMoreStore({
    required this.future,
    required List<BaseModel> list,
  }) : items = list.asObservable();

  @action
  Future _fetchItems() async {
    List<BaseModel> list = await Requests.titlesFuture(
      future,
      page: page,
    );
    items.addAll(list);
  }

  @action
  void pageEndReached() {
    page++;
    _fetchItems();
  }
}
