import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:cinenexa/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:random_avatar/random_avatar.dart';

import '../resources/strings.dart';
import '../resources/style.dart';
import '../screens/intro_page.dart';
import '../store/user/user_store.dart';
import '../utils/screen_size.dart';
import '../utils/size_formatter.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      bool traktConnected =
          Provider.of<UserStore>(context, listen: false).traktStatus;
      UserStore userStore = Provider.of<UserStore>(context);

      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (userStore.user?.id != null)
                randomAvatar(
                  userStore.user!.id,
                  width: ScreenSize.getPercentOfWidth(context, 0.1),
                  height: ScreenSize.getPercentOfWidth(context, 0.1),
                ),
              if (userStore.user == null)
                randomAvatar(
                  SizeFormatter.getRandomString(10),
                  width: ScreenSize.getPercentOfWidth(context, 0.1),
                  height: ScreenSize.getPercentOfWidth(context, 0.1),
                ),
              SizedBox(
                width: 8,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userStore.user?.name ?? Strings.anonymous,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(Strings.trakt),
                      Padding(padding: EdgeInsets.all(2)),
                      Icon(
                        Icons.circle,
                        color: traktConnected ? Colors.green : Colors.red,
                        size: 12,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          if (userStore.user != null)
            IconButton(
              onPressed: () {
                Style.showConfirmationDialog(
                  context: context,
                  text: Strings.logoutConfirm,
                  onPressed: () => logout(context),
                );
              },
              icon: Icon(Icons.logout_rounded),
            ),
          if (userStore.guestLogin)
            RoundedButton(
              child: Text(Strings.signIn),
              onPressed: () => logout(context),
              type: RoundedButtonType.outlined,
            ),
        ],
      );
    });
  }

  void logout(context) async {
    Style.showLoadingDialog(context: context);
    await Provider.of<UserStore>(context, listen: false).logout();
    AdaptiveTheme.of(context).setLight();
    Navigator.pop(context);
    Navigator.pushNamedAndRemoveUntil(
      context,
      IntroPage.routeName,
      (route) => false,
    );
  }
}
