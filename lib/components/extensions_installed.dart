import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:watrix/resources/strings.dart';
import 'package:watrix/store/extensions/extensions_store.dart';

import '../resources/asset.dart';
import 'extensions_extension_tile.dart';

class ExtensionsInstalled extends StatefulWidget {
  final ExtensionsStore extensionsStore;
  const ExtensionsInstalled({
    Key? key,
    required this.extensionsStore,
  }) : super(key: key);

  @override
  State<ExtensionsInstalled> createState() => _ExtensionsInstalledState();
}

class _ExtensionsInstalledState extends State<ExtensionsInstalled>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    if (widget.extensionsStore.installedExtensions.isEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          LottieBuilder.asset(
            Asset.notFound,
          ),
          Text(
            Strings.installExtensionHelp,
            textAlign: TextAlign.center,
          ),
        ],
      );
    }

    return RefreshIndicator(
      onRefresh: () {
        return widget.extensionsStore.syncInstalledExtensions();
      },
      child: GridView.builder(
        physics: AlwaysScrollableScrollPhysics(),
        itemCount: widget.extensionsStore.installedExtensions.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 4,
        ),
        itemBuilder: (context, index) {
          return ExtensionTile.installed(
            installedExtension:
                widget.extensionsStore.installedExtensions[index],
            installed: true,
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
