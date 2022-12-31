import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:watrix/models/network/extensions/extension.dart';

class SupabaseRepository {
  static final SupabaseClient client = Supabase.instance.client;

  static Future<List<Extension>> getExtensions() async {
    final resp = await client
        .from('extensions')
        .select()
        .order('rating', ascending: false);

    return (resp as List).map((e) => Extension.fromMap(e)).toList();
  }

  static Future<List<Extension>> getUserExtensions() async {
    final resp = await client
        .from('user_extensions')
        .select('extension_id(*)')
        .eq('user_id', client.auth.currentUser!.id)
        .order('created_at', ascending: false);

    return (resp as List)
        .map(
          (e) => Extension.fromMap(e['extension_id']),
        )
        .toList();
  }

  static Future installExtension({required Extension extension}) async {
    await client.from('user_extensions').insert({
      'user_id': client.auth.currentUser!.id,
      'extension_id': extension.id,
    });
  }

  static Future uninstallExtension({required Extension extension}) async {
    try {
      await client
          .from('user_extensions')
          .delete()
          .eq('extension_id', extension.id);
    } catch (e) {
      print(e);
    }
  }

  static Future rateExtension(
      {required Extension extension, required int rating}) async {
    await client.from('extension_ratings').insert({
      'user_id': client.auth.currentUser!.id,
      'extension_id': extension.id,
      'rating': rating,
    });
  }
}
