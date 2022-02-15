import 'package:flutter/material.dart';
import 'package:watrix/resources/style.dart';
import 'package:watrix/services/requests.dart';
import 'package:watrix/utils/screen_size.dart';
import 'package:watrix/widgets/custom_checkbox_list.dart';
import 'package:watrix/widgets/custom_rangle_slider.dart';

import '../models/genre.dart';

class FilterPage extends StatelessWidget {
  const FilterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenSize.getPercentOfWidth(context, 0.02),
      ),
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Text(
            "Sort By",
            style: Style.headingStyle,
          ),
          SizedBox(
            height: ScreenSize.getPercentOfHeight(context, 0.01),
          ),
          CustomCheckBoxList(
            type: CheckBoxListType.list,
            children: [
              "Released",
              "Popularity",
              "Vote",
              "Rating",
            ],
          ),
          Divider(),
          Text(
            "Vote Average",
            style: Style.headingStyle,
          ),
          SizedBox(
            height: ScreenSize.getPercentOfHeight(context, 0.01),
          ),
          CustomRangeSlider(
            values: RangeValues(0, 10),
          ),
          Divider(),
          Text(
            "Year",
            style: Style.headingStyle,
          ),
          SizedBox(
            height: ScreenSize.getPercentOfHeight(context, 0.01),
          ),
          CustomRangeSlider(
            values: RangeValues(
              DateTime.now().year - 100,
              DateTime.now().year.toDouble(),
            ),
          ),
          Divider(),
          Text(
            "Genres",
            style: Style.headingStyle,
          ),
          SizedBox(
            height: ScreenSize.getPercentOfHeight(context, 0.01),
          ),
          FutureBuilder<List<Genre>>(
            future: Requests.genreFuture(Requests.movieGenre),
            builder: genreBuildGrid,
          ),
        ],
      ),
    );
  }

  Widget genreBuildGrid(
      BuildContext context, AsyncSnapshot<List<Genre>> snapshot) {
    if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
      return CustomCheckBoxList(
        type: CheckBoxListType.grid,
        children: snapshot.data!.map((e) => e.name).toList(),
        delegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 16 / 9,
          crossAxisSpacing: ScreenSize.getPercentOfWidth(context, 0.025),
          mainAxisSpacing: ScreenSize.getPercentOfWidth(context, 0.025),
        ),
        /*itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                snapshot.data![index].name,
              ),
            ),
          );
        },*/
      );
    }
    return Container();
  }
}
