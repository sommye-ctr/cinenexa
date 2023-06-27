import 'dart:async';

import 'package:cinenexa/utils/form_validator.dart';
import 'package:cinenexa/utils/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../resources/strings.dart';
import '../../resources/style.dart';
import '../../utils/keycode.dart';
import '../../widgets/custom_text_form.dart';
import '../../widgets/rounded_button.dart';

class TvLoginPage extends StatefulWidget {
  const TvLoginPage({Key? key}) : super(key: key);

  @override
  State<TvLoginPage> createState() => _TvLoginPageState();
}

class _TvLoginPageState extends State<TvLoginPage> {
  final FocusNode focusNode = FocusNode();
  int yFocus = 0;

  final FocusNode emailController = FocusNode();
  final FocusNode passController = FocusNode();
  final RoundedButtonController buttonController =
      RoundedButtonController(type: RoundedButtonType.outlined);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      FocusScope.of(context).requestFocus(emailController);
    });
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: focusNode,
      onKey: (event) {
        if (!(event is RawKeyDownEvent)) {
          return;
        }
        RawKeyEventDataAndroid rawKeyEventData =
            event.data as RawKeyEventDataAndroid;
        _onKey(rawKeyEventData.keyCode);
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Flex(
            crossAxisAlignment: CrossAxisAlignment.center,
            direction: Axis.horizontal,
            children: [
              Flexible(
                flex: 1,
                child: Container(),
              ),
              Flexible(
                flex: 1,
                child: Column(
                  children: [
                    Text(
                      Strings.tagline,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Style.getVerticalSpacing(
                      context: context,
                      percent: 0.1,
                    ),
                    CustomTextFormField(
                      hint: Strings.email,
                      focusNode: emailController,
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
                    Style.getVerticalSpacing(context: context),
                    CustomTextFormField(
                      hint: Strings.password,
                      focusNode: passController,
                      obscure: false,
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
                    Style.getVerticalSpacing(
                      context: context,
                      percent: 0.06,
                    ),
                    SizedBox(
                      width: ScreenSize.getPercentOfWidth(context, 0.25),
                      height: 40,
                      child: RoundedButton.controller(
                        child: Text(
                          Strings.signIn,
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        onPressed: () {},
                        controller: buttonController,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onKey(int key) {
    print("before " + yFocus.toString());
    switch (key) {
      case KEY_DOWN:
        if (yFocus == 0) {
          passController.requestFocus();
          yFocus = 1;
        } else if (yFocus == 1) {
          passController.unfocus();
          buttonController.changeType(RoundedButtonType.filled);
          Future.delayed(
            Duration(
              milliseconds: 50,
            ),
            () => focusNode.requestFocus(),
          );
          yFocus = 2;
        }
        break;
      case KEY_UP:
        if (yFocus == 1) {
          emailController.requestFocus();
          yFocus = 0;
        } else if (yFocus == 2) {
          buttonController.changeType(RoundedButtonType.outlined);
          emailController.requestFocus();
          yFocus = 0;
        }
        break;
      default:
    }
    print("After $yFocus");
  }
}
