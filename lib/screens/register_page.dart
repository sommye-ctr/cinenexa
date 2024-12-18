import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:restart_app/restart_app.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:cinenexa/screens/login_page.dart';
import 'package:cinenexa/utils/form_validator.dart';
import 'package:cinenexa/utils/link_opener.dart';

import '../resources/asset.dart';
import '../resources/strings.dart';
import '../resources/style.dart';
import '../utils/screen_size.dart';
import '../widgets/custom_back_button.dart';
import '../widgets/custom_text_form.dart';
import '../widgets/rounded_button.dart';

class RegisterPage extends StatefulWidget {
  static const String routeName = "/register";

  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ScreenSize.getPercentOfWidth(context, 0.02),
              vertical: kToolbarHeight,
            ),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      Asset.register,
                      width: ScreenSize.getPercentOfWidth(context, 1),
                    ),
                    Style.getVerticalSpacing(context: context),
                    Padding(
                      padding: EdgeInsets.only(
                          left: ScreenSize.getPercentOfWidth(context, 0.05)),
                      child: Text(
                        Strings.register,
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Style.getVerticalSpacing(context: context),
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomTextFormField(
                            hint: Strings.name,
                            textEditingController: nameController,
                            validator: (val) {
                              if (!val!.isValidName) {
                                return Strings.nameError;
                              }
                              return null;
                            },
                            icon: Icon(
                              Icons.person_outline_rounded,
                              color: Colors.grey,
                            ),
                          ),
                          CustomTextFormField(
                            hint: Strings.email,
                            textEditingController: emailController,
                            validator: (val) {
                              if (!val!.isValidEmail) {
                                return Strings.emailError;
                              }
                              return null;
                            },
                            icon: Icon(
                              Icons.mail_outline_rounded,
                              color: Colors.grey,
                            ),
                          ),
                          CustomTextFormField(
                            hint: Strings.password,
                            textEditingController: passController,
                            obscure: true,
                            validator: (val) {
                              if (!val!.isValidPassword) {
                                return Strings.passwordError;
                              }
                              return null;
                            },
                            icon: Icon(
                              Icons.lock_outline_rounded,
                              color: Colors.grey,
                            ),
                          ),
                          Style.getVerticalSpacing(context: context),
                          Container(
                            width: double.infinity,
                            child: RoundedButton(
                              child: Text(Strings.register),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _onClick();
                                }
                              },
                              type: RoundedButtonType.filled,
                            ),
                          ),
                          Style.getVerticalSpacing(context: context),
                          Center(
                            child: Text.rich(
                              TextSpan(
                                style: TextStyle(color: Colors.black),
                                children: <TextSpan>[
                                  TextSpan(text: Strings.signUpPolicy),
                                  TextSpan(
                                      text: Strings.termsConditions,
                                      style: TextStyle(color: Colors.blue),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          _launchUrl(
                                              "https://www.cinenexa.com/terms-conditions/");
                                        }),
                                  TextSpan(text: ' and '),
                                  TextSpan(
                                      text: Strings.privacyPolicy,
                                      style: TextStyle(color: Colors.blue),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          _launchUrl(
                                              "https://www.cinenexa.com/privacy-policy/");
                                        }),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                CustomBackButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onClick() async {
    Style.showLoadingDialog(context: context);

    try {
      final AuthResponse res = await Supabase.instance.client.auth.signUp(
        password: passController.text.trim(),
        email: emailController.text.trim(),
        data: {
          "name": nameController.text.trim(),
        },
      );
      Navigator.pop(context);

      final Session? session = res.session;
      final User? user = res.user;

      if (session != null && user != null) {
        Style.showToast(context: context, text: Strings.sucessful);
        Restart.restartApp();
      } else {
        Navigator.pushNamed(context, LoginPage.routeName);
      }
    } on AuthException catch (e) {
      FocusManager.instance.primaryFocus?.unfocus();
      Navigator.pop(context);
      Style.showToast(context: context, text: e.message, long: true);
    } catch (error) {
      FocusManager.instance.primaryFocus?.unfocus();
      Navigator.pop(context);
      Style.showToast(
          context: context, text: Strings.unexpecedError, long: true);
    }
  }

  void _launchUrl(String url) async {
    if (!await LinkOpener.openLink(url)) {
      Style.showToast(context: context, text: Strings.unexpecedError);
    }
  }
}
