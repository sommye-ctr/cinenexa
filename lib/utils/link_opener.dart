import 'package:url_launcher/url_launcher.dart';

class LinkOpener {
  static Future openLink(String url) async {
    Uri uri = Uri.parse(url);
    if (!uri.hasAbsolutePath) {
      uri = Uri.parse("https://${url}");
    }
    return launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );
  }
}
