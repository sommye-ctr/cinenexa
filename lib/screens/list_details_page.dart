import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinenexa/components/search_result_tile.dart';
import 'package:cinenexa/models/network/base_model.dart';
import 'package:cinenexa/models/network/trakt/trakt_list.dart';
import 'package:cinenexa/resources/style.dart';
import 'package:cinenexa/services/constants.dart';
import 'package:cinenexa/services/network/trakt_oauth_client.dart';
import 'package:cinenexa/services/network/trakt_repository.dart';
import 'package:cinenexa/services/network/utils.dart';
import 'package:cinenexa/utils/screen_size.dart';
import 'package:cinenexa/widgets/rounded_image.dart';
import 'package:flutter/material.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class ListDetailsPage extends StatefulWidget {
  static const String routeName = "/list_details";

  final TraktList traktList;
  const ListDetailsPage({required this.traktList, Key? key}) : super(key: key);

  @override
  State<ListDetailsPage> createState() => _ListDetailsPageState();
}

class _ListDetailsPageState extends State<ListDetailsPage> {
  int page = 1;

  @override
  void initState() {
    super.initState();
    _fetch();
  }

  void _fetch() async {
    widget.traktList.setItems(
        await TraktRepository(client: TraktOAuthClient()).getListItems(
      listId: widget.traktList.traktId,
      page: page,
    ));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (context) {
        if (widget.traktList.items.isEmpty) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView(
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: ScreenSize.getPercentOfHeight(context, 0.35),
                  child: CachedNetworkImage(
                    fit: BoxFit.fill,
                    imageUrl: Utils.getPosterUrl(
                        widget.traktList.items[0].posterPath ?? ""),
                  ),
                ),
                BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 20,
                    sigmaY: 20,
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        UnconstrainedBox(
                          child: RoundedImage(
                            image: Utils.getBackdropUrl(
                                widget.traktList.items[0].backdropPath!),
                            width: ScreenSize.getPercentOfWidth(context, 0.95),
                            ratio: Constants.backdropAspectRatio,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              widget.traktList.name,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.thumb_up_alt_rounded),
                            )
                          ],
                        ),
                        Style.getVerticalSpacing(context: context),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            LazyLoadScrollView(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.traktList.items.length,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  BaseModel model = widget.traktList.items[index];
                  return SearchResultTile(
                    image: Utils.getPosterUrl(model.posterPath!),
                    year: model.releaseDate ?? "",
                    overview: model.overview ?? "",
                    title: model.title ?? "",
                    vote: model.voteAverage ?? 0,
                    type: Utils.getStringByBasemodelType(model.type!),
                  );
                },
              ),
              onEndOfPage: () {
                setState(() {
                  page++;
                });
              },
            ),
          ],
        );
      }),
    );
  }
}
