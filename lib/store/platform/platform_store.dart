import 'package:device_info_plus/device_info_plus.dart';
import 'package:mobx/mobx.dart';
part 'platform_store.g.dart';

class PlatformStore = _PlatformStoreBase with _$PlatformStore;

abstract class _PlatformStoreBase with Store {
  @observable
  AndroidDeviceInfo? deviceInfo;

  @observable
  bool isAndroidTv = false;

  _PlatformStoreBase() {
    _init();
  }

  void _init() async {
    deviceInfo = await DeviceInfoPlugin().androidInfo;
    isAndroidTv =
        deviceInfo!.systemFeatures.contains('android.software.leanback');
  }
}
