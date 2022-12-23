import 'package:mobx/mobx.dart';
import 'package:watrix/models/local/installed_extensions.dart';
import 'package:watrix/models/network/extensions/extension.dart';
import 'package:watrix/services/local/database.dart';
import 'package:watrix/services/network/supabase_repository.dart';
part 'extensions_store.g.dart';

class ExtensionsStore = _ExtensionsStoreBase with _$ExtensionsStore;

abstract class _ExtensionsStoreBase with Store {
  @observable
  ObservableList<InstalledExtensions> installedExtensions =
      <InstalledExtensions>[].asObservable();

  @observable
  ObservableList<Extension>? discoverExtensions;

  Database database = Database();

  _ExtensionsStoreBase() {
    _init();
  }

  @action
  Future _init() async {
    installedExtensions.addAll(await database.getInstalledExtensions());

    database.watchInstalledExtensions().listen((event) async {
      installedExtensions.clear();
      installedExtensions.addAll(await database.getInstalledExtensions());
    });
  }

  @action
  Future fetch() async {
    if (discoverExtensions == null) {
      discoverExtensions = <Extension>[].asObservable();
      discoverExtensions!.addAll(await SupabaseRepository.getExtensions());
      await database.updateInstalledExtensions(discoverExtensions!);
    }
  }

  @action
  Future uninstallExtension(Extension extension) async {
    await Future.wait([
      SupabaseRepository.uninstallExtension(extension: extension),
      database.removeInstalledExtension(extension),
    ]);
  }

  @action
  Future installExtension(Extension extension) async {
    await Future.wait([
      SupabaseRepository.installExtension(extension: extension),
      database.addInstalledExtension(extension),
    ]);
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

    await Future.wait([
      SupabaseRepository.rateExtension(
        extension: extension,
        rating: rating,
      ),
      database.rateExtension(extension, rating)
    ]);

    await _init();
  }
}
