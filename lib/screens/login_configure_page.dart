import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:restart_app/restart_app.dart';
import 'package:cinenexa/resources/strings.dart';
import 'package:cinenexa/resources/style.dart';
import 'package:cinenexa/services/local/database.dart';
import 'package:cinenexa/services/network/trakt_oauth_client.dart';
import 'package:cinenexa/services/network/trakt_repository.dart';
import 'package:cinenexa/utils/link_opener.dart';

import '../resources/asset.dart';
import '../utils/screen_size.dart';

class LoginConfigurePage extends StatelessWidget {
  static const String routeName = "/login_configure";

  final bool showSkip;
  const LoginConfigurePage({Key? key, this.showSkip = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          left: ScreenSize.getPercentOfWidth(context, 0.02),
          right: ScreenSize.getPercentOfWidth(context, 0.02),
          top: kToolbarHeight,
        ),
        child: Stack(
          children: [
            Column(
              children: [
                SvgPicture.asset(
                  Asset.traktConnect,
                  width: ScreenSize.getPercentOfWidth(context, 1),
                  height: ScreenSize.getPercentOfWidth(context, 1),
                ),
                Style.getVerticalSpacing(context: context),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    Strings.connect,
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
                Style.getVerticalSpacing(context: context),
                Center(
                  child: Container(
                    width: ScreenSize.getPercentOfWidth(context, 0.75),
                    child: ElevatedButton.icon(
                      onPressed: () => _onTraktClick(context),
                      icon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(
                          Asset.traktConnectTall,
                          width: ScreenSize.getPercentOfWidth(context, 0.1),
                        ),
                      ),
                      label: Text(Strings.loginTrakt),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                    ),
                  ),
                ),
                Style.getVerticalSpacing(context: context),
                TextButton(
                    child: Text(Strings.whatTrakt),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return CupertinoAlertDialog(
                            content: _buildWhatTraktDialog(),
                          );
                        },
                      );
                    }),
                TextButton(
                    child: Text(Strings.whyTrakt),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return CupertinoAlertDialog(
                            content: _buildWhyTraktDialog(),
                          );
                        },
                      );
                    }),
              ],
            ),
            if (showSkip)
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: () {
                    Restart.restartApp();
                  },
                  child: Text(Strings.skip),
                ),
              )
          ],
        ),
      ),
    );
  }

  Widget _buildWhyTraktDialog() {
    return Text(Strings.whyTaktAns);
  }

  Widget _buildWhatTraktDialog() {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: Strings.whatTraktAns,
          ),
          TextSpan(
            text: Strings.moreInfo,
            style: TextStyle(color: Colors.blue),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                LinkOpener.openLink(
                  "https://trakt.tv/about",
                );
              },
          ),
        ],
      ),
    );
  }

  void _onTraktClick(context) async {
    TraktOAuthClient authClient = TraktOAuthClient();
    TraktRepository traktRepository = TraktRepository(client: authClient);
    try {
      Style.showLoadingDialog(context: context);
      await traktRepository.getUserStats();
    } catch (e) {
      Style.showToast(context: context, text: Strings.loginTrakt);
    }
    await Database().addUserTraktStatus(true);
    Navigator.pop(context);

    await Restart.restartApp();
  }
}
