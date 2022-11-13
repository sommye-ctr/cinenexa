import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:watrix/components/vlc_controls.dart';
import 'package:watrix/models/network/base_model.dart';

import '../models/network/movie.dart';
import '../models/network/tv.dart';

class VlcPlayerPage extends StatefulWidget {
  static const routeName = "/videoPlayer";

  final String url;
  final int? id;
  final BaseModel? baseModel;
  final Movie? movie;
  final Tv? show;
  final int? season, episode;
  final double? progress;
  const VlcPlayerPage({
    Key? key,
    required this.url,
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

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    init();
  }

  void init() {
    if (widget.url.contains(magnetRegex)) {
      print("here url ${widget.url}");
      channel.receiveBroadcastStream({
        "url": widget.url,
      }).handleError((error) {
        print("error in torrent : ${error}");
      }).listen((event) {
        print("received $event");
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
    print("here witout");
    controller = VlcPlayerController.network(
      widget.url,
      autoInitialize: true,
      autoPlay: true,
      options: VlcPlayerOptions(),
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
