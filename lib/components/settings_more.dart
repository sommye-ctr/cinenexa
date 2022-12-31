import 'package:flutter/material.dart';
import 'package:watrix/resources/strings.dart';
import 'package:watrix/resources/style.dart';
import 'package:watrix/utils/link_opener.dart';

class SettingsMore extends StatelessWidget {
  const SettingsMore({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(Strings.more, style: Style.headingStyle),
        Style.getVerticalSpacing(context: context),
        Expanded(
          child: ListView(
            children: [
              Style.getListTile(
                context: context,
                title: Strings.website,
                subtitle: "https://www.cinenexa.com/",
                onTap: () => LinkOpener.openLink("https://www.cinenexa.com/"),
              ),
              Style.getListTile(
                context: context,
                title: Strings.extensionDoc,
                subtitle: "https://www.cinenexa.com/developer/",
                onTap: () =>
                    LinkOpener.openLink("https://www.cinenexa.com/developer/"),
              ),
              Style.getListTile(
                context: context,
                title: Strings.telegram,
                subtitle: "https://t.me/cinenexaa",
                onTap: () => LinkOpener.openLink("https://t.me/cinenexaa"),
              ),
              Style.getListTile(
                context: context,
                title: Strings.privacyPolicy,
                subtitle: "https://www.cinenexa.com/privacy-policy/",
                onTap: () => LinkOpener.openLink(
                    "https://www.cinenexa.com/privacy-policy/"),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
