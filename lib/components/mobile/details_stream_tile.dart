import 'package:cached_network_image/cached_network_image.dart';
import 'package:flag/flag_widget.dart';
import 'package:flutter/material.dart';
import 'package:cinenexa/models/network/extensions/extension_stream.dart';
import 'package:cinenexa/models/network/watch_provider.dart';
import 'package:cinenexa/utils/screen_size.dart';
import 'package:cinenexa/utils/size_formatter.dart';
import '../../resources/style.dart';

class DetailsStreamTile extends StatelessWidget {
  final ExtensionStream? extensionStream;
  final WatchProvider? provider;
  final Function(
      ExtensionStream? extensionStream, WatchProvider? watchProvider)? onClick;
  final bool? hidePlayButton;
  const DetailsStreamTile({
    Key? key,
    this.extensionStream,
    this.onClick,
    this.provider,
    this.hidePlayButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onClick?.call(extensionStream, provider),
      child: Container(
        width: ScreenSize.getPercentOfWidth(context, 0.45),
        child: Stack(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(Style.smallRoundEdgeRadius),
                  bottomRight: Radius.circular(Style.smallRoundEdgeRadius),
                  topLeft: Radius.circular(Style.smallRoundEdgeRadius),
                  topRight: Radius.circular(Style.smallRoundEdgeRadius),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    _buildRow(
                      context: context,
                      trailing: CachedNetworkImage(
                        maxHeightDiskCache: 24,
                        maxWidthDiskCache: 24,
                        imageUrl: (extensionStream?.extension?.icon ??
                                provider?.logo) ??
                            "",
                        errorWidget: (context, url, error) {
                          return Icon(Icons.error_outline_outlined);
                        },
                      ),
                      body: Expanded(
                        child: Text(
                          (extensionStream?.extension?.name ??
                                  provider?.name) ??
                              "",
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    ..._buildQuality(context),
                    ..._buildSize(context),
                    ..._buildSeeds(context),
                    ..._buildFlag(context),
                  ],
                ),
              ),
            ),
            if (hidePlayButton == null)
              Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: Icon(
                      Icons.play_arrow,
                    ),
                    onPressed: () => onClick?.call(extensionStream, provider),
                  )),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildFlag(context) {
    if (extensionStream?.country == null) return [Container()];
    List<String>? strings = extensionStream?.country?.split('|');
    return [
      Style.getVerticalSpacing(context: context),
      SingleChildScrollView(
        child: Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 10,
          runSpacing: 10,
          children: List.generate(
            strings?.length ?? 0,
            (index) => Flag.fromString(
              strings![index],
              height: 25,
              width: 25 * 4 / 3,
              borderRadius: Style.smallRoundEdgeRadius,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    ];
  }

  List<Widget> _buildQuality(context) {
    if (extensionStream?.quality == null) return [Container()];
    return [
      Style.getVerticalSpacing(context: context),
      _buildRow(
        trailing: Icon(Icons.hd),
        body: Text("${extensionStream?.quality}p"),
        context: context,
      ),
    ];
  }

  List<Widget> _buildSize(context) {
    if (extensionStream?.size == null) return [Container()];
    return [
      Style.getVerticalSpacing(context: context),
      _buildRow(
        trailing: Icon(Icons.sd_storage, color: Colors.green),
        body: Text(SizeFormatter.getSizeString(extensionStream?.size ?? 0)),
        context: context,
      ),
    ];
  }

  List<Widget> _buildSeeds(context) {
    if (extensionStream?.seeds == null) return [Container()];
    return [
      Style.getVerticalSpacing(context: context),
      _buildRow(
        trailing: Icon(
          Icons.person,
          color: Colors.blue,
        ),
        body: Text("${extensionStream?.seeds}"),
        context: context,
      ),
    ];
  }

  Widget _buildRow(
      {required Widget trailing, required Widget body, required context}) {
    return Row(
      children: [
        trailing,
        Style.getVerticalHorizontalSpacing(context: context),
        body,
      ],
    );
  }
}
