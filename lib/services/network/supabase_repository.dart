import 'package:multiple_result/multiple_result.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:watrix/models/network/extensions/extension.dart';

class SupabaseRepository {
  static final SupabaseClient client = Supabase.instance.client;

  static Future<Result<List<Extension>, String>> getExtensions() async {
    try {
      final resp = await client
          .from('extensions')
          .select()
          .order('rating', ascending: false);
      return Success((resp as List).map((e) => Extension.fromMap(e)).toList());
    } catch (e) {
      return Error(e.toString());
    }
  }

  static Future<Result<List<Extension>, String>> getUserExtensions() async {
    try {
      final resp = await client
          .from('user_extensions')
          .select('extension_id(*)')
          .eq('user_id', client.auth.currentUser!.id)
          .order('created_at', ascending: false);
      return Success((resp as List)
          .map(
            (e) => Extension.fromMap(e['extension_id']),
          )
          .toList());
    } catch (e) {
      return Error(e.toString());
    }
  }

  static Future<Result<Unit, String>> installExtension(
      {required Extension extension}) async {
    try {
      await client.from('user_extensions').insert({
        'user_id': client.auth.currentUser!.id,
        'extension_id': extension.id,
      });
      return Success(unit);
    } catch (e) {
      return Error(e.toString());
    }
  }

  static Future<Result<Unit, String>> uninstallExtension(
      {required Extension extension}) async {
    try {
      await client
          .from('user_extensions')
          .delete()
          .eq('extension_id', extension.id);
      return Success(unit);
    } catch (e) {
      return Error(e.toString());
    }
  }

  static Future<Result<Unit, String>> rateExtension(
      {required Extension extension, required int rating}) async {
    try {
      await client.from('extension_ratings').insert({
        'user_id': client.auth.currentUser!.id,
        'extension_id': extension.id,
        'rating': rating,
      });
      return Success(unit);
    } catch (e) {
      return Error(e.toString());
    }
  }
}
