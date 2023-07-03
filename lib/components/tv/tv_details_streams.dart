import 'package:cinenexa/components/mobile/details_stream_tile.dart';
import 'package:cinenexa/components/tv/tv_details_drawer.dart';
import 'package:cinenexa/models/network/extensions/extension_stream.dart';
import 'package:cinenexa/utils/link_opener.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../store/details/details_store.dart';

class TvDetailsStreams extends StatefulWidget {
  final DetailsStore detailStore;
  TvDetailsStreams({required this.detailStore, Key? key}) : super(key: key);

  @override
  State<TvDetailsStreams> createState() => _TvDetailsStreamsState();
}

class _TvDetailsStreamsState extends State<TvDetailsStreams> {
  TvDetailsDrawerController? controller;

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      if (controller == null)
        controller = TvDetailsDrawerController(getSelectedStreams(0));

      return TvDetailsDrawer<ExtensionStream>.controller(
        leftChildren: widget.detailStore.loadedStreamsExtensions
            .map((element) => element.name ?? "")
            .toList(),
        controller: controller,
        onRightWidgetClicked: (item) async {
          print("ck8ck");
          await LinkOpener.navigateToVideoPlayer(
            baseModel: widget.detailStore.baseModel,
            id: widget.detailStore.baseModel.id!,
            context: context,
            ep: widget.detailStore.progress?.episodeNo,
            season: widget.detailStore.progress?.seasonNo,
            progress: widget.detailStore.progress,
            movie: widget.detailStore.movie,
            tv: widget.detailStore.tv,
            stream:
                widget.detailStore.progress?.stream ?? item as ExtensionStream,
            detailsStore: widget.detailStore,
            showHistory: widget.detailStore.showHistory,
          );
        },
        onLeftChildClicked: (index) {
          controller?.changeChildren(getSelectedStreams(index));
        },
        onRightWidgetBuild: (item) => Container(
          child: DetailsStreamTile(
            extensionStream: item as ExtensionStream,
          ),
        ),
      );
    });
  }

  List<ExtensionStream> getSelectedStreams(int index) {
    return widget.detailStore.loadedStreams
        .where((element) =>
            element.extension?.id ==
            widget.detailStore.loadedStreamsExtensions.elementAt(index).id)
        .toList();
  }
}
