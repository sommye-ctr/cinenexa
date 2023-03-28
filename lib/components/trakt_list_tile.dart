import 'package:cinenexa/models/network/trakt/trakt_list.dart';
import 'package:cinenexa/resources/style.dart';
import 'package:flutter/material.dart';

class TraktListTile extends StatelessWidget {
  final TraktList list;
  const TraktListTile({required this.list, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Style.smallRoundEdgeRadius),
      ),
      child: Container(),
    );
  }
}
