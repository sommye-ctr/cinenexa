import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:cinenexa/services/local/database.dart';
import 'package:cinenexa/store/platform/platform_store.dart';
import 'package:cinenexa/utils/form_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:cinenexa/resources/asset.dart';
import 'package:cinenexa/resources/strings.dart';
import 'package:cinenexa/resources/style.dart';
import 'package:cinenexa/screens/login_page.dart';
import 'package:cinenexa/screens/register_page.dart';
import 'package:cinenexa/utils/screen_size.dart';
import 'package:cinenexa/widgets/rounded_button.dart';
import 'package:provider/provider.dart';

import '../widgets/custom_text_form.dart';
import 'forgot_pass_page.dart';
import 'login_configure_page.dart';

class IntroPage extends StatefulWidget {
  static const String routeName = "/intro";
  const IntroPage({Key? key}) : super(key: key);

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    bool isAndroid =
        Provider.of<PlatformStore>(context, listen: false).isAndroidTv;

    if (isAndroid) {
      return Material(
        child: Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        Asset.intro,
                        width: ScreenSize.getPercentOfWidth(context, 0.25),
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
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(Style.largeRoundEdgeRadius),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              Strings.signIn,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  ?.apply(color: Colors.black),
                            ),
                            Style.getVerticalSpacing(context: context),
                            Form(
                              child: Column(
                                children: [
                                  CustomTextFormField(
                                    hint: Strings.email,
                                    width: ScreenSize.getPercentOfWidth(
                                        context, 0.4),
                                    validator: (val) {
                                      if (!val!.isValidEmail) {
                                        return Strings.emailError;
                                      }
                                    },
                                    icon: Icon(
                                      Icons.mail_outline_rounded,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  CustomTextFormField(
                                    hint: Strings.password,
                                    obscure: true,
                                    width: ScreenSize.getPercentOfWidth(
                                        context, 0.4),
                                    validator: (val) {
                                      if (!val!.isValidPassword) {
                                        return Strings.passwordError;
                                      }
                                    },
                                    icon: Icon(
                                      Icons.lock_outline_rounded,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Style.getVerticalSpacing(context: context),
                                  Container(
                                    width: ScreenSize.getPercentOfWidth(
                                        context, 0.15),
                                    child: RoundedButton(
                                      child: Text(Strings.signIn),
                                      onPressed: () {},
                                      type: RoundedButtonType.filled,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Style.getVerticalSpacing(context: context),
                            Divider(),
                            Style.getVerticalSpacing(context: context),
                            Row(
                              children: [
                                RoundedButton(
                                  child: Text(Strings.register),
                                  onPressed: () {},
                                  type: RoundedButtonType.outlined,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }
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
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RoundedButton(
                          child: Text(Strings.register),
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(RegisterPage.routeName);
                          },
                          type: RoundedButtonType.filled,
                        ),
                        Style.getVerticalHorizontalSpacing(context: context),
                        RoundedButton(
                          child: Text(Strings.signIn),
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(LoginPage.routeName);
                          },
                          type: RoundedButtonType.outlined,
                        ),
                      ],
                    ),
                    Style.getVerticalSpacing(context: context),
                    TextButton(
                      onPressed: () async {
                        await Database().addGuestSignupStatus(true);
                        Navigator.pushNamed(
                          context,
                          LoginConfigurePage.routeName,
                          arguments: true,
                        );
                      },
                      child: Text(Strings.guestLogin),
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
