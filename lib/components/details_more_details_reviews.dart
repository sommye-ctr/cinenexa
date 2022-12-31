import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:lottie/lottie.dart';
import 'package:mobx/mobx.dart';
import 'package:watrix/store/details/details_store.dart';

import '../resources/asset.dart';
import 'details_review_tile.dart';

class DetailsMoreDetailsReviews extends StatefulWidget {
  final DetailsStore detailsStore;
  const DetailsMoreDetailsReviews({
    Key? key,
    required this.detailsStore,
  }) : super(key: key);

  @override
  State<DetailsMoreDetailsReviews> createState() =>
      _DetailsMoreDetailsReviewsState();
}

class _DetailsMoreDetailsReviewsState extends State<DetailsMoreDetailsReviews> {
  @override
  Widget build(BuildContext context) {
    return _buildReviews();
  }

  Widget _buildReviews() {
    return Observer(builder: (context) {
      if (widget.detailsStore.reviewList.isEmpty &&
          widget.detailsStore.reviews.status == FutureStatus.pending) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if (widget.detailsStore.reviewList.isNotEmpty) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "${widget.detailsStore.totalReviews} Reviews",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: LazyLoadScrollView(
                onEndOfPage: widget.detailsStore.onReviewEndReached,
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: widget.detailsStore.reviewList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return UnconstrainedBox(
                      child: DetailsReviewTile(
                        review: widget.detailsStore.reviewList[index],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        );
      }
      return LottieBuilder.asset(
        Asset.notFound,
        repeat: true,
      );
    });
  }
}
