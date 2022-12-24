import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:watrix/resources/style.dart';
import 'package:watrix/utils/form_validator.dart';

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
                  ),
                  Style.getVerticalSpacing(context: context),
                  Container(
                    width: double.infinity,
                    child: RoundedButton(
                      child: Text(Strings.continueSt),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          print("done!");
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
