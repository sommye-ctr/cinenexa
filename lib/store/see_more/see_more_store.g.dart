// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'see_more_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SeeMoreStore on _SeeMoreStore, Store {
  late final _$itemsAtom = Atom(name: '_SeeMoreStore.items', context: context);

  @override
  ObservableList<BaseModel> get items {
    _$itemsAtom.reportRead();
    return super.items;
  }

  @override
  set items(ObservableList<BaseModel> value) {
    _$itemsAtom.reportWrite(value, super.items, () {
      super.items = value;
    });
  }

  late final _$pageAtom = Atom(name: '_SeeMoreStore.page', context: context);

  @override
  int get page {
    _$pageAtom.reportRead();
    return super.page;
  }

  @override
  set page(int value) {
    _$pageAtom.reportWrite(value, super.page, () {
      super.page = value;
    });
  }

  late final _$_fetchItemsAsyncAction =
      AsyncAction('_SeeMoreStore._fetchItems', context: context);

  @override
  Future<dynamic> _fetchItems() {
    return _$_fetchItemsAsyncAction.run(() => super._fetchItems());
  }

  late final _$_SeeMoreStoreActionController =
      ActionController(name: '_SeeMoreStore', context: context);

  @override
  void pageEndReached() {
    final _$actionInfo = _$_SeeMoreStoreActionController.startAction(
        name: '_SeeMoreStore.pageEndReached');
    try {
      return super.pageEndReached();
    } finally {
      _$_SeeMoreStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
items: ${items},
page: ${page}
    ''';
  }
}
