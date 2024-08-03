import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:cinenexa/resources/style.dart';
import 'package:cinenexa/utils/form_validator.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../resources/asset.dart';
import '../resources/strings.dart';
import '../utils/screen_size.dart';
import '../widgets/custom_back_button.dart';
import '../widgets/custom_text_form.dart';
import '../widgets/rounded_button.dart';

class ForgotPassPage extends StatefulWidget {
  static const String routeName = "/forgotPass";

  const ForgotPassPage({Key? key}) : super(key: key);

  @override
  State<ForgotPassPage> createState() => _ForgotPassPageState();
}

class _ForgotPassPageState extends State<ForgotPassPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ScreenSize.getPercentOfWidth(context, 0.02),
            vertical: kToolbarHeight,
          ),
          child: Stack(
            children: [
              Column(
                children: [
                  SvgPicture.asset(
                    Asset.forgotPass,
                    width: ScreenSize.getPercentOfWidth(context, 1),
                  ),
                  Style.getVerticalSpacing(context: context),
                  Text(Strings.forgotPassTagline),
                  Style.getVerticalSpacing(context: context),
                  Form(
                    key: _formKey,
                    child: CustomTextFormField(
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
                  ),
                  Style.getVerticalSpacing(context: context),
                  Container(
                    width: double.infinity,
                    child: RoundedButton(
                      child: Text(Strings.continueSt),
                      onPressed: () async {
                        Style.showLoadingDialog(context: context);
                        try {
                          await Supabase.instance.client.auth
                              .resetPasswordForEmail(
                            emailController.value.text,
                            redirectTo:
                                "https://www.cinenexa.com/reset-password/",
                          );
                          Style.showToast(
                            context: context,
                            text:
                                "An email has been sent to your registered email",
                          );
                          Navigator.pop(context);
                        } catch (e) {
                          Navigator.pop(context);
                          Style.showToast(context: context, text: e.toString());
                        }
                      },
                      type: RoundedButtonType.filled,
                    ),
                  ),
                ],
              ),
              CustomBackButton(),
            ],
          ),
        ),
      ),
    );
  }
}
