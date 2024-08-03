import 'package:cinenexa/models/network/extensions/extension.dart';
import 'package:cinenexa/resources/strings.dart';
import 'package:cinenexa/resources/style.dart';
import 'package:cinenexa/utils/screen_size.dart';
import 'package:cinenexa/widgets/rounded_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

import '../widgets/form_builder.dart';

class ExtensionConfig extends StatefulWidget {
  static const String routeName = "/extensions-config";

  final String json;
  final Extension extension;
  const ExtensionConfig({
    Key? key,
    required this.json,
    required this.extension,
  }) : super(key: key);

  @override
  State<ExtensionConfig> createState() => _ExtensionConfigState();
}

class _ExtensionConfigState extends State<ExtensionConfig> {
  final GlobalKey form = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton.extended(
            onPressed: () {
              final email = Email(
                subject: "Extension Complaint",
                recipients: ['support@cinenexa.com'],
              );
              FlutterEmailSender.send(email);
            },
            label: Text(Strings.raiseComplaint),
          ),
          FloatingActionButton.extended(
            onPressed: () {
              String? string =
                  (form.currentState as FormBuilderState).validate();
              if (string != null) {
                Navigator.pop(context, string);
              }
            },
            label: Text(Strings.submit),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    RoundedImage(
                      image: widget.extension.icon!,
                      width: ScreenSize.getPercentOfWidth(context, 0.2),
                      ratio: 1,
                    ),
                    Style.getVerticalHorizontalSpacing(context: context),
                    Text(
                      widget.extension.name!,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            Card(
              color: Theme.of(context).scaffoldBackgroundColor,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.grey.shade700),
                borderRadius: BorderRadius.circular(Style.smallRoundEdgeRadius),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  Strings.extensionFormHelp,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Expanded(
              child: FormBuilder(
                key: form,
                json: widget.json,
              ),
            ),
            Style.getVerticalSpacing(context: context),
          ],
        ),
      ),
    );
  }
}
