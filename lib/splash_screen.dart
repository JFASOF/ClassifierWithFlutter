import 'package:flutter/material.dart';
import 'package:flutter_classifier_cd/constants/app_constants.dart';
import 'package:flutter_classifier_cd/home_screen.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

class SplashCD extends StatefulWidget {
  const SplashCD({Key? key}) : super(key: key);

  @override
  _SplashCDState createState() => _SplashCDState();
}

class _SplashCDState extends State<SplashCD> {
  @override
  Widget build(BuildContext context) {
    return SplashScreenView(
      navigateRoute: const HomeScreen(),
      duration: 3000,
      imageSrc:"assets/cat.png" ,
      text:AppConstants.appTitle,
      textStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: Colors.deepOrange[400]),
          backgroundColor: Colors.black,
    );
  }
}
