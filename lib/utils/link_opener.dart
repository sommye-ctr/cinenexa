import 'package:url_launcher/url_launcher.dart';

class LinkOpener {
  static Future openLink(String url) async {
    return launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    );
  }
}
