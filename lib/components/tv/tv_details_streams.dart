import 'package:cinenexa/components/mobile/details_stream_tile.dart';
import 'package:cinenexa/components/tv/tv_details_drawer.dart';
import 'package:cinenexa/models/network/extensions/extension_stream.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../store/details/details_store.dart';

class TvDetailsStreams extends StatefulWidget {
  final DetailsStore detailsStore;
  const TvDetailsStreams({required this.detailsStore, Key? key})
      : super(key: key);

  @override
  State<TvDetailsStreams> createState() => _TvDetailsStreamsState();
}

class _TvDetailsStreamsState extends State<TvDetailsStreams> {
  int selectedExtension = 0;

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return TvDetailsDrawer<ExtensionStream>(
        leftChildren: widget.detailsStore.loadedStreamsExtensions
            .map((element) => element.name ?? "")
            .toList(),
        rightChildren: widget.detailsStore.loadedStreams
            .where((element) =>
                element.extension ==
                widget.detailsStore.loadedStreamsExtensions
                    .elementAt(selectedExtension))
            .toList(),
        onLeftChildClicked: (index) {
          selectedExtension = index;
          setState(() {});
        },
        onRightWidgetBuild: (item) => Container(
          child: DetailsStreamTile(
            extensionStream: item as ExtensionStream,
          ),
        ),
      );
    });
  }
}
