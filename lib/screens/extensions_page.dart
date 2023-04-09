import 'package:cinenexa/widgets/custom_back_button.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:cinenexa/components/extensions_discover.dart';
import 'package:cinenexa/components/extensions_installed.dart';
import 'package:cinenexa/store/extensions/extensions_store.dart';

import '../resources/strings.dart';
import '../resources/style.dart';

class ExtensionsPage extends StatefulWidget {
  static const String routeName = "/extensions";
  const ExtensionsPage({Key? key}) : super(key: key);

  @override
  State<ExtensionsPage> createState() => _ExtensionsPageState();
}

class _ExtensionsPageState extends State<ExtensionsPage> {
  late ExtensionsStore extensionsStore;
  late ReactionDisposer disposer1;
  late ReactionDisposer disposer2;
  late ReactionDisposer disposer3;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    extensionsStore = Provider.of<ExtensionsStore>(context);

    disposer1 = autorun((_) {
      extensionsStore.installedExtensions.toString();
      setState(() {});
    });
    disposer2 = autorun((_) {
      if (extensionsStore.error != null) {
        Style.showToast(context: context, text: extensionsStore.error!);
      }
    });
    disposer3 = autorun((_) {
      if (extensionsStore.successMessage != null) {
        Style.showToast(
            context: context, text: extensionsStore.successMessage!);
      }
    });
  }

  @override
  void dispose() {
    disposer1();
    disposer2();
    disposer3();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: CustomBackButton(),
            ),
            DefaultTabController(
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
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      child: TabBarView(
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          ExtensionsDiscover(extensionsStore: extensionsStore),
                          ExtensionsInstalled(extensionsStore: extensionsStore),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
