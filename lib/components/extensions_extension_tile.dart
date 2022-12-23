import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:watrix/models/local/installed_extensions.dart';
import 'package:watrix/models/network/extensions/extension.dart';
import 'package:watrix/resources/strings.dart';
import 'package:watrix/store/extensions/extensions_store.dart';
import 'package:watrix/utils/link_opener.dart';
import 'package:watrix/utils/screen_size.dart';
import 'package:watrix/widgets/rounded_button.dart';
import 'package:watrix/widgets/rounded_image.dart';

import '../resources/style.dart';

class ExtensionTile extends StatefulWidget {
  final Extension extension;
  final InstalledExtensions? installedExtension;
  final bool installed;
  final VoidCallback? onUninstall;
  final VoidCallback? onInstall;

  ExtensionTile.installed({
    Key? key,
    required InstalledExtensions installedExtension,
    this.installed = false,
    this.onInstall,
    this.onUninstall,
  })  : this.installedExtension = installedExtension,
        extension = installedExtension.getExtension(),
        super(key: key);

  ExtensionTile({
    Key? key,
    required this.extension,
    this.installed = false,
    this.onInstall,
    this.onUninstall,
    this.installedExtension,
  }) : super(key: key);

  @override
  State<ExtensionTile> createState() => _ExtensionTileState();
}

class _ExtensionTileState extends State<ExtensionTile> {
  int rating = 0;

  late AwesomeDialog moreInfoDialog;

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
                  Text(
                    widget.extension.name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Style.getVerticalSpacing(context: context),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      Text("${widget.extension.rating ?? 0} - "),
                      Text("${widget.extension.ratingCount} Ratings")
                    ],
                  ),
                  Style.getVerticalSpacing(context: context),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _buildButtons(context),
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
            image: widget.extension.icon ?? "",
            width: ScreenSize.getPercentOfWidth(context, 0.2),
            ratio: 1,
          ),
        ),
      ],
    );
  }

  List<Widget> _buildButtons(context) {
    if (widget.installed) {
      return [
        RoundedButton(
          child: Text(Strings.uninstall),
          onPressed: () => _onUninstallExtension(context),
          type: RoundedButtonType.filled,
        ),
        Style.getVerticalHorizontalSpacing(context: context),
        IconButton(
          onPressed: () {
            _buildMoreInfo(context);
          },
          icon: Icon(Icons.info_outline_rounded),
        ),
      ];
    }
    return [
      RoundedButton(
        child: Text(Strings.install),
        onPressed: () => _onInstallExtension(context),
        type: RoundedButtonType.filled,
      ),
      Style.getVerticalHorizontalSpacing(context: context),
      IconButton(
        onPressed: () {
          _buildMoreInfo(context);
        },
        icon: Icon(Icons.info_outline_rounded),
      ),
    ];
  }

  void _buildMoreInfo(context) {
    moreInfoDialog = AwesomeDialog(
      context: context,
      title: widget.extension.name,
      desc: widget.extension.description,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.extension.name,
                style: Style.headingStyle.copyWith(fontWeight: FontWeight.bold),
              ),
              if (widget.extension.devUrl != null)
                IconButton(
                  onPressed: () {
                    LinkOpener.openLink(widget.extension.devUrl!);
                  },
                  icon: Icon(Icons.open_in_new),
                ),
            ],
          ),
          Style.getVerticalSpacing(context: context, percent: 0.001),
          Text("Made By ${widget.extension.devName}"),
          Style.getVerticalSpacing(context: context),
          Center(
            child: Wrap(
              alignment: WrapAlignment.center,
              runSpacing: ScreenSize.getPercentOfWidth(context, 0.01),
              children: _buildProviderChips(context),
            ),
          ),
          Style.getVerticalSpacing(context: context),
          Center(
            child: Text(
              widget.extension.description ?? "",
              textAlign: TextAlign.center,
            ),
          ),
          Style.getVerticalSpacing(context: context),
          _buildRatingBar(),
        ],
      ),
      btnOkOnPress: !widget.installed
          ? () => _onInstallExtension(context)
          : () => _onUninstallExtension(context),
      btnOkColor: Theme.of(context).colorScheme.primary,
      btnOkText: !widget.installed ? Strings.install : Strings.uninstall,
      btnCancel: (!widget.installed)
          ? null
          : RoundedButton(
              type: RoundedButtonType.outlined,
              child: Text(Strings.rate),
              onPressed: () => _onRate(context),
            ),
      customHeader: RoundedImage(
        image: widget.extension.icon ?? "",
        width: ScreenSize.getPercentOfWidth(context, 0.2),
        ratio: 1,
      ),
    );
    moreInfoDialog.show();
  }

  Widget _buildRatingBar() {
    if (widget.installedExtension != null &&
        widget.installedExtension!.providedRating != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
              "${Strings.youRated} ${widget.installedExtension!.providedRating} "),
          Icon(
            Icons.star,
            color: Colors.amber,
          ),
        ],
      );
    } else if (widget.installed) {
      return RatingBar.builder(
        itemBuilder: (context, index) => Icon(
          Icons.star,
          color: Colors.amber,
        ),
        glowColor: Colors.amberAccent,
        onRatingUpdate: (value) {
          rating = value.toInt();
        },
      );
    }
    return Container();
  }

  void _onRate(context) {
    if (rating != 0) {
      Style.showLoadingDialog(context: context);
      Provider.of<ExtensionsStore>(context, listen: false)
          .rateExtension(rating, widget.extension)
          .whenComplete(() {
        Navigator.pop(context);
        moreInfoDialog.dismiss();
        Style.showSnackBar(context: context, text: Strings.successfulyRated);
      });
    } else {
      moreInfoDialog.dismiss();
      Style.showSnackBar(context: context, text: Strings.noRating);
    }
  }

  void _onInstallExtension(context) async {
    Style.showLoadingDialog(context: context);
    Provider.of<ExtensionsStore>(context, listen: false)
        .installExtension(widget.extension)
        .whenComplete(() {
      Navigator.pop(context);
      widget.onInstall?.call();
    });
  }

  void _onUninstallExtension(context) async {
    Style.showLoadingDialog(context: context);
    Provider.of<ExtensionsStore>(context, listen: false)
        .uninstallExtension(widget.extension)
        .whenComplete(() {
      Navigator.pop(context);
      widget.onUninstall?.call();
    });
  }

  List<Widget> _buildProviderChips(context) {
    List<Widget> list = [];
    if (widget.extension.providesAnime) {
      list.add(Style.getChip(context, Strings.anime));
    }
    if (widget.extension.providesMovie) {
      list.add(Style.getChip(context, Strings.movie));
    }
    if (widget.extension.providesShow) {
      list.add(Style.getChip(context, Strings.show));
    }
    return list;
  }
}
