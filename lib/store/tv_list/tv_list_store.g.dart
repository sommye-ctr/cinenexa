// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tv_list_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TvListStore<T> on _TvListStoreBase<T>, Store {
  late final _$itemsAtom =
      Atom(name: '_TvListStoreBase.items', context: context);

  @override
  ObservableList<T>? get items {
    _$itemsAtom.reportRead();
    return super.items;
  }

  @override
  set items(ObservableList<T>? value) {
    _$itemsAtom.reportWrite(value, super.items, () {
      super.items = value;
    });
  }

  late final _$focusedIndexAtom =
      Atom(name: '_TvListStoreBase.focusedIndex', context: context);

  @override
  int get focusedIndex {
    _$focusedIndexAtom.reportRead();
    return super.focusedIndex;
  }

  @override
  set focusedIndex(int value) {
    _$focusedIndexAtom.reportWrite(value, super.focusedIndex, () {
      super.focusedIndex = value;
    });
  }

  late final _$isListFocusedAtom =
      Atom(name: '_TvListStoreBase.isListFocused', context: context);

  @override
  bool get isListFocused {
    _$isListFocusedAtom.reportRead();
    return super.isListFocused;
  }

  @override
  set isListFocused(bool value) {
    _$isListFocusedAtom.reportWrite(value, super.isListFocused, () {
      super.isListFocused = value;
    });
  }

  late final _$_initAsyncAction =
      AsyncAction('_TvListStoreBase._init', context: context);

  @override
  Future<dynamic> _init() {
    return _$_initAsyncAction.run(() => super._init());
  }

  late final _$_TvListStoreBaseActionController =
      ActionController(name: '_TvListStoreBase', context: context);

  @override
  void changeFuture(Future<List<T>>? future) {
    final _$actionInfo = _$_TvListStoreBaseActionController.startAction(
        name: '_TvListStoreBase.changeFuture');
    try {
      return super.changeFuture(future);
    } finally {
      _$_TvListStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeIndex(int tap) {
    final _$actionInfo = _$_TvListStoreBaseActionController.startAction(
        name: '_TvListStoreBase.changeIndex');
    try {
      return super.changeIndex(tap);
    } finally {
      _$_TvListStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeFocus(bool focused) {
    final _$actionInfo = _$_TvListStoreBaseActionController.startAction(
        name: '_TvListStoreBase.changeFocus');
    try {
      return super.changeFocus(focused);
    } finally {
      _$_TvListStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
items: ${items},
focusedIndex: ${focusedIndex},
isListFocused: ${isListFocused}
    ''';
  }
}
