// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'extensions_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ExtensionsStore on _ExtensionsStoreBase, Store {
  late final _$installedExtensionsAtom =
      Atom(name: '_ExtensionsStoreBase.installedExtensions', context: context);

  @override
  ObservableList<InstalledExtensions> get installedExtensions {
    _$installedExtensionsAtom.reportRead();
    return super.installedExtensions;
  }

  @override
  set installedExtensions(ObservableList<InstalledExtensions> value) {
    _$installedExtensionsAtom.reportWrite(value, super.installedExtensions, () {
      super.installedExtensions = value;
    });
  }

  late final _$discoverExtensionsAtom =
      Atom(name: '_ExtensionsStoreBase.discoverExtensions', context: context);

  @override
  ObservableList<Extension>? get discoverExtensions {
    _$discoverExtensionsAtom.reportRead();
    return super.discoverExtensions;
  }

  @override
  set discoverExtensions(ObservableList<Extension>? value) {
    _$discoverExtensionsAtom.reportWrite(value, super.discoverExtensions, () {
      super.discoverExtensions = value;
    });
  }

  late final _$_initAsyncAction =
      AsyncAction('_ExtensionsStoreBase._init', context: context);

  @override
  Future<dynamic> _init() {
    return _$_initAsyncAction.run(() => super._init());
  }

  late final _$fetchAsyncAction =
      AsyncAction('_ExtensionsStoreBase.fetch', context: context);

  @override
  Future<dynamic> fetch() {
    return _$fetchAsyncAction.run(() => super.fetch());
  }

  late final _$uninstallExtensionAsyncAction =
      AsyncAction('_ExtensionsStoreBase.uninstallExtension', context: context);

  @override
  Future<dynamic> uninstallExtension(Extension extension) {
    return _$uninstallExtensionAsyncAction
        .run(() => super.uninstallExtension(extension));
  }

  late final _$installExtensionAsyncAction =
      AsyncAction('_ExtensionsStoreBase.installExtension', context: context);

  @override
  Future<dynamic> installExtension(Extension extension) {
    return _$installExtensionAsyncAction
        .run(() => super.installExtension(extension));
  }

  late final _$rateExtensionAsyncAction =
      AsyncAction('_ExtensionsStoreBase.rateExtension', context: context);

  @override
  Future<dynamic> rateExtension(int rating, Extension extension) {
    return _$rateExtensionAsyncAction
        .run(() => super.rateExtension(rating, extension));
  }

  @override
  String toString() {
    return '''
installedExtensions: ${installedExtensions},
discoverExtensions: ${discoverExtensions}
    ''';
  }
}
