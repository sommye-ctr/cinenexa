// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tv_home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TvHomeStore on _TvHomeStoreBase, Store {
  late final _$tabIndexAtom =
      Atom(name: '_TvHomeStoreBase.tabIndex', context: context);

  @override
  int get tabIndex {
    _$tabIndexAtom.reportRead();
    return super.tabIndex;
  }

  @override
  set tabIndex(int value) {
    _$tabIndexAtom.reportWrite(value, super.tabIndex, () {
      super.tabIndex = value;
    });
  }

  late final _$railHasFocusAtom =
      Atom(name: '_TvHomeStoreBase.railHasFocus', context: context);

  @override
  bool get railHasFocus {
    _$railHasFocusAtom.reportRead();
    return super.railHasFocus;
  }

  @override
  set railHasFocus(bool value) {
    _$railHasFocusAtom.reportWrite(value, super.railHasFocus, () {
      super.railHasFocus = value;
    });
  }

  late final _$currentFocusedAtom =
      Atom(name: '_TvHomeStoreBase.currentFocused', context: context);

  @override
  BaseModel? get currentFocused {
    _$currentFocusedAtom.reportRead();
    return super.currentFocused;
  }

  @override
  set currentFocused(BaseModel? value) {
    _$currentFocusedAtom.reportWrite(value, super.currentFocused, () {
      super.currentFocused = value;
    });
  }

  @override
  String toString() {
    return '''
tabIndex: ${tabIndex},
railHasFocus: ${railHasFocus},
currentFocused: ${currentFocused}
    ''';
  }
}