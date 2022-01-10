import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:watrix/resources/strings.dart';
import 'package:watrix/resources/style.dart';
import 'package:watrix/widgets/bottom_nav_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    return MaterialApp(
      title: Strings.appName,
      debugShowCheckedModeBanner: false,
      theme: Style.themeData,
      home: BottomNavBar(),
    );
  }
}
