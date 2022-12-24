import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:watrix/resources/asset.dart';
import 'package:watrix/resources/strings.dart';
import 'package:watrix/resources/style.dart';
import 'package:watrix/screens/login_page.dart';
import 'package:watrix/screens/register_page.dart';
import 'package:watrix/utils/screen_size.dart';
import 'package:watrix/widgets/rounded_button.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(top: kToolbarHeight),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    Asset.intro,
                    width: ScreenSize.getPercentOfWidth(context, 1),
                    height: ScreenSize.getPercentOfWidth(context, 1),
                  ),
                  Style.getVerticalSpacing(context: context, percent: 0.08),
                  Text(
                    Strings.tagline,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        ?.apply(color: Colors.black),
                  ),
                  Style.getVerticalSpacing(context: context),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal:
                            ScreenSize.getPercentOfWidth(context, 0.17)),
                    child: Text(
                      Strings.desc,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: ScreenSize.getPercentOfHeight(context, 0.02),
              ),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RoundedButton(
                      child: Text(Strings.register),
                      onPressed: () {
                        Navigator.of(context).pushNamed(RegisterPage.routeName);
                      },
                      type: RoundedButtonType.filled,
                    ),
                    Style.getVerticalHorizontalSpacing(context: context),
                    RoundedButton(
                      child: Text(Strings.signIn),
                      onPressed: () {
                        Navigator.of(context).pushNamed(LoginPage.routeName);
                      },
                      type: RoundedButtonType.outlined,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
