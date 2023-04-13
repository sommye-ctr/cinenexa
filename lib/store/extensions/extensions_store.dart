import 'package:mobx/mobx.dart';
import 'package:cinenexa/models/local/installed_extensions.dart';
import 'package:cinenexa/models/local/last_activities.dart';
import 'package:cinenexa/models/network/extensions/extension.dart';
import 'package:cinenexa/services/local/database.dart';
import 'package:cinenexa/services/network/supabase_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../resources/strings.dart';
part 'extensions_store.g.dart';

class ExtensionsStore = _ExtensionsStoreBase with _$ExtensionsStore;

abstract class _ExtensionsStoreBase with Store {
  @observable
  ObservableList<InstalledExtensions> installedExtensions =
      <InstalledExtensions>[].asObservable();

  @observable
  ObservableList<Extension>? discoverExtensions;

  @observable
  String? error;

  @observable
  String? successMessage;
  bool _isGuestLogin = false;

  Database database = Database();

  @action
  Future init() async {
    bool status = await database.getGuestSignupStatus();
    _isGuestLogin = Supabase.instance.client.auth.currentUser == null && status;

    LastActivities? lastActivities = await database.getLastActivities();
    if (lastActivities == null || lastActivities.extensionsSyncedAt == null) {
      return syncInstalledExtensions();
    } else {
      installedExtensions.addAll(await database.getInstalledExtensions());
    }

    database.watchInstalledExtensions().listen((event) async {
      installedExtensions.clear();
      installedExtensions.addAll([
        ...(await database.getInstalledExtensions()),
      ]);
    });
  }

  @action
  Future fetch() async {
    if (discoverExtensions == null) {
      discoverExtensions = <Extension>[].asObservable();
      var result = await SupabaseRepository.getExtensions();

      return result.when(
        (success) async {
          discoverExtensions!.addAll(success);
          await database.updateInstalledExtensions(discoverExtensions!);
        },
        (err) {
          error = err.message;
        },
      );
    }
  }

  @action
  Future uninstallExtension(Extension extension) async {
    if (_isGuestLogin) {
      successMessage = Strings.uninstalled;
      await database.removeInstalledExtension(extension);
      installedExtensions
          .removeWhere((element) => element.stId == extension.id);
      return;
    }
    var result =
        await SupabaseRepository.uninstallExtension(extension: extension);

    result.when(
      (success) async {
        successMessage = Strings.uninstalled;
        await database.removeInstalledExtension(extension);
        installedExtensions
            .removeWhere((element) => element.stId == extension.id);
      },
      (err) => error = err.message,
    );
  }

  @action
  Future installExtension(Extension extension, {String? userData}) async {
    if (_isGuestLogin) {
      successMessage = Strings.installed;
      await database.addInstalledExtension(
        extension,
        userData: userData,
      );
      installedExtensions.add(extension.getInstalled(userData: userData));
      return;
    }

    var result = await SupabaseRepository.installExtension(
      extension: extension,
      userData: userData,
    );

    result.when(
      (success) async {
        successMessage = Strings.installed;
        await database.addInstalledExtension(
          extension,
          userData: userData,
        );
        installedExtensions.add(extension.getInstalled(userData: userData));
      },
      (err) {
        if (err.code == "23505") {
          error = Strings.alreadyInstalled;
          syncInstalledExtensions();
          return;
        }
        error = err.message;
      },
    );
  }

  @action
  Future syncInstalledExtensions() async {
    if (_isGuestLogin) {
      final list = await database.getInstalledExtensions();

      installedExtensions.clear();
      installedExtensions.addAll(list);
      database.updateAllInstalledExtensions(list);
      return;
    }

    final list = await SupabaseRepository.getUserExtensions();
    return list.when(
      (success) {
        installedExtensions.clear();
        installedExtensions.addAll(
            success.map((e) => e.extension.getInstalled(userData: e.userData)));
        Future.wait([
          database.updateAllInstalledExtensions(success
              .map((e) => e.extension.getInstalled(userData: e.userData))
              .toList()),
          database.updateLastActivities(extensionSyncedAt: DateTime.now()),
        ]);
      },
      (err) {
        error = err is PostgrestException ? err.message : err.toString();
      },
    );
  }

  @action
  Future rateExtension(int rating, Extension extension) async {
    //await SupabaseRepository.rateExtension(
    //  extension: extension, rating: rating);
    /* 
    num newRat = extension.rating! * extension.ratingCount!;
    newRat += rating;

    int index = installedExtensions.indexOf(extension);

    Extension temp = installedExtensions[index].copyWith(
      rating: double.parse(
          (newRat / (extension.ratingCount! + 1)).toStringAsFixed(2)),
      ratingCount: extension.ratingCount! + 1,
    );
    installedExtensions[index] = temp; */

    if (_isGuestLogin) {
      error = Strings.loginToRate;
      return;
    }

    var result = await SupabaseRepository.rateExtension(
      extension: extension,
      rating: rating,
    );

    return result.when(
      (success) {
        successMessage = Strings.successfulyRated;
        return Future.wait([
          database.rateExtension(extension, rating),
          init(),
        ]);
      },
      (err) {
        if (err.code == "23505") {
          error = Strings.alreadyRated;
          return;
        }
        error = err.message;
      },
    );
  }
}
