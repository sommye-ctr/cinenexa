import 'dart:async';

import 'package:cinenexa/resources/asset.dart';
import 'package:cinenexa/utils/form_validator.dart';
import 'package:cinenexa/utils/screen_size.dart';
import 'package:cinenexa/widgets/glassy_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restart_app/restart_app.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
  final _formKey = GlobalKey<FormState>();

  final FocusNode emailController = FocusNode();
  final FocusNode passController = FocusNode();
  final RoundedButtonController buttonController =
      RoundedButtonController(type: RoundedButtonType.outlined);

  final TextEditingController passText = TextEditingController();
  final TextEditingController emailText = TextEditingController();

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
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Stack(
            children: [
              ShaderMask(
                blendMode: BlendMode.darken,
                shaderCallback: (bounds) {
                  return LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.26),
                      Colors.black.withOpacity(0.38),
                      Colors.black.withOpacity(0.45),
                      Colors.black
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ).createShader(bounds);
                },
                child: Image.asset(
                  Asset.tvIntro,
                  height: double.infinity,
                  width: double.infinity,
                  colorBlendMode: BlendMode.darken,
                  color: Colors.black45,
                  fit: BoxFit.fill,
                ),
              ),
              Flex(
                crossAxisAlignment: CrossAxisAlignment.center,
                direction: Axis.horizontal,
                children: [
                  Flexible(
                    flex: 1,
                    child: Container(
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            constraints: BoxConstraints(
                              maxHeight:
                                  ScreenSize.getPercentOfHeight(context, 0.4),
                              minHeight:
                                  ScreenSize.getPercentOfHeight(context, 0.4),
                            ),
                            child: Image.asset(
                              Asset.icon,
                            ),
                          ),
                          Text(
                            Strings.tagline,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Center(
                      child: Container(
                        height: ScreenSize.getPercentOfHeight(context, 0.8),
                        child: GlassyContainer(
                          child: Column(
                            children: [
                              Text(
                                Strings.signIn,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 25),
                              ),
                              Style.getVerticalSpacing(
                                context: context,
                                percent: 0.1,
                              ),
                              Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    CustomTextFormField(
                                      hint: Strings.email,
                                      focusNode: emailController,
                                      textEditingController: emailText,
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
                                      textEditingController: passText,
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
                                  ],
                                ),
                              ),
                              Style.getVerticalSpacing(
                                context: context,
                                percent: 0.06,
                              ),
                              SizedBox(
                                width:
                                    ScreenSize.getPercentOfWidth(context, 0.25),
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
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onKey(int key) async {
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
      case KEY_CENTER:
        if (yFocus == 2) {
          if (_formKey.currentState!.validate()) {
            Style.showLoadingDialog(context: context);
            try {
              final AuthResponse resp =
                  await Supabase.instance.client.auth.signInWithPassword(
                password: passText.text.trim(),
                email: emailText.text.trim(),
              );
              Navigator.pop(context);

              print("heyyy ${Supabase.instance.client.auth.currentUser?.id}");
            } on AuthException catch (error) {
              Navigator.pop(context);
              Style.showToast(context: context, text: error.message);
            } catch (error) {
              Navigator.pop(context);
              Style.showToast(context: context, text: Strings.unexpecedError);
            }
          }
        }
        break;
      default:
    }
  }
}
