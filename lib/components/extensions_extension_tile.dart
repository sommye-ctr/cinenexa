import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:watrix/models/network/extensions/extension.dart';
import 'package:watrix/resources/strings.dart';
import 'package:watrix/utils/screen_size.dart';
import 'package:watrix/widgets/rounded_button.dart';
import 'package:watrix/widgets/rounded_image.dart';

import '../resources/style.dart';

class ExtensionTile extends StatelessWidget {
  final Extension extension;
  const ExtensionTile({
    Key? key,
    required this.extension,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: ScreenSize.getPercentOfWidth(context, 0.05),
          ),
          child: Card(
            elevation: Style.cardElevation,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(Style.smallRoundEdgeRadius),
                bottomRight: Radius.circular(Style.smallRoundEdgeRadius),
                topLeft: Radius.circular(Style.smallRoundEdgeRadius),
                topRight: Radius.circular(Style.smallRoundEdgeRadius),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(
                left: 8.0,
                right: 8,
                bottom: 8,
                top: ScreenSize.getPercentOfWidth(context, 0.16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(extension.name,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Style.getVerticalSpacing(context: context),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RoundedButton(
                          child: Text(Strings.install),
                          onPressed: () {},
                          type: RoundedButtonType.filled,
                        ),
                        Style.getVerticalHorizontalSpacing(context: context),
                        IconButton(
                          onPressed: () {
                            _buildMoreInfo(context);
                          },
                          icon: Icon(Icons.info_outline_rounded),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: RoundedImage(
            image: extension.icon,
            width: ScreenSize.getPercentOfWidth(context, 0.2),
            ratio: 1,
          ),
        ),
      ],
    );
  }

  void _buildMoreInfo(context) {
    AwesomeDialog(
      context: context,
      title: extension.name,
      desc: extension.description,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            extension.name,
            style: Theme.of(context).textTheme.headline6,
          ),
          Style.getVerticalSpacing(context: context),
          Center(
            child: Wrap(
              alignment: WrapAlignment.center,
              runSpacing: ScreenSize.getPercentOfWidth(context, 0.01),
              children: extension.provider
                  .map((e) => Style.getChip(context, e.name))
                  .toList(),
            ),
          ),
          Style.getVerticalSpacing(context: context),
          Center(
            child: Text(
              extension.description ?? "",
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
      btnOkOnPress: () {},
      btnOkColor: Theme.of(context).colorScheme.primary,
      btnOkText: Strings.install,
      customHeader: RoundedImage(
        image: extension.icon,
        width: ScreenSize.getPercentOfWidth(context, 0.2),
        ratio: 1,
      ),
    ).show();
  }
}
