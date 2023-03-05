// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'platform_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PlatformStore on _PlatformStoreBase, Store {
  late final _$deviceInfoAtom =
      Atom(name: '_PlatformStoreBase.deviceInfo', context: context);

  @override
  AndroidDeviceInfo? get deviceInfo {
    _$deviceInfoAtom.reportRead();
    return super.deviceInfo;
  }

  @override
  set deviceInfo(AndroidDeviceInfo? value) {
    _$deviceInfoAtom.reportWrite(value, super.deviceInfo, () {
      super.deviceInfo = value;
    });
  }

  late final _$isAndroidTvAtom =
      Atom(name: '_PlatformStoreBase.isAndroidTv', context: context);

  @override
  bool get isAndroidTv {
    _$isAndroidTvAtom.reportRead();
    return super.isAndroidTv;
  }

  @override
  set isAndroidTv(bool value) {
    _$isAndroidTvAtom.reportWrite(value, super.isAndroidTv, () {
      super.isAndroidTv = value;
    });
  }

  @override
  String toString() {
    return '''
deviceInfo: ${deviceInfo},
isAndroidTv: ${isAndroidTv}
    ''';
  }
}
