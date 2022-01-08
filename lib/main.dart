import 'package:flutter/material.dart';
import 'package:watrix/resources/constants.dart';
import 'package:watrix/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Constants.appName,
      debugShowCheckedModeBanner: false,
      theme: Constants.themeData,
      home: Home(),
    );
  }
}
