import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:watrix/components/vlc_controls.dart';
import 'package:watrix/models/network/base_model.dart';
import 'package:watrix/models/network/extensions/extension_stream.dart';
import 'package:watrix/resources/style.dart';

import '../models/network/movie.dart';
import '../models/network/tv.dart';

class VlcPlayerPage extends StatefulWidget {
  static const routeName = "/videoPlayer";

  final int? id;
  final BaseModel? baseModel;
  final Movie? movie;
  final Tv? show;
  final int? season, episode;
  final double? progress;
  final ExtensionStream extensionStream;

  const VlcPlayerPage({
    Key? key,
    required this.extensionStream,
    this.baseModel,
    this.id,
    this.movie,
    this.show,
    this.episode,
    this.season,
    this.progress,
  }) : super(key: key);

  @override
  State<VlcPlayerPage> createState() => _VlcPlayerPageState();
}

class _VlcPlayerPageState extends State<VlcPlayerPage> {
  static const String TORRENT_STREAM_EVENT_NAME = "watrix/torrentStream";

  static const EventChannel channel = EventChannel(TORRENT_STREAM_EVENT_NAME);
  static final magnetRegex = RegExp(
    r'magnet:\?xt=urn:[a-z0-9]+:[a-z0-9]{32}',
    unicode: true,
    caseSensitive: false,
  );

  late VlcPlayerController controller;
  bool loading = true;
  late AdaptiveThemeMode mode;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    mode = AdaptiveTheme.of(context).mode;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (mounted) AdaptiveTheme.of(context).setDark();
    });

    init();
  }

  void init() {
    if (widget.extensionStream.magnet != null) {
      channel.receiveBroadcastStream({
        "url": widget.extensionStream.magnet,
        "index": widget.extensionStream.fileIndex,
      }).handleError((error) {
        Style.showToast(text: "Error: ${error}");
      }).listen((event) {
        if (event is String) {
          controller = VlcPlayerController.network(
            event,
            autoInitialize: true,
            autoPlay: true,
            options: VlcPlayerOptions(),
          );
          setState(() {
            loading = false;
          });
        }
      });
      return;
    }
    controller = VlcPlayerController.network(
      widget.extensionStream.url!,
      autoInitialize: true,
      autoPlay: true,
      options: VlcPlayerOptions(),
      hwAcc: HwAcc.full,
    );
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemChrome.setPreferredOrientations(
            [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
        AdaptiveTheme.of(context).setThemeMode(mode);
        return true;
      },
      child: Material(
        color: Colors.black,
        child: Container(
          child: Stack(
            children: [
              LayoutBuilder(
                builder: (p0, p1) {
                  if (loading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return SizedBox.expand(
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: SizedBox(
                        width: p1.maxWidth * (16 / 9),
                        height: p1.maxHeight,
                        child: VlcPlayer(
                          aspectRatio: 16 / 9,
                          controller: controller,
                          placeholder:
                              Center(child: CircularProgressIndicator()),
                        ),
                      ),
                    ),
                  );
                },
              ),
              if (!loading)
                VlcControls(
                  controller: controller,
                  stream: widget.extensionStream,
                  baseModel: widget.baseModel,
                  episode: widget.episode,
                  season: widget.season,
                  movie: widget.movie,
                  show: widget.show,
                  progress: widget.progress,
                  id: widget.id,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
