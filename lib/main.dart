import 'package:flutter/material.dart';
import 'package:flutter_classifier_cd/constants/app_constants.dart';
import 'package:flutter_classifier_cd/splash_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: AppConstants.appTitle,
      home: SplashCD(),
      debugShowCheckedModeBanner: false,
    );
  }
}