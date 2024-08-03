import 'package:cinenexa/screens/forgot_pass_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:cinenexa/resources/strings.dart';
import 'package:cinenexa/resources/style.dart';
import 'package:cinenexa/screens/login_configure_page.dart';
import 'package:cinenexa/widgets/custom_back_button.dart';
import 'package:cinenexa/widgets/custom_text_form.dart';
import 'package:cinenexa/widgets/rounded_button.dart';

import '../resources/asset.dart';
import '../utils/screen_size.dart';
import '../utils/form_validator.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = "/login";
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

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
                horizontal: ScreenSize.getPercentOfWidth(context, 0.02)),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      Asset.login,
                      width: ScreenSize.getPercentOfWidth(context, 1),
                      height: ScreenSize.getPercentOfWidth(context, 1),
                    ),
                    Style.getVerticalSpacing(context: context),
                    Padding(
                      padding: EdgeInsets.only(
                          left: ScreenSize.getPercentOfWidth(context, 0.05)),
                      child: Text(
                        Strings.signIn,
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Style.getVerticalSpacing(context: context),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
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
                          Align(
                            alignment: Alignment.topRight,
                            child: TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, ForgotPassPage.routeName);
                              },
                              child: Text(Strings.forgotPass),
                            ),
                          ),
                          Style.getVerticalSpacing(context: context),
                          Container(
                            width: double.infinity,
                            child: RoundedButton(
                              child: Text(Strings.signIn),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _onClick();
                                }
                              },
                              type: RoundedButtonType.filled,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: kToolbarHeight),
                  child: CustomBackButton(),
                ),
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
      final AuthResponse resp =
          await Supabase.instance.client.auth.signInWithPassword(
        password: passController.text.trim(),
        email: emailController.text.trim(),
      );
      Navigator.pop(context);

      if (resp.session != null && resp.user != null) {
        Navigator.pushNamed(
          context,
          LoginConfigurePage.routeName,
          arguments: true,
        );
      }
    } on AuthException catch (error) {
      Navigator.pop(context);
      Style.showToast(context: context, text: error.message);
    } catch (error) {
      Navigator.pop(context);
      Style.showToast(context: context, text: Strings.unexpecedError);
    }
  }
}
