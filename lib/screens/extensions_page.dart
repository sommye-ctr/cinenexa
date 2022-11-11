import 'package:flutter/material.dart';
import 'package:watrix/components/extensions_extension_tile.dart';
import 'package:watrix/services/temp_data.dart';
import 'package:watrix/utils/screen_size.dart';

import '../resources/strings.dart';
import '../resources/style.dart';

class ExtensionsPage extends StatelessWidget {
  const ExtensionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(
              indicator: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(Style.largeRoundEdgeRadius),
                ),
                color: Theme.of(context).colorScheme.primary,
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorPadding: EdgeInsets.all(8),
              splashBorderRadius: BorderRadius.circular(40),
              isScrollable: true,
              tabs: [
                Tab(
                  text: Strings.discover,
                ),
                Tab(
                  text: Strings.installed,
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  _buildDiscover(context),
                  Text("Installed"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDiscover(context) {
    return Padding(
      padding:
          EdgeInsets.only(top: ScreenSize.getPercentOfHeight(context, 0.02)),
      child: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        children: [
          ExtensionTile(
            extension: TempData().extensions[0],
          ),
          ExtensionTile(
            extension: TempData().extensions[1],
          ),
        ],
      ),
    );
  }
}
