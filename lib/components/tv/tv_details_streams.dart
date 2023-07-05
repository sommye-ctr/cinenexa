import 'package:cinenexa/components/mobile/details_stream_tile.dart';
import 'package:cinenexa/components/tv/tv_details_drawer.dart';
import 'package:cinenexa/models/network/extensions/extension_stream.dart';
import 'package:cinenexa/utils/link_opener.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../resources/style.dart';
import '../../store/details/details_store.dart';
import '../../widgets/glassy_container.dart';

class TvDetailsStreams extends StatefulWidget {
  final DetailsStore detailStore;
  TvDetailsStreams({required this.detailStore, Key? key}) : super(key: key);

  @override
  State<TvDetailsStreams> createState() => _TvDetailsStreamsState();
}

class _TvDetailsStreamsState extends State<TvDetailsStreams> {
  TvDetailsDrawerController? controller;

  late Widget drawer;

  @override
  void initState() {
    controller = TvDetailsDrawerController(getSelectedStreams(0), []);
    drawer = Expanded(
      child: TvDetailsDrawer<ExtensionStream>.controller(
        blurBg: false,
        controller: controller,
        onRightWidgetClicked: (item) async {
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
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      if (widget.detailStore.loadedStreams.isNotEmpty) {
        controller?.changeChildren(
          getSelectedStreams(0),
          left: widget.detailStore.loadedStreamsExtensions
              .map((element) => element.name ?? "")
              .toList(),
        );
      }

      return GlassyContainer(
        child: Column(
          children: [
            Style.getVerticalSpacing(context: context),
            if (widget.detailStore.isStreamLoading)
              Center(child: CircularProgressIndicator()),
            drawer,
          ],
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
