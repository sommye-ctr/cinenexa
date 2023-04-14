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
import 'package:cinenexa/widgets/custom_back_button.dart';
import 'package:cinenexa/widgets/rounded_image.dart';
import 'package:flutter/material.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:like_button/like_button.dart';

import 'details_page.dart';

class ListDetailsPage extends StatefulWidget {
  static const String routeName = "/list_details";

  final TraktList traktList;
  final bool isPersonal;
  const ListDetailsPage(
      {required this.traktList, this.isPersonal = false, Key? key})
      : super(key: key);

  @override
  State<ListDetailsPage> createState() => _ListDetailsPageState();
}

class _ListDetailsPageState extends State<ListDetailsPage> {
  int page = 1;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    if (!(widget.isPersonal && widget.traktList.items.isNotEmpty)) {
      loading = true;
      _fetch();
    }
  }

  void _fetch({bool initial = true}) async {
    List<BaseModel> items =
        await TraktRepository(client: TraktOAuthClient()).getListItems(
      listId: widget.traktList.traktId,
      page: page,
      personal: widget.isPersonal,
    );

    if (initial) {
      widget.traktList.setItems(items);
    } else {
      widget.traktList.items.addAll(items);
    }

    loading = false;
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
        return LazyLoadScrollView(
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: widget.traktList.items.length + 1,
            separatorBuilder: (context, index) => Divider(),
            itemBuilder: (context, index) {
              if (index == 0) {
                return _buildHeading();
              }
              BaseModel model = widget.traktList.items[index - 1];
              return SearchResultTile(
                image: Utils.getPosterUrl(model.posterPath!),
                year: model.releaseDate ?? "",
                overview: model.overview ?? "",
                title: model.title ?? "",
                vote: model.voteAverage ?? 0,
                type: Utils.getStringByBasemodelType(model.type!),
                onClick: () {
                  Navigator.pushNamed(
                    context,
                    DetailsPage.routeName,
                    arguments: model,
                  );
                },
              );
            },
          ),
          onEndOfPage: () {
            if (!loading) {
              setState(() {
                loading = true;
                page++;
                _fetch(initial: false);
              });
            }
          },
        );
      }),
    );
  }

  Widget _buildHeading() {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: ScreenSize.getPercentOfHeight(context, 0.35),
          child: CachedNetworkImage(
            fit: BoxFit.fill,
            imageUrl: Utils.getBackdropUrl(
                widget.traktList.items[0].backdropPath ?? ""),
          ),
        ),
        BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 20,
            sigmaY: 20,
          ),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomBackButton(),
                Center(
                  child: UnconstrainedBox(
                    child: RoundedImage(
                      image: Utils.getBackdropUrl(
                          widget.traktList.items[0].backdropPath!),
                      width: ScreenSize.getPercentOfWidth(context, 0.95),
                      ratio: Constants.backdropAspectRatio,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 4,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.traktList.name,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("${widget.traktList.itemCount} items"),
                          LikeButton(
                            likeCount: widget.traktList.likes,
                            likeBuilder: (isLiked) => Icon(
                              Icons.thumb_up_alt_rounded,
                              color: isLiked ? Colors.blue : Colors.grey,
                            ),
                            bubblesColor: BubblesColor(
                              dotPrimaryColor: Colors.blue,
                              dotSecondaryColor: Colors.cyanAccent,
                            ),
                            circleColor: CircleColor(
                              start: Colors.blueGrey,
                              end: Colors.cyanAccent,
                            ),
                            countBuilder: (likeCount, isLiked, text) => Text(
                              text,
                              style: TextStyle(
                                color: isLiked ? Colors.blue : Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Style.getVerticalSpacing(context: context),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
