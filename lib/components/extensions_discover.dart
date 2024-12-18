import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../store/extensions/extensions_store.dart';
import 'extensions_extension_tile.dart';

class ExtensionsDiscover extends StatefulWidget {
  final ExtensionsStore extensionsStore;
  const ExtensionsDiscover({
    Key? key,
    required this.extensionsStore,
  }) : super(key: key);

  @override
  State<ExtensionsDiscover> createState() => _ExtensionsDiscoverState();
}

class _ExtensionsDiscoverState extends State<ExtensionsDiscover>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Observer(builder: (_) {
      if (widget.extensionsStore.discoverExtensions == null ||
          (widget.extensionsStore.discoverExtensions?.isEmpty ?? true)) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      return GridView.builder(
        itemCount: widget.extensionsStore.discoverExtensions!.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 4,
        ),
        itemBuilder: (context, index) {
          int ind = widget.extensionsStore.installedExtensions.indexWhere(
              (element) =>
                  element.stId ==
                  widget.extensionsStore.discoverExtensions![index].id);

          return ExtensionTile(
            extension: widget.extensionsStore.discoverExtensions![index],
            installed: ind >= 0,
            installedExtension: ind >= 0
                ? widget.extensionsStore.installedExtensions[ind]
                : null,
          );
        },
      );
    });
  }

  @override
  bool get wantKeepAlive => true;
}
