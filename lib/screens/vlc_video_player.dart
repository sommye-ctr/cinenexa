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
  final BaseModel? baseModel;
  final Movie? movie;
  final Tv? show;
  final int? season, episode;
  final double? progress;
  const VlcPlayerPage({
    Key? key,
    required this.url,
    this.baseModel,
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
  late VlcPlayerController controller;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    controller = VlcPlayerController.network(
      widget.url,
      autoInitialize: true,
      autoPlay: true,
      options: VlcPlayerOptions(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      child: Container(
        child: Stack(
          children: [
            LayoutBuilder(
              builder: (p0, p1) {
                return SizedBox.expand(
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: p1.maxWidth * (16 / 9),
                      height: p1.maxHeight,
                      child: VlcPlayer(
                        aspectRatio: 16 / 9,
                        controller: controller,
                        placeholder: Center(child: CircularProgressIndicator()),
                      ),
                    ),
                  ),
                );
              },
            ),
            VlcControls(
              controller: controller,
              baseModel: widget.baseModel,
              episode: widget.episode,
              season: widget.season,
              movie: widget.movie,
              show: widget.show,
              progress: widget.progress,
            ),
          ],
        ),
      ),
    );
  }
}
