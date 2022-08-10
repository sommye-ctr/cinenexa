import 'package:isar/isar.dart';
import 'package:watrix/models/local/favorites.dart';
import 'package:watrix/models/local/search_history.dart';
import 'package:watrix/models/network/base_model.dart';

class Database {
  late Isar isar;

  Database() {
    isar = Isar.getInstance()!;
  }

  Future<bool> addSearchHistory(String term) async {
    SearchHistory? prev = await isar.searchHistorys
        .filter()
        .termEqualTo(
          term,
          caseSensitive: true,
        )
        .findFirst();
    if (prev != null) {
      return false;
    }
    isar.writeTxn((isar) async {
      await isar.searchHistorys.put(SearchHistory()..term = term);
    });
    return true;
  }

  Future<List<SearchHistory>> getSearchHistory() async {
    return await isar.searchHistorys.where().findAll();
  }

  void deleteSearchHistory(int id) async {
    isar.writeTxn((isar) async {
      await isar.searchHistorys.delete(id);
    });
  }

  Future<List<BaseModel>> getFavorites() async {
    List<Favorites> list = await isar.favoritess.where().findAll();
    return list.map((e) => BaseModel.fromFavorite(e)).toList();
  }

  Future<bool> isAddedInFav(int id) async {
    if (await isar.favoritess.get(id) != null) {
      return true;
    }
    return false;
  }

  void addToFavorites(Favorites favorite) {
    isar.writeTxn((isar) async {
      await isar.favoritess.put(favorite);
    });
  }

  void removeFromFav(int id) {
    isar.writeTxn((isar) async {
      await isar.favoritess.delete(id);
    });
  }
}